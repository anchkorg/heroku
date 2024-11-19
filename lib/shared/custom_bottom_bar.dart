import 'package:concert/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/current_menu_notifer.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'app_constants.dart';
import 'custom_navigator.dart';
import 'responsiveness.dart';
import 'route.dart';

class CustomBottomBar extends ConsumerWidget {
  const CustomBottomBar({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "CustomBottomBar";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    bool smallMediumScreen = width < ResponsiveWidget.getiPadScreenSize();
    bool smallScreen = width < ResponsiveWidget.getMediumScreenSize();
    const String methodName = "build()";

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: smallScreen
          ? 40
          : smallMediumScreen
              ? 45
              : 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(text: "@2024 ${AppConstants.appTitle}"),
            (AppConstants.deployment != DeploymentMode.production)
                ? CustomText(text: "Environment: ${AppConstants.deployment}")
                : Container(),
            InkWell(
                onTap: () {
                  try {
                    debugLogger.debug(
                      className: className,
                      method: methodName,
                      printToConsole: AppConstants.debug,
                      value:
                          "Loading the ${className.toString()} in $methodName",
                    );
                    ref
                        .read(currentAllItemsStateProvider.notifier)
                        .update(allItemsRoutes.length - 3);
                    debugLogger.debug(
                      className: className,
                      method: "GestureDetector(onTap)",
                      printToConsole: AppConstants.debug,
                      value:
                          "The item ${allItemsRoutes[allItemsRoutes.length - 3].name.toString()}",
                    );
                    ref.read(activeItem.notifier).state =
                        allItemsRoutes[allItemsRoutes.length - 3].name;
                    ref.read(navigatorKeyStateProvider).currentState!.pushNamed(
                        allItemsRoutes[allItemsRoutes.length - 3].route);
                  } catch (e, stackTrace) {
                    debugLogger.debug(
                        captureException: true,
                        throwable: e,
                        stackTrace: stackTrace,
                        className: className,
                        method: methodName,
                        printToConsole: AppConstants.debug,
                        value:
                            "error with code ${e.toString()} and message ${stackTrace.toString()}");
                  }
                },
                child: const CustomText(text: AppConstants.version)),
          ],
        ),
      ),
    );
  }
}
