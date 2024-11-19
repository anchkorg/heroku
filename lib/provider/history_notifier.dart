import '../shared/app_constants.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../entity/event_category_model.dart';
import '../entity/event_history_model.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class HistoryNotifier extends StateNotifier<List<EventCategory>> {
  HistoryNotifier(this.apiServce) : super([]);
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "HistoryNotifier";
  final String databaseId = 'default';
  final String categoryCollectionId = 'category';
  final String eventCollectionId = 'event';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
    DocumentList? categoryRes;
    DocumentList? eventRes;
    List<EventCategory> underscoreAnchkorgEventCategory;

    categoryRes = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: categoryCollectionId,
      queries: queries,
    );
    eventRes = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: eventCollectionId,
      queries: queries,
    );
    underscoreAnchkorgEventCategory =
        categoryRes!.convertTo<EventCategory>((eventCategoryP0) {
      EventCategory underscoreEventCategory;
      String underscoreName;
      underscoreName = eventCategoryP0['name'].toString();
      List<EventHistory> underscoreAnchkEventHostory = eventRes!.convertTo(
          (p0) => EventHistory.fromMap((Map<String, dynamic>.from(p0))));
      underscoreEventCategory = EventCategory.byCategoryName(
          underscoreName, underscoreAnchkEventHostory);
      return underscoreEventCategory;
    });

    state = underscoreAnchkorgEventCategory;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${categoryRes.total.toString()} and The HistoryNotifier state Lenght is ${state.length.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final historyNotifierProvider =
    StateNotifierProvider<HistoryNotifier, List<EventCategory>>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return HistoryNotifier(apiServce);
});
