import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../service/debug_logger.dart';
import 'custom_text.dart';
import 'responsiveness.dart';
import '../provider/current_menu_notifer.dart';
import 'style.dart';
import 'route.dart';

class CustomSlogon extends ConsumerWidget {
  const CustomSlogon({
    super.key,
  });
  final String className = "CustomSlogon";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentAllItemsStateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            //            height: 75,
            margin: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 0 : 6),
            child: CustomText(
              text: allItemsRoutes[current].name,
              size: standardTextSize,
              weight: FontWeight.bold,
              color: redWine,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                    text: "所以，你們要去，使萬民作我的門徒，奉父、子、聖靈的名給他們施浸。",
                    size: standardTextSize,
                    color: Colors.red,
                    weight: FontWeight.normal),
                CustomText(
                    text: "馬太福音 28:19",
                    size: standardTextSize,
                    color: Colors.red,
                    weight: FontWeight.normal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
