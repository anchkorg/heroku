import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../entity/application_info.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class ApplicationNotifier extends StateNotifier<ApplicationInfo> {
  ApplicationNotifier(this.apiServce) : super(ApplicationInfo());
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "ApplicationNotifier";
  final String databaseId = 'default';
  final String collectionId = 'applicationList';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void createDocument(Map<dynamic, dynamic> data) async {
    String documentId = _generateUniquekey(10) + data["phone"].toString();
    _loading = true;
    await apiServce.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data);
    state = ApplicationInfo.fromMap(data);
    _loading = false;
  }

  String _generateUniquekey(int length) {
    const underscoreChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random underscoreRnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length,
            (_) => underscoreChars
                .codeUnitAt(underscoreRnd.nextInt(underscoreChars.length))));
    return getRandomString(length);
  }
}

final applicationNotifierProvider =
    StateNotifierProvider<ApplicationNotifier, ApplicationInfo>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return ApplicationNotifier(apiServce);
});
