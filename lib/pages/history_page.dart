import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/event_category_model.dart';
import '../provider/history_notifier.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "HistoryPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyNotifierProvider);
    List<Widget> first = [];
    for (final item in state.sublist(0, 4).toList()) {
      first.add(HistoryItemWidget(
        item: item,
      ));
    }
    List<Widget> second = [];
    for (final item in state.sublist(4).toList()) {
      second.add(HistoryItemWidget(
        item: item,
      ));
    }

    return (state.isEmpty)
        ? const SplashWidget()
        : LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: ResponsiveWidget.isiPadScreen(context)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                for (final item in state.sublist(0, 4).toList())
                                  HistoryItemWidget(
                                    item: item,
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                for (final item in state.sublist(4).toList())
                                  HistoryItemWidget(
                                    item: item,
                                  ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: first,
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: second,
                                  ),
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

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({
    super.key,
    required this.item,
  });
  final EventCategory item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: item.name.toString(),
            size: standardTextSize,
            weight: FontWeight.bold,
            color: strongpink,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: item.events
                .map<Widget>(
                  (event) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: CustomText(
                            text: event.year.toString(),
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        Expanded(
                          //                                            flex: 1,
                          child: CustomText(
                            text: event.event.toString(),
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
