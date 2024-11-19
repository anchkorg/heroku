import '../shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider/appwrite_notifier.dart';
import 'service/debug_logger.dart';
import 'shared/custom_appbar.dart';
import 'shared/custom_bottom_bar.dart';
import 'shared/custom_box_decoration.dart';
import 'shared/custom_navbar.dart';
import 'shared/custom_navigator.dart';
import 'shared/custom_slogon.dart';
import 'shared/custom_tabbar.dart';
import 'shared/route.dart';
import 'shared/responsiveness.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "MyHomePage";

  // void check(WidgetRef ref) async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    bool smallScreen = width < ResponsiveWidget.getiPadScreenSize();
    const String methodName = "build()";

    ref.read(appwriteNotifierProvider.notifier).init();

    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value:
          "ref.watch(appwriteNotifierProvider).loginType is ${ref.watch(appwriteNotifierProvider).loginType}",
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: customBoxDecoration(),
//      child: const HomeScaffold(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: smallScreen
            ? CustomNavBar(
                sideMenuItemRoutes: sideMenuItemRoutes,
              )
            : null,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: CustomAppBar(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomSlogon(),
            !smallScreen ? CustomTabbar(sideMenuItemRoutes) : Container(),
            const CustomNavigatorWidget(),
            const CustomBottomBar(),
          ],
        ),
      ),
    );
  }
}
