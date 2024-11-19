import 'package:concert/shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/appwrite_notifier.dart';
import '../provider/current_menu_notifer.dart';
import '../service/debug_logger.dart';
import 'custom_navigator.dart';
import 'custom_text.dart';
import 'responsiveness.dart';
import 'route.dart';
import 'style.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "CustomAppBar";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String methodName = "build()";
    final accountState = ref.watch(appwriteNotifierProvider);
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value:
          "Ref.watch(appwriteNotifierProvider).loginType.toString() is ${ref.watch(appwriteNotifierProvider).loginType}",
    );
    return AppBar(
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 40, child: Image.asset(AppConstants.logoPath)),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomText(
                    text: AppConstants.appTitle,
                    size: standardTextSize,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: ResponsiveWidget.isSmallScreen(context)
                ? 100 +
                    ref
                            .watch(appwriteNotifierProvider)
                            .loginType
                            .length
                            .toDouble() *
                        8
                : ResponsiveWidget.isSmallScreen(context)
                    ? 150 +
                        ref
                                .watch(appwriteNotifierProvider)
                                .loginType
                                .length
                                .toDouble() *
                            8
                    : 200 +
                        ref
                                .watch(appwriteNotifierProvider)
                                .loginType
                                .length
                                .toDouble() *
                            8,
            child: InkWell(
              onTap: () {
                debugLogger.debug(
                  className: className,
                  method: "GestureDetector(onTap)",
                  printToConsole: AppConstants.debug,
                  value:
                      "The accountState.loginType ${accountState.loginType.toString()}",
                );
                if (accountState.loginType == "訪客") {
                  ref
                      .read(currentAllItemsStateProvider.notifier)
                      .update(allItemsRoutes.length - 2);
                  debugLogger.debug(
                    className: className,
                    method: "GestureDetector(onTap)",
                    printToConsole: AppConstants.debug,
                    value:
                        "The item ${allItemsRoutes[allItemsRoutes.length - 2].name.toString()}",
                  );
                  ref.read(activeItem.notifier).state =
                      allItemsRoutes[allItemsRoutes.length - 2].name;
                  ref.read(navigatorKeyStateProvider).currentState!.pushNamed(
                      allItemsRoutes[allItemsRoutes.length - 2].route);
                } else {
                  ref
                      .read(currentAllItemsStateProvider.notifier)
                      .update(allItemsRoutes.length - 1);
                  debugLogger.debug(
                    className: className,
                    method: "GestureDetector(onTap)",
                    printToConsole: AppConstants.debug,
                    value:
                        "The item ${allItemsRoutes[allItemsRoutes.length - 1].name.toString()}",
                  );
                  ref.read(activeItem.notifier).state =
                      allItemsRoutes[allItemsRoutes.length - 1].name;
                  ref.read(navigatorKeyStateProvider).currentState!.pushNamed(
                      allItemsRoutes[allItemsRoutes.length - 1].route);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: allItemsRoutes[allItemsRoutes.length - 1].name,
                    color: dark,
                    size: standardTextSize,
                    weight: FontWeight.normal,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: active.withOpacity(.5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundColor: light,
                        child: Icon(
                          Icons.person_outline,
                          color: dark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
