import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/current_menu_notifer.dart';
import 'custom_text.dart';
import 'style.dart';
import 'package:flutter/material.dart';

import 'app_constants.dart';
import 'custom_box_decoration.dart';
import 'route.dart';
import 'side_menu_item.dart';
import '../service/debug_logger.dart';
import 'custom_navigator.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key, required this.sideMenuItemRoutes});
  final List<CustomMenuItem> sideMenuItemRoutes;
  final String className = "CustomNavBar";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DebugLogger debugLogger = DebugLogger.instance;
    final current = ref.watch(currentMenuStateProvider);
    return Container(
      decoration: customBoxDecoration(),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: CustomText(
                text: AppConstants.appTitle,
                color: dark,
              ),
              accountEmail: CustomText(
                text: AppConstants.appEmail,
                color: dark,
              ),
              currentAccountPicture: CircleAvatar(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green),
                    shape: BoxShape.circle,
                  ),
                  child: const Image(
                    image: AssetImage(AppConstants.logoPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItemRoutes
                  .map((e) => SideMenuItem(
                      itemName: e.name,
                      onTap: () {
                        ref
                            .read(currentMenuStateProvider.notifier)
                            .update(sideMenuItemRoutes.indexOf(e));
                        ref
                            .read(currentAllItemsStateProvider.notifier)
                            .update(sideMenuItemRoutes.indexOf(e));
                        debugLogger.debug(
                          className: className,
                          method: "GestureDetector(onTap)",
                          printToConsole: AppConstants.debug,
                          value:
                              "Current value is ${current.toString()} when tap the item ${sideMenuItemRoutes[sideMenuItemRoutes.indexOf(e)].name.toString()}",
                        );
                        ref.read(activeItem.notifier).state = e.name;
                        ref
                            .read(navigatorKeyStateProvider)
                            .currentState!
                            .pushNamed(sideMenuItemRoutes[
                                    sideMenuItemRoutes.indexOf(e)]
                                .route);
                        Navigator.pop(context);
                      }))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
