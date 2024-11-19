//import 'dart:typed_data';

import 'package:concert/provider/anchk_organization_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/anchk_mission_notifier.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import '../shared/app_constants.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class IntroductionPage extends ConsumerWidget {
  const IntroductionPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "IntroductionPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationItemState = ref.watch(anchkOrganizationNotifierProvider);
    final missionItemState = ref.watch(anchkMissionNotifierProvider);
    return (organizationItemState.name == "Initial" ||
            missionItemState.name == "Initial")
        ? const SplashWidget()
        : LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: const IntrinsicHeight(
                  child: IntroductionWidget(),
                ),
              ),
            );
          });
  }
}

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isiPadScreen(context)
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrganizationWidget(),
                SizedBox(
                  height: 50,
                ),
                MissionName(),
                MissionWidget(),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: OrganizationWidget(),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MissionName(),
                      MissionWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class MissionName extends StatelessWidget {
  const MissionName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: "詠團宗旨",
      size: standardTextSize,
      weight: FontWeight.bold,
      color: redWine,
    );
  }
}

class MissionWidget extends ConsumerWidget {
  const MissionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(anchkMissionNotifierProvider);
    var appwrite = ApiService.instance;

    return Column(children: [
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final item in itemState.message!.toList())
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectionArea(
                          child: CustomText(
                            text:
                                '${(itemState.message!.indexOf(item) + 1).toString()}.  ',
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SelectionArea(
                            child: CustomText(
                              text: item.text.toString(),
                              size: standardTextSize,
                              weight: FontWeight.bold,
                              textAlign: TextAlign.left,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            const SizedBox(
              height: 24,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${itemState.photo}/view?project=${appwrite.getProject()}&mode=admin",
                fit: BoxFit.cover,
              ),
              /** 
              Image.memory(
                itemState.photoFile as Uint8List,
                fit: BoxFit.cover,
              ),*/
            ),
          ])
    ]);
  }
}

class OrganizationWidget extends ConsumerWidget {
  const OrganizationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(anchkOrganizationNotifierProvider);
    var appwrite = ApiService.instance;

    return Column(children: [
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final item in itemState.message!.toList())
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: SelectionArea(
                        child: CustomText(
                          text: item.text.toString(),
                          size: standardTextSize,
                          weight: FontWeight.bold,
                          color: blackColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  itemState.message!.toList().indexOf(item) <
                          itemState.message!.toList().length - 1
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Container(
                            height: 20,
                            width: 200,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppConstants.divider),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            const SizedBox(
              height: 24,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${itemState.photo}/view?project=${appwrite.getProject()}&mode=admin",
                fit: BoxFit.cover,
              ),
              /**
              Image.memory(
                itemState.photoFile as Uint8List,
                fit: BoxFit.cover,
              ), */
            ),
          ])
    ]);
  }
}
