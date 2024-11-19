import 'package:flutter/material.dart';

import 'route.dart';
import 'style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveMenuLine extends ConsumerWidget {
  const ActiveMenuLine({super.key, required this.itemName});
  final String itemName;
  static Color textColor = dark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String activeItemValue = ref.read(activeItem);
    return ((activeItemValue == itemName))
        ? Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              width: 3,
              height: 72,
              color: textColor,
            ),
          )
        : Container();
  }
}
