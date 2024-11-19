import '../shared/app_constants.dart';
import 'dart:typed_data';

import 'package:concert/entity/user_prefs.dart';
import 'package:concert/provider/userprefs_notifier.dart';
import 'package:concert/service/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/appwrite_notifier.dart';
import '../provider/current_menu_notifer.dart';
import '../service/debug_logger.dart';
import '../shared/custom_navigator.dart';
import '../shared/custom_text.dart';
import '../shared/route.dart';
import '../shared/splash_widget.dart';
//import 'package:golden_ratio_layout/golden_ratio_layout.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "ProfilePage";

  signInAnonymous(WidgetRef ref) async {
    // await state.logout();
    // await state.createAnonymousSession();
    ref.read(appwriteNotifierProvider.notifier).logout();
    ref.read(appwriteNotifierProvider.notifier).createAnonymousSession();
    ref.read(userPrefsNotifierProvider.notifier).reset();
    ref
        .read(currentAllItemsStateProvider.notifier)
        .update(allItemsRoutes.length - 2);
    debugLogger.debug(
      className: className,
      method: "GestureDetector(onTap)",
      printToConsole: AppConstants.debug,
      value:
          "The item ${allItemsRoutes[allItemsRoutes.length - 2].name.toString()}",
    );
    ref.read(activeItem.notifier).state =
        allItemsRoutes[allItemsRoutes.length - 2].name;
    ref
        .read(navigatorKeyStateProvider)
        .currentState!
        .pushNamed(allItemsRoutes[allItemsRoutes.length - 2].route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String methodName = "build()";
    final userPrefs = ref.watch(userPrefsNotifierProvider);
//    final state = ref.watch(appwriteNotifierProvider);
    double height = MediaQuery.of(context).size.height;
    debugLogger.debug(
      className: className,
      method: methodName,
      printToConsole: AppConstants.debug,
      value:
          "Ref.watch(appwriteNotifierProvider).loginType.toString() is ${ref.watch(appwriteNotifierProvider).loginType} and height of profileWidget is ${height.toString()} userPrefs is ${userPrefs.toString()}",
    );
    return (userPrefs.photoFile == null)
        ? const SplashWidget()
        : profileWidget(userPrefs, ref);
  }

  LayoutBuilder profileWidget(UserPrefs userPrefs, WidgetRef ref) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileArea(
                      onPressed: () {},
                      voicePart: userPrefs.voicePart.toString(),
                      name: userPrefs.chineseName.toString(),
                      description: userPrefs.description.toString(),
                      photoFile: userPrefs.photoFile,
                    ),
                    logoutButton(ref),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  LayoutBuilder oldProfileWidget(ApiService state, WidgetRef ref) {
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
        String voicePart = "NA";
        String description = "NA";
        String chineseName = state.username.toString();
        (state.prefs!.data).forEach((key, value) {
          if (key == "Voice") {
            voicePart = value;
          }
          if (key == "Description") {
            description = value;
          }
          if (key == "ChineseName") {
            chineseName = value;
          }
        });
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileArea(
                      onPressed: () {},
                      voicePart: voicePart,
                      name: chineseName,
                      description: description,
                      photoFile: Uint8List(0), // state.currentUserProfilePhoto,
                    ),
                    logoutButton(ref),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  ElevatedButton logoutButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        signInAnonymous(ref);
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: Colors.white),
      child: const CustomText(
        text: "登出",
        size: 22,
      ),
    );
  }
}

class ProfileArea extends StatelessWidget {
  final VoidCallback onPressed;
  final String voicePart;
  final String name;
  final String description;
  final Uint8List? photoFile;
  const ProfileArea(
      {super.key,
      required this.onPressed,
      required this.voicePart,
      required this.name,
      required this.description,
      required this.photoFile});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 80,
                ),
                ProfileVoicePart(voicePart: voicePart),
                const SizedBox(height: 10.0),
                ProfileName(name: name),
                ProfileDescription(description: description),
              ],
            ),
          ),

          //Circle Avatar
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: -75,
            child: ProfileCircleAvatar(
              photoFile: photoFile,
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileVoicePart extends StatelessWidget {
  const ProfileVoicePart({
    super.key,
    required this.voicePart,
  });

  final String voicePart;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: voicePart,
      size: 18.0,
      weight: FontWeight.bold,
    );
  }
}

class ProfileName extends StatelessWidget {
  const ProfileName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: name,
      size: 24,
      weight: FontWeight.bold,
    );
  }
}

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: description,
      size: 16.0,
    );
  }
}

class ProfileCircleAvatar extends StatelessWidget {
  const ProfileCircleAvatar({
    super.key,
    required this.photoFile,
    required this.onPressed,
  });

  final Uint8List? photoFile;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 75,
        backgroundColor: Colors.transparent,
        child: ClipOval(child: Image.memory(photoFile as Uint8List)),
      ),
    );
  }
}
