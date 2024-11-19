import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataLoadingNotifier extends StateNotifier<bool> {
  DataLoadingNotifier() : super(true);
  Future<bool> toggled() async {
    state = !state;
    return state;
  }
}

final dataLoadingStateProvider =
    StateNotifierProvider<DataLoadingNotifier, bool>((ref) {
  return DataLoadingNotifier();
});
