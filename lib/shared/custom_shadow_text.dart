import 'package:flutter/material.dart';

import 'responsiveness.dart';
import 'style.dart';

class CustomShadowText extends StatelessWidget {
  final String text;
  final List<Shadow> shadows;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final bool softWrap;

  const CustomShadowText({
    super.key,
    required this.text,
    this.size = 14,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.shadows = const [],
    this.softWrap = true,
  });
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = ResponsiveWidget.isSmallScreen(context)
        ? screenWidth < 330
            ? size
            : screenWidth >= 300 && screenWidth < 400
                ? size + 2
                : screenWidth >= 400 && screenWidth < 700
                    ? size + 4
                    : size + 5
        : ResponsiveWidget.isMediumScreen(context)
            ? size + 8
            : size + 10;
    TextStyle style = TextStyle(
        fontFamily: defaultFont,
        fontSize: responsiveFontSize, // default is 16,
        color: color, // default is Colors.black,
        fontWeight: weight,
        decoration: textDecoration,
        shadows: shadows,
        height: 1.5);
    return Text.rich(
      TextSpan(
        text: text,
        style: style,
      ),
    );
  }
}
