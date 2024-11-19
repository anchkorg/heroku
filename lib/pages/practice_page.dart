import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/practice_info_notifier.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class PracticePage extends ConsumerWidget {
  const PracticePage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "PracticePage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceInfoNotifierProvider);
    var appwrite = ApiService.instance;

    return (state.photo!.isEmpty)
        ? const SplashWidget()
        : LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: '練習詩間',
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: redWine,
                          ),
                          for (final item in state.practiceTime!.toList())
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SelectionArea(
                                child: CustomText(
                                  text: item.text.toString(),
                                  size: standardTextSize,
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 50,
                          ),
                          CustomText(
                            text: '練習地點',
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: redWine,
                          ),
                          for (final item in state.practicePlace!.toList())
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SelectionArea(
                                child: CustomText(
                                  text: item.text.toString(),
                                  size: standardTextSize,
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 485
                                            : 588,
                                    height:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 314
                                            : 400,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image.network(
                                              "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${state.photo}/view?project=${appwrite.getProject()}&mode=admin",
                                              fit: BoxFit.cover,
                                            ),
                                            /**
                                            Image.memory(
                                              state.photoFile!,
                                              fit: BoxFit.cover,
                                            ), */
                                          ),
                                        ),
                                        CustomText(
                                            text: "鳴謝宣道浸信會提供地圖相片",
                                            size: 12,
                                            color: dark,
                                            weight: FontWeight.normal),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
