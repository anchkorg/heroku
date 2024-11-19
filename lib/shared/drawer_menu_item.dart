import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'active_menu_line.dart';
import 'menu_item_widgets.dart';
import 'route.dart';
//import 'package:universe/pages/home/presentation/controllers/menu_controller.dart1';

class DrawerMenuItem extends ConsumerWidget {
  final String itemName;
  final VoidCallback onTap;
  final MenuItemType menuItemType;
  const DrawerMenuItem(
      {super.key,
      required this.itemName,
      required this.onTap,
      required this.menuItemType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String activeItemValue = ref.read(activeItem);
    MenuItemWidgets row = MenuItemWidgets(
      itemName: itemName,
      activeItemValue: activeItemValue,
      menuItemType: menuItemType,
    );
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ActiveMenuLine(
              itemName: itemName,
            ),
            Expanded(
              child: row,
            ),
          ],
        ));
  }
}
