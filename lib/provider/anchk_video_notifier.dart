import '../shared/app_constants.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../entity/youtube_model.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class AnchkVideoNotifier extends StateNotifier<List<YoutubeModel>> {
  AnchkVideoNotifier(this.apiServce) : super([]);
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "AnchkVideoNotifier";
  final String databaseId = 'default';
  final String collectionId = 'videoList';
//  final List<String> queries = [appwrite.Query.orderAsc('\$id')];
  final List<String> queries = [appwrite.Query.orderDesc('id')];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];
  static int? _currentVideoIndex = 0;
  int? get currentVideoIndex => _currentVideoIndex;

  void updateCurrentVideo(int value) => _currentVideoIndex = value;

  void load() async {
    List<YoutubeModel> underscoreTmp = [];
    DocumentList? data;

    data = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
    underscoreTmp = data!.convertTo<YoutubeModel>(
        (p0) => YoutubeModel.fromMap((Map<String, dynamic>.from(p0))));

    state = underscoreTmp;
    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${data.total.toString()} and The AnchkVideoNotifier state Lenght is ${state.length.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final anchkVideoNotifierProvider =
    StateNotifierProvider<AnchkVideoNotifier, List<YoutubeModel>>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return AnchkVideoNotifier(apiServce);
});
