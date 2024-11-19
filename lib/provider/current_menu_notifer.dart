import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentMenuNotifer extends StateNotifier<int> {
  CurrentMenuNotifer() : super(0);
  void update(int index) async {
    state = index;
  }
}

final currentMenuStateProvider =
    StateNotifierProvider<CurrentMenuNotifer, int>((ref) {
  return CurrentMenuNotifer();
});

class CurrentAllItemsNotifer extends StateNotifier<int> {
  CurrentAllItemsNotifer() : super(0);
  void update(int index) async {
    state = index;
  }
}

final currentAllItemsStateProvider =
    StateNotifierProvider<CurrentAllItemsNotifer, int>((ref) {
  return CurrentAllItemsNotifer();
});
