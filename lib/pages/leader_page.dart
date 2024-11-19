import '../service/appwrite.dart';
import '../shared/app_constants.dart';
//import 'dart:typed_data';

import 'package:concert/shared/custom_shadow_text.dart';
//import 'package:drop_cap_text/drop_cap_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/anchk_conductor_notifier.dart';
import '../provider/anchk_preacher_notifier.dart';
import '../service/debug_logger.dart';
import '../shared/drop_cap_text.dart';
import '../shared/responsiveness.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class LeadersPage extends ConsumerWidget {
  const LeadersPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "LeadersPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conductorItemState = ref.watch(anchkConductorNotifierProvider);
    final preacherItemState = ref.watch(anchkPreacherNotifierProvider);
    debugLogger.debug(
        className: className,
        method: "build()",
        printToConsole: AppConstants.debug,
        value:
            "The conductorItemState name is ${conductorItemState[0].name.toString()}  ${conductorItemState[0].message.toString()}");
    debugLogger.debug(
        className: className,
        method: "build()",
        printToConsole: AppConstants.debug,
        value:
            "The preacherItemState name is ${preacherItemState.name.toString()}");

    return (conductorItemState.isEmpty || preacherItemState.name == "Initial")
        ? const SplashWidget()
        : const SingleChildScrollView(
            child: LeadersWidget(),
          );
  }
}

class LeadersWidget extends StatelessWidget {
  const LeadersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isiPadScreen(context)
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConductorWidget(),
                SizedBox(
                  height: 50,
                ),
                PreacherWidget(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ConductorWidget(),
                    ],
                  ),
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
                      PreacherWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class PreacherWidget extends ConsumerWidget {
  const PreacherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(anchkPreacherNotifierProvider);
    return Column(
      children: [
        CustomShadowText(
          text: "詠團團牧",
          size: headerTextSize,
          shadows: [shadowLightBlueBG],
        ),
        CustomCard(
          message: itemState.message.toString(),
          //  photoFile: itemState.photoFile as Uint8List,
          photo: itemState.photo.toString(),
          dropCapPosition: DropCapPosition.end,
        ),
      ],
    );
  }
}

class ConductorWidget extends ConsumerWidget {
  const ConductorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(anchkConductorNotifierProvider);
    return Column(
      children: [
        CustomShadowText(
          text: "詠團指揮",
          size: headerTextSize,
          shadows: [shadowLightBlueBG],
        ),
        for (var i in itemState)
          CustomCard(
            message: i.message.toString(),
            //   photoFile: i.photoFile as Uint8List,
            photo: i.photo.toString(),
            dropCapPosition: DropCapPosition.start,
          ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.message,
//      required this.photoFile,
    required this.photo,
    required this.dropCapPosition,
  });
  final String message;
//  final Uint8List photoFile;
  final String photo;
  final DropCapPosition dropCapPosition;
  @override
  Widget build(BuildContext context) {
    double size = 14;
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = ResponsiveWidget.isSmallScreen(context)
        ? screenWidth < 330
            ? size
            : screenWidth >= 300 && screenWidth < 400
                ? size + 2
                : size + 3
        : ResponsiveWidget.isMediumScreen(context)
            ? size + 8
            : size + 10;
    var appwrite = ApiService.instance;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.6),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropCapText(
          message.toString(),
          dropCapPosition: dropCapPosition,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontFamily: defaultFont,
              fontSize: responsiveFontSize,
              color: dark,
              height: 1.5,
              fontWeight: FontWeight.bold),
          dropCap: DropCap(
            width: 180,
            height: 180 * (4 / 3),
            child: ClipOval(
              child: Image.network(
                "https://${appwrite.getHost()}/v1/storage/buckets/default/files/$photo/view?project=${appwrite.getProject()}&mode=admin",
                fit: BoxFit.cover,
              ),
              /**
              Image.memory(
                photoFile,
                fit: BoxFit.cover,
              ),
               */
            ),
          ),
        ),
      ),
    );
  }
}
