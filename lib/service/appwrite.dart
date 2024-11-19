import 'dart:async';
//import 'dart:typed_data';

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_location_href/window_location_href.dart';

import '../shared/app_constants.dart';
import 'debug_logger.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
}

enum DeploymentMode {
  production,
  uat,
  development,
}

class ApiService {
  static late final ApiService _instance;
  static bool _isInstanceCreated = false;
  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  final DateTime now = DateTime.now();

  final appwrite.Client client = appwrite.Client();
  appwrite.Account? account;
  appwrite.Databases? db;
  appwrite.Avatars? avatars;
  appwrite.Storage? storage;
  appwrite.Realtime? realtime;
  late Session? _currentSession;
  bool _isSession = false;
  late User? _currentUser;
  late String _username = "訪客";
  late String _loginType = "訪客";
//  Uint8List _currentUserProfilePhoto = Uint8List(0);
//  Uint8List _anonymousProfilePhoto = Uint8List(0);
//  Uint8List get currentUserProfilePhoto => _currentUserProfilePhoto;
  AuthStatus _status = AuthStatus.uninitialized;
  late Preferences? _prefs;
  Preferences? get prefs => _prefs;
  bool get isSession => _isSession;
  Session get currentSession => _currentSession!;
  User get currentUser => _currentUser!;
  AuthStatus get status => _status;
  String get username => _username;
  String get loginType => _loginType;
  //String? get username => _currentUser?.name;
  String? get email => _currentUser?.email;
  String? get userid => _currentUser?.$id;

  final Uri? location = href == null ? null : Uri.parse(href!);

  DebugLogger debugLogger = DebugLogger.instance;
  final String className = "ApiService";

  late DateTime firstJan;
  String getProject() {
    switch (AppConstants.deployment) {
      case DeploymentMode.production:
        return AppConstants.project;
      case DeploymentMode.uat:
        return AppConstants.uatProject;
      default:
        return AppConstants.devProject;
    }
  }

  String getHost() {
    switch (AppConstants.deployment) {
      case DeploymentMode.production:
        return AppConstants.host;
      case DeploymentMode.uat:
        return AppConstants.uatHost;
      default:
        return AppConstants.devHost;
    }
  }

  String getProjectOld() => (weeksBetween(firstJan, now).remainder(2) != 0)
      ? (AppConstants.project)
      : (AppConstants.devProject);

  ApiService._internal() {
    firstJan = DateTime(now.year, 1, 1);
    debugLogger.debug(
        className: className,
        method: "ApiService._internal()",
        printToConsole: AppConstants.debug,
        value:
            "Initial Appwrite connection using ApiService on project ${getProject()} and host ${getHost()} on https://${getHost()}/v1");
    client.setEndpoint("https://${getHost()}/v1").setProject(getProject());
    account = appwrite.Account(client);
    db = appwrite.Databases(client);
    avatars = appwrite.Avatars(client);
    storage = appwrite.Storage(client);
    realtime = appwrite.Realtime(client);
    loadUser();
  }

  loadUser() async {
    const String methodName = "loadUser()";
    try {
      final user = await account!.get();
      await getAccount();

      _prefs = await getUserPreferences();
      _status = AuthStatus.authenticated;
      _currentUser = user;
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value:
              "Success to loadUser status ${status.toString()}, current User is ${currentUser.toString()} and prefs is ${prefs!.toMap()}");
    } catch (e) {
      _status = AuthStatus.unauthenticated;

      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with message ${e.toString()}");
    } finally {}
  }

  static ApiService get instance {
    if (_isInstanceCreated == false) {
      _isInstanceCreated = true;
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future createAnonymousSession() async {
    //if (status == AuthStatus.authenticated) await logout();
    const String methodName = "createAnonymousSession()";
    if ((status != AuthStatus.authenticated)) {
      try {
        return await account!.createAnonymousSession().then((value) async {
          _currentUser = await account!.get();
          _status = AuthStatus.authenticated;
          _loginType = "訪客";
          _username = "訪客";
          getUserPreferences();
          return value;
        });
      } on appwrite.AppwriteException catch (e, stackTrace) {
        debugLogger.debug(
            captureException: true,
            throwable: e,
            stackTrace: stackTrace,
            className: className,
            method: methodName,
            printToConsole: AppConstants.debug,
            value: "error with code ${e.code} and message ${e.message}");
      } catch (e) {
        debugLogger.debug(
            className: className,
            method: methodName,
            printToConsole: AppConstants.debug,
            value: "error with message ${e.toString()}");
      }
    }
  }

  Future createEmailUser(
      {required String name,
      required String email,
      required String password}) async {
    const String methodName = "createEmailUser()";
    try {
      return await account!
          .create(
              userId: appwrite.ID.unique(),
              email: email,
              password: password,
              name: name)
          .then((value) async {
        await createEmailSession(email: email, password: password);
        return value;
      });
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with message ${e.toString()}");
    }
  }

  Future createEmailSession(
      {required String email, required String password}) async {
    if (status == AuthStatus.authenticated) await logout();
    const String methodName = "createEmailSession()";
    try {
      return await account!
          .createEmailPasswordSession(email: email, password: password)
          .then((value) async {
        _currentUser = await account!.get();
        _status = AuthStatus.authenticated;
        return value;
      });
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with message ${e.toString()}");
    }
  }

  getAccount() async {
    const String methodName = "getAccount()";
    try {
      _currentUser = await account!.get();
      if (_currentUser!.email.isEmpty) {
        _username = "訪客";
        //_loginType = "訪客";
      } else {
        _username = _currentUser!.name;
        _loginType = "會員";
      }
      _currentUser = _currentUser;
      _loginType = _loginType;
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value:
              "GetAccount information: $status and username $username, loginType $loginType");
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
      _username = 'No Session';
    }
  }

  signInWithProvider({required OAuthProvider provider}) async {
    const String methodName = "signInWithProvider()";
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value: "Starting....",
    );
    //if (status == AuthStatus.authenticated) await logout();
    await logout();
    try {
      return await account!
          .createOAuth2Session(
        provider: provider,
        failure: kIsWeb ? '${location?.origin}/failure' : null,
        success: kIsWeb ? '${location?.origin}' : null,
      )
          .then((value) async {
        _currentUser = await account!.get();
        _status = AuthStatus.authenticated;
        await getAccount();
        _prefs = await getUserPreferences();
        debugLogger.debug(
            className: className,
            method: methodName,
            printToConsole: AppConstants.debug,
            value:
                "Success with account status ${status.toString()}, current User is ${currentUser.toString()} and prefs is ${prefs!.toMap()}");
        return value;
      });
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          printToConsole: AppConstants.debug,
          method: methodName,
          value: "error with message ${e.toString()}");
    } finally {
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value: "Finally....",
      );
    }
  }

  Future logout() async {
    const String methodName = "logout()";
    if (status == AuthStatus.authenticated) {
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value: "Starting logout",
      );
      try {
        return await account!.deleteSession(sessionId: 'current').then((value) {
          _status = AuthStatus.unauthenticated;

          debugLogger.debug(
              className: className,
              method: methodName,
              printToConsole: AppConstants.debug,
              value: "logout complete with $status");
        });
      } on appwrite.AppwriteException catch (e, stackTrace) {
        debugLogger.debug(
            captureException: true,
            throwable: e,
            stackTrace: stackTrace,
            className: className,
            method: methodName,
            printToConsole: AppConstants.debug,
            value: "error with code ${e.code} and message ${e.message}");
      }
    }
  }

  /// Naive [List] equality implementation.
  bool listEquals<E>(List<E> list1, List<E> list2) {
    if (identical(list1, list2)) {
      return true;
    }

    if (list1.length != list2.length) {
      return false;
    }

    for (var i = 0; i < list1.length; i += 1) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }

  /// Compares two [Uint8List]s by comparing 8 bytes at a time.
  bool memEquals(Uint8List bytes1, Uint8List bytes2) {
    if (identical(bytes1, bytes2)) {
      return true;
    }

    if (bytes1.lengthInBytes != bytes2.lengthInBytes) {
      return false;
    }

    // Treat the original byte lists as lists of 8-byte words.
    var numWords = bytes1.lengthInBytes ~/ 8;
    var words1 = bytes1.buffer.asUint8List(0, numWords);
    var words2 = bytes2.buffer.asUint8List(0, numWords);

    for (var i = 0; i < words1.length; i += 1) {
      if (words1[i] != words2[i]) {
        return false;
      }
    }

    // Compare any remaining bytes.
    for (var i = words1.lengthInBytes; i < bytes1.lengthInBytes; i += 1) {
      if (bytes1[i] != bytes2[i]) {
        return false;
      }
    }

    return true;
  }

  Future getUserPreferences() async {
    return await account!.getPrefs();
  }

  updatePreferences({required String key, required String value}) async {
    return account!.updatePrefs(prefs: {"\"$key\"": value});
  }

  Future subscribe(List<String> channels) async {
    const String methodName = "subscribe()";

    try {
      return realtime!.subscribe(channels);
    } on appwrite.AppwriteException catch (e) {
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: true,
          value: "error with code ${e.code} and message ${e.message}");
    }
  }

  Future getSession({String? sessionId}) async {
    sessionId ??= 'current';
    String methodName = "getSession($sessionId)";
    try {
      return await account!
          .getSession(sessionId: sessionId)
          .then((value) async {
        _isSession = true;
        _currentSession = value;
        debugLogger.debug(
            className: className,
            method: methodName,
            printToConsole: AppConstants.debug,
            value:
                "The session information is  ${_currentSession!.provider} and isSession is ${isSession.toString()}");
        //await getAccount();
        _status = AuthStatus.authenticated;

        return value;
      });
    } on appwrite.AppwriteException catch (e) {
      _currentSession = null;
      _isSession = false;
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value:
            "error with code ${e.code}, message ${e.message} and toString ${e.toString()}",
      );
      _status = AuthStatus.unauthenticated;
    }
  }

  Future createDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    required Map<dynamic, dynamic> data,
  }) async {
    const String methodName = "createDocument()";
    try {
      return await db!.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data,
      );
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with message ${e.toString()}");
    }
  }

  Future getFile(String fileId, {int quality = 100}) async {
    const String methodName = "getFile()";
    try {
      return await storage!
          .getFilePreview(bucketId: "default", fileId: fileId, quality: quality)
          .then((value) {
        return value;
      });
    } catch (e) {
      debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with message ${e.toString()}");
    }
  }

  Future getPhoto(String collectionName) async {
    String methodName =
        "getPhoto(collectionName is ${collectionName.toString()})";
    try {
      return await db!
          .listDocuments(collectionId: "photos", databaseId: 'default')
          .then((listDocuments) {
        Iterable<Document> documentList = listDocuments.documents.where(
            (element) => element.data["collectionName"] == collectionName);
        return documentList.first.data;
      });
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          printToConsole: AppConstants.debug,
          method: methodName,
          value: "error with message ${e.toString()}");
    }
  }

  Future listDocuments(
      {required String databaseId,
      required String collectionId,
      required List<String> queries}) async {
    String methodName =
        "getDocument(databaseId is ${databaseId.toString()} and collectionId is ${collectionId.toString()})";
    try {
      return await db!.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: queries,
      );
    } on appwrite.AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          printToConsole: AppConstants.debug,
          method: methodName,
          value: "error with message ${e.toString()}");
    }
  }
}
