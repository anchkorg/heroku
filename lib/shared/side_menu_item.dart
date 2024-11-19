import 'package:flutter/material.dart';

import 'drawer_menu_item.dart';
import 'menu_item_widgets.dart';
import 'responsiveness.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;

  const SideMenuItem({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      itemName: itemName,
      onTap: onTap,
      menuItemType: (ResponsiveWidget.isCustomSize(context))
          ? MenuItemType.column
          : MenuItemType.row,
    );
  }
}
