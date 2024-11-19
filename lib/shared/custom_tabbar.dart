import '../shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/debug_logger.dart';
import 'custom_navigator.dart';
import 'custom_text.dart';
import 'route.dart';
import '../provider/current_menu_notifer.dart';

class CustomTabbar extends ConsumerWidget {
  const CustomTabbar(
    this.sideMenuItemRoutes, {
    super.key,
  });
  final String className = "CustomTabbar";
  final List<CustomMenuItem> sideMenuItemRoutes;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DebugLogger debugLogger = DebugLogger.instance;
    final current = ref.watch(currentMenuStateProvider);
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: sideMenuItemRoutes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(currentMenuStateProvider.notifier).update(index);
                    debugLogger.debug(
                      className: className,
                      method: "GestureDetector(onTap)",
                      printToConsole: AppConstants.debug,
                      value:
                          "Current value is ${current.toString()} when tap the item ${sideMenuItemRoutes[index].name.toString()}",
                    );
                    ref
                        .read(navigatorKeyStateProvider)
                        .currentState!
                        .pushNamed(sideMenuItemRoutes[index].route);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(5),
                    width: 150,
                    height: 45,
                    decoration: BoxDecoration(
                      color: current == index ? Colors.white70 : Colors.white54,
                      borderRadius: current == index
                          ? BorderRadius.circular(15)
                          : BorderRadius.circular(10),
                      border: current == index
                          ? Border.all(color: Colors.deepPurpleAccent, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: CustomText(
                        text: sideMenuItemRoutes[index].name,
                        color: current == index ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: current == index,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle),
                    ))
              ],
            );
          }),
    );
  }
}
