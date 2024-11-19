import 'package:concert/shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';

import 'shared/custom_appbar.dart';
import 'shared/custom_bottom_bar.dart';
import 'shared/custom_navbar.dart';
import 'shared/custom_navigator.dart';
import 'shared/custom_slogon.dart';
import 'shared/custom_tabbar.dart';
import 'shared/route.dart';
import 'shared/responsiveness.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://47457b5319f0ab647956e033ef2c660c@o4506873846497280.ingest.us.sentry.io/4506873848528896';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const ProviderScope(child: MyApp())),
  );
}

/// void main() {
///  runApp(const ProviderScope(child: MyApp()));
///}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/auth': (context) => const MyAuthPage(),
      }, //  home: const MyHomePage(),
    );
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool smallScreen = width < ResponsiveWidget.getiPadScreenSize();
    return Scaffold(
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
    );
  }
}
