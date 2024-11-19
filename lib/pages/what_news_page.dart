//import 'dart:typed_data';

import 'package:concert/entity/what_news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/appwrite_notifier.dart';
import '../provider/current_menu_notifer.dart';
import '../provider/what_news_notifier.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import '../shared/app_constants.dart';
import '../shared/custom_navigator.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/route.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class WhatNewsPage extends ConsumerWidget {
  const WhatNewsPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "WhatNewsPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double bannerWidth = ResponsiveWidget.isSmallScreen(context)
        ? 460
        : ResponsiveWidget.isLargeScreen(context)
            ? 690
            : 575;
    double bannerHeight = ResponsiveWidget.isSmallScreen(context)
        ? 48
        : ResponsiveWidget.isLargeScreen(context)
            ? 72
            : 60;
    const String methodName = "build()";

    final state = ref.watch(whatNewsNotifierProvider);
    var isInitial = ref.read(whatNewsNotifierProvider.notifier).isInitial;
    var progressState = ref.watch(whatsNewProgressNotifierProvider);
    debugLogger.debug(
      className: className,
      method: "build()",
      printToConsole: AppConstants.debug,
      value:
          "The whatNewsNotifierProvider state Lenght is ${state.length.toString()}",
    );
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value:
          "Ref.watch(appwriteNotifierProvider).loginType.toString() is ${ref.watch(appwriteNotifierProvider).loginType}",
    );

    return (state.isEmpty)
        ? const SplashWidget()
        : LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        if (isInitial!)
                          CustomText(
                              text: "努力加載中.....${progressState.toString()}"),
                        for (final item in state
                            .where((element) => !element.isCompleted!)
                            .toList())
                          GestureDetector(
                            onTap: () {
                              if (!item.isCompleted!) {
                                if (item.event == "香港浸會大學") {
                                  ref
                                      .read(currentMenuStateProvider.notifier)
                                      .update(1);
                                  ref.read(activeItem.notifier).state =
                                      concertPageDisplayName;
                                  ref
                                      .read(navigatorKeyStateProvider)
                                      .currentState!
                                      .pushNamed(sideMenuItemRoutes[1].route);
                                }
                              }
                            },
                            child: WhatNewsItemWidget(
                              item: item,
                            ),
                          ),
                        AnchkorgBannerWidget(
                            bannerHeight: bannerHeight,
                            bannerWidth: bannerWidth),
                        for (final item in state
                            .where((element) => element.isCompleted!)
                            .toList())
                          WhatNewsItemWidget(
                            item: item,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class AnchkorgBannerWidget extends StatelessWidget {
  const AnchkorgBannerWidget({
    super.key,
    required this.bannerHeight,
    required this.bannerWidth,
  });

  final double bannerHeight;
  final double bannerWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 32,
      ),
      child: Container(
        height: bannerHeight,
        width: bannerWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppConstants.anchkorgBanner),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class WhatNewsItemWidget extends StatelessWidget {
  const WhatNewsItemWidget({
    super.key,
    required this.item,
  });
  final WhatNews item;
  @override
  Widget build(BuildContext context) {
    List<Shadow> shadow = const [
      Shadow(
        blurRadius: 10.0,
//        color: Colors.teal,
        color: Colors.white,
        offset: Offset(5, 5),
      )
    ];
    double cardWidth = ResponsiveWidget.isSmallScreen(context)
        ? 400
        : ResponsiveWidget.isLargeScreen(context)
            ? 650
            : 500;
    var appwrite = ApiService.instance;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: cardWidth,
              height: 9 / 16 * cardWidth,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: item.isCompleted!
                        ? const [
                            BoxShadow(
                              color: Color.fromRGBO(253, 253, 150, 1),
                              blurRadius: 20.0,
                            ),
                          ]
                        : const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 20.0,
                            ),
                          ],
                    image: DecorationImage(
                        //image: MemoryImage(item.bgPhotoFile as Uint8List),
                        image: NetworkImage(
                            "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${item.bgPhotoId}/view?project=${appwrite.getProject()}&mode=admin"),
                        fit: BoxFit.cover)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 5 + (cardWidth / 15.5) / 2,
                      child: SizedBox(
                        width: cardWidth * (1 / 2),
                        height: 10 / 16 * (cardWidth * (1 / 2)),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  //image: MemoryImage(item.photoFile as Uint8List),
                                  image: NetworkImage(
                                      "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${item.photoId}/view?project=${appwrite.getProject()}&mode=admin"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: (9 / 16 * cardWidth) / 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: cardWidth * (1 / 2),
                          color: Colors.white10.withOpacity(0.5),
                          child: CustomText(
                            text: item.event.toString(),
                            textAlign: TextAlign.center,
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: Colors.black,
                            shadow: shadow,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: ((9 / 16 * cardWidth) / 5) - 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: cardWidth * (1 / 2),
                          color: Colors.white10.withOpacity(0.5),
                          child: CustomText(
                            text: item.place.toString(),
                            textAlign: TextAlign.center,
                            size: standardTextSize,
                            weight: FontWeight.normal,
                            color: Colors.black,
                            shadow: shadow,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: item.isCompleted!
                          ? const Icon(
                              Icons.done_outline,
                              color: Colors.green,
                              size: 60,
                            )
                          : const Icon(
                              Icons.run_circle,
                              color: Colors.yellow,
                              size: 50,
                            ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: SizedBox(
                        width: cardWidth / 7,
                        height: (cardWidth / 15.5) * 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(61, 61, 61, 1),
                                Colors.white,
                              ],
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "${item.year}年",
                              textAlign: TextAlign.center,
                              size: smallTextSize,
                              weight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5 + (cardWidth / 7),
                      child: SizedBox(
                        width: cardWidth / 11,
                        height: (cardWidth / 15.5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            color: blackColor,
                          ),
                          child: Center(
                            child: CustomText(
                              text: item.day! < 10
                                  ? "0${item.day}"
                                  : item.day.toString(),
                              textAlign: TextAlign.center,
                              size: smallTextSize,
                              weight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5 + (cardWidth / 15.5),
                      left: 5 + (cardWidth / 7),
                      child: SizedBox(
                        width: cardWidth / 11,
                        height: (cardWidth / 15.5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: CustomText(
                              text: "${item.month}月",
                              textAlign: TextAlign.center,
                              size: smallTextSize,
                              weight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Expanded newMethod() {
    return Expanded(
      child: SizedBox(
        height: 500,
        child: CustomText(text: item.event.toString()),
      ),
    );
  }
}
