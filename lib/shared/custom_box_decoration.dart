import 'package:flutter/material.dart';

import 'app_constants.dart';

class CustomBoxDecoration extends StatelessWidget {
  const CustomBoxDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

BoxDecoration customBoxDecoration() => const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(AppConstants.bgImage), fit: BoxFit.cover),
    );

BoxDecoration customTextBoxDecoration() => const BoxDecoration(
      border: Border(
        left: BorderSide(
          color: Colors.black,
          width: 10.0,
        ),
        right: BorderSide(
          color: Colors.black,
          width: 10.0,
        ),
        top: BorderSide(
          color: Color(0xff6ae792),
          width: 15.0,
        ),
        bottom: BorderSide(
          color: Color(0xff6ae792),
          width: 8.0,
        ),
      ),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.red,
        ],
      ),
    );
