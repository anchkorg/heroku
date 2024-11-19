import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/anchk_requirement_notifier.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class RequirementPage extends ConsumerWidget {
  const RequirementPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "RequirementPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(anchkRequirementNotifierProvider);
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (final item in state.message!.toList())
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  state.message!.indexOf(item) ==
                                          state.message!.length - 1
                                      ? Row(
                                          children: [
                                            //const SizedBox(
                                            //  width: 28,
                                            //),
                                            Icon(Icons.star_border_sharp,
                                                size: 22, color: blackColor),
                                            const SizedBox(
                                              width: 24,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            CustomText(
                                              text:
                                                  '${(state.message!.indexOf(item) + 1).toString()}.  ',
                                              size: standardTextSize,
                                              weight: FontWeight.bold,
                                              color: blackColor,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                  Expanded(
                                    flex: 1,
                                    child: CustomText(
                                      text: item.text.toString(),
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            width: 50,
                          ),
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
