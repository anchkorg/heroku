import 'package:concert/service/debug_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugLoggerNotifier extends StateNotifier<DebugLogger> {
  DebugLoggerNotifier(this.ref) : super(DebugLogger.instance);
  Ref ref;
  List<String> searchedApiLog = [];

  void search({String key = ''}) async {
    searchedApiLog = state.apiLog;
    List<String> dummyLog = [];
    if (key.isEmpty) {
      searchedApiLog = state.apiLog;
    } else {
      dummyLog.addAll(
          state.apiLog.where((element) => element.contains(key)).toList());
      searchedApiLog = dummyLog;
    }
    state = state;
  }
}

final debugLoggerNotifierProvider =
    StateNotifierProvider<DebugLoggerNotifier, DebugLogger>((ref) {
  return DebugLoggerNotifier(ref);
});

final debugLoggerSearchNotifierProvider = FutureProvider<List<String>>((ref) {
  final searchText = ref.watch(searchTextProvider);
  final repository = ref.watch(debugLoggerNotifierProvider);

  if (searchText.isNotEmpty) {
    final result = repository.apiLog
        .where((element) => element.contains(searchText))
        .toList();
    return result;
  }
  return repository.apiLog;
});

final searchTextProvider = StateProvider<String>((ref) => '');
