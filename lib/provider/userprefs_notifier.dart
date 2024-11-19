import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:concert/shared/app_constants.dart';
import '../entity/user_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class UserPrefsNotifier extends StateNotifier<UserPrefs> {
  UserPrefsNotifier(this.apiServce) : super(UserPrefs());
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "UserPrefsNotifier";
  final String databaseId = 'default';
  final String categoryCollectionId = 'category';
  final String eventCollectionId = 'event';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];
  reset() {
    state = UserPrefs();
  }

  load() async {
    String methodName = "load()";
    UserPrefs underscoreTmp = UserPrefs();
    Uint8List underscorePhotoTmp = Uint8List(0);
    Preferences? data;
    _loading = true;
    data = await apiServce.getUserPreferences();

    (data!.data).forEach(
      (key, value) async {
        debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value:
              "The key is ${key.toString()} ,The value is ${value.toString()}, The underscorePhotoTmp file length is ${underscorePhotoTmp.length}",
        );
        if (key == "ProfilePhoto") {
          await apiServce.getFile(value).then(
            (photofile) async {
              underscorePhotoTmp = photofile;
              debugLogger.debug(
                className: className,
                method: methodName,
                printToConsole: AppConstants.debug,
                value:
                    "Inside (key == ProfilePhoto) The key is ${key.toString()} ,The value is ${value.toString()} , The photofile file length is ${photofile.length}, The underscorePhotoTmp file length is ${underscorePhotoTmp.length}",
              );
              underscoreTmp = UserPrefs(
                chineseName: data!.data['ChineseName'],
                voicePart: data.data['Voice'],
                description: data.data['Description'],
                photoFile: underscorePhotoTmp,
              );
              state = underscoreTmp;
              _loading = false;
              debugLogger.debug(
                className: className,
                method: methodName,
                printToConsole: AppConstants.debug,
                value:
                    "The data is ${data.data.toString()} ,The UserPrefsNotifier state is ${state.toString()} and the loading is ${loading.toString()}",
              );
            },
          );
        }
      },
    );
  }
}

final userPrefsNotifierProvider =
    StateNotifierProvider<UserPrefsNotifier, UserPrefs>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return UserPrefsNotifier(apiServce);
});
