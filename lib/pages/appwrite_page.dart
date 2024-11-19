import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/appwrite_notifier.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';

class AppwritePage extends ConsumerWidget {
  const AppwritePage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "AppwritePage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomText(
      text: ref.read(appwriteNotifierProvider.notifier).session!.ip.toString(),
    );
  }
}
