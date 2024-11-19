import '../shared/app_constants.dart';
import 'package:concert/service/appwrite.dart';
//import 'package:concert/shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appwrite/enums.dart';

import '../provider/appwrite_notifier.dart';
import '../provider/current_menu_notifer.dart';
import '../provider/userprefs_notifier.dart';
import '../service/debug_logger.dart';
import '../shared/custom_navigator.dart';
import '../shared/custom_text.dart';
import '../shared/route.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "AuthPage";

  signInWithProvider(
      OAuthProvider provider, ApiService state, WidgetRef ref) async {
    //await state.signInWithProvider(provider: provider);
    // String methodName = "signInWithProvider";
    await ref
        .read(appwriteNotifierProvider)
        .signInWithProvider(provider: provider);
    await ref.read(userPrefsNotifierProvider.notifier).load();
    await ref.read(appwriteNotifierProvider.notifier).subscribe();
    ref
        .read(currentAllItemsStateProvider.notifier)
        .update(allItemsRoutes.length - 1);
    debugLogger.debug(
      className: className,
      method: "GestureDetector(onTap)",
      printToConsole: AppConstants.debug,
      value:
          "The item ${allItemsRoutes[allItemsRoutes.length - 1].name.toString()}",
    );

    ref.read(activeItem.notifier).state =
        allItemsRoutes[allItemsRoutes.length - 1].name;
    ref
        .read(navigatorKeyStateProvider)
        .currentState!
        .pushNamed(allItemsRoutes[allItemsRoutes.length - 1].route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String methodName = "build()";
    final state = ref.watch(appwriteNotifierProvider);
    double height = MediaQuery.of(context).size.height;
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value:
          "Ref.watch(appwriteNotifierProvider).loginType.toString() is ${ref.watch(appwriteNotifierProvider).loginType} and height of profileWidget is ${height.toString()}",
    );
    return authWidget(state, ref);
  }

  LayoutBuilder authWidget(ApiService state, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraint) {
        const String methodName = "profileWidget()";
        double height = MediaQuery.of(context).size.height;
        debugLogger.debug(
          className: className,
          method: methodName,
          printToConsole: AppConstants.debug,
          value: "height of profileWidget is ${height.toString()}",
        );

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    loginState(state),
                    standardHeight(),
                    signInButton(state, ref),
                    standardHeight(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column signInButton(ApiService state, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              CustomText(text: "可以使用以下的社交媒體登入"),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 50,
            ),
            // appleIcon(state, ref),
            googleIcon(state, ref),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
      ],
    );
  }

  SizedBox standardHeight() {
    return const SizedBox(
      height: 50,
    );
  }

  Row loginState(ApiService state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: "${state.loginType}登入"),
        CustomText(text: "使用者名稱：${state.username.toString()}"),
      ],
    );
  }

  ElevatedButton googleIcon(ApiService state, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => signInWithProvider(OAuthProvider.google, state, ref),
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/google_icon.svg', width: 12),
          const SizedBox(
            width: 16,
          ),
          const CustomText(
            text: "Google 登入",
            size: 14,
          )
        ],
      ),
    );
  }

  ElevatedButton appleIcon(ApiService state, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => signInWithProvider(OAuthProvider.apple, state, ref),
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: Colors.white),
      child: SvgPicture.asset('assets/images/apple_icon.svg', width: 12),
    );
  }
}
