import 'package:appwrite/enums.dart';
import '../shared/app_constants.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:concert/provider/practice_info_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'anchk_concert_notifier.dart';
import 'anchk_conductor_notifier.dart';
import 'anchk_mission_notifier.dart';
import 'anchk_organization_notifier.dart';
import 'anchk_preacher_notifier.dart';
import 'anchk_requirement_notifier.dart';
import 'anchk_video_notifier.dart';
import 'contact_info_notifier.dart';
import 'history_notifier.dart';
import 'userprefs_notifier.dart';
import 'what_news_notifier.dart';
import 'package:get_ip_address/get_ip_address.dart';

class AppwriteNotifier extends StateNotifier<ApiService> {
  AppwriteNotifier(this.ref) : super(ApiService.instance);
  DebugLogger debugLogger = DebugLogger.instance;
  Ref ref;
  final String className = "AppwriteNotifier";
  bool firstLogin = true;
  bool isSubscribe = false;

  static Session? _session;
  Session? get session => _session;

  late RealtimeSubscription subscription;

  createAnonymousSession() async {
    String methodName = 'createAnonymousSession';
    if (isSubscribe) unsubscribe();
    await state.createAnonymousSession().then((value) {
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value: "Success to createAnonymousSession",
      );
      subscribe();
      if (firstLogin) {
        loadData();
      }
      firstLogin = false;
      getSession();
      getAccount();

      state = state;
    });
  }

  void signInWithProvider({required OAuthProvider provider}) async {
    String methodName = 'signInWithProvider';
    if (isSubscribe) unsubscribe();
    _session = await state.signInWithProvider(provider: provider) as Session?;
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value: "Success to signInWithProvider",
    );
    ref.read(userPrefsNotifierProvider.notifier).load();

    subscribe();

    getSession();
    getAccount();
    if (firstLogin) {
      loadData();
    }
    firstLogin = false;
    state = state;
  }

  void logout() async {
    await state.logout().then((value) => unsubscribe());
    state = state;
  }

  subscribe() async {
    subscription = await state.subscribe(['documents']) as RealtimeSubscription;
    isSubscribe = true;
    debugLogger.debug(
      className: className,
      method: "subscribe()",
      printToConsole: AppConstants.debug,
      value: "subscription subscribed",
    );

    subscription.stream.listen((event) {
      loadData();
      debugLogger.debug(
        className: className,
        method: "subscribe() subscription.stream.listen((event)",
        printToConsole: AppConstants.debug,
        value: "subscription event triggered",
      );
    });
  }

  unsubscribe() {
    String methodName = 'unsubscribe';
    try {
      subscription.close();
      isSubscribe = false;
      debugLogger.debug(
        className: className,
        method: "unsubscribe())",
        printToConsole: AppConstants.debug,
        value: "subscription event subscription.close()",
      );
    } on AppwriteException catch (e, stackTrace) {
      debugLogger.debug(
          captureException: true,
          throwable: e,
          stackTrace: stackTrace,
          className: className,
          method: methodName,
          value:
              "subscription event error with code ${e.code} and message ${e.message}");
    } catch (e) {
      debugLogger.debug(
          className: className,
          method: methodName,
          value: "subscription event error with message ${e.toString()}");
    }
  }

  void getSession() async {
    const String methodName = "getSession()";
    await state.getSession();
    if (state.isSession) await state.getAccount();
    if (state.status == AuthStatus.authenticated) {
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value:
            "GetSession information for AuthStatus.authenticated: state.status is (${state.status})",
      );
      ref.read(userPrefsNotifierProvider.notifier).load();
      loadData();
      subscribe();
    } else {
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value:
            "GetSession information for AuthStatus.other: state.status is (${state.status})",
      );
      await createAnonymousSession();
      loadData();
      subscribe();
    }
    state = state;
  }

  void getAccount() async {
    // const String methodName = "getAccount()";

    await state.getAccount();
    state = state;
  }

  void init() async {
    const String methodName = "init()";
    try {
      /// Initialize Ip Address
      var ipAddress = IpAddress(type: RequestType.json);

      /// Get the IpAddress based on requestType.
      dynamic data = await ipAddress.getIpAddress();
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value: "Client IP address is ${data.toString()}",
      );
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      debugLogger.debug(
        className: className,
        method: methodName,
        printToConsole: AppConstants.debug,
        value: "Client IP address exception message is ${exception.message}",
      );
    }
    getSession();
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value: "Starting the login checking (${state.status})",
    );
  }

  void loadData() {
    const String methodName = "loadData()";
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value: "Starting the loadData",
    );
    //ref.read(whatNewsNotifierProvider.notifier).init();
    ref.read(whatNewsNotifierProvider.notifier).load();
    ref.read(anchkOrganizationNotifierProvider.notifier).load();
    ref.read(anchkMissionNotifierProvider.notifier).load();
    ref.read(anchkConductorNotifierProvider.notifier).load();
    ref.read(anchkPreacherNotifierProvider.notifier).load();
    ref.read(historyNotifierProvider.notifier).load();
    ref.read(practiceInfoNotifierProvider.notifier).load();
    ref.read(anchkRequirementNotifierProvider.notifier).load();
    ref.read(contactNotifierProvider.notifier).load();
    ref.read(anchkVideoNotifierProvider.notifier).load();
    ref.read(anchkConcertNotifierProvider.notifier).load();
  }
}

final appwriteNotifierProvider =
    StateNotifierProvider<AppwriteNotifier, ApiService>((ref) {
  return AppwriteNotifier(ref);
});
