import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_text.dart';
import 'route.dart';
import 'style.dart';

enum MenuItemType { row, column }

class MenuItemWidgets extends ConsumerWidget {
  final String itemName;
  final String activeItemValue;
  final MenuItemType menuItemType;

  const MenuItemWidgets(
      {required this.itemName,
      required this.activeItemValue,
      required this.menuItemType,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> menuItemWidgets = [];
    menuItemWidgets.add(Padding(
      padding: const EdgeInsets.all(16),
      child: returnIconFor(itemName),
    ));
    menuItemWidgets.add(Flexible(
        child: CustomText(
      text: itemName,
      color: (activeItemValue == itemName) ? menuActiveColor : menuColor,
      size: standardTextSize,
      weight: FontWeight.normal,
    )));
    return (menuItemType == MenuItemType.row)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: menuItemWidgets.toList(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: menuItemWidgets.toList(),
          );
  }
}
