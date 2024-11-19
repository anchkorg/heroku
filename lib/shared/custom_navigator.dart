import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'route.dart';

final navigatorKeyStateProvider =
    StateProvider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey();
});

class CustomNavigatorWidget extends ConsumerWidget {
  const CustomNavigatorWidget({
    super.key,
  });
//  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Navigator(
        key: ref.read(navigatorKeyStateProvider),
        onGenerateRoute: generateRoute,
        initialRoute: whatNewsPageRoute,
      ),
    );
  }
}
