import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/debugger_notifier.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';
import '../shared/splash_widget.dart';

class DebugLoggerPage extends ConsumerWidget {
  const DebugLoggerPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "DebugLoggerPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(debugLoggerNotifierProvider);

    return (state.apiLog.isEmpty)
        ? const SplashWidget()
        : debugLoggerWidget(ref);
  }

  Padding debugLoggerWidget(WidgetRef ref) {
    ref.read(debugLoggerNotifierProvider.notifier).search();
    final apiLogProviderValue = ref.watch(debugLoggerSearchNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            Form(
              child: SafeArea(
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(searchTextProvider.notifier).update((_) => value);
                  },
                  onEditingComplete: () {},
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: apiLogProviderValue.when(
                      data: (data) {
                        return Column(
                          children: data
                              .map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      SelectionArea(
                                        child: CustomText(
                                          text: e,
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        );
                      },
                      loading: () => const SplashWidget(),
                      error: (error, stackTrace) => Text('Erro: $error'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  LayoutBuilder debugLoggerWidgetOld(WidgetRef ref) {
    ref.read(debugLoggerNotifierProvider.notifier).search();
    final apiLogProviderValue = ref.watch(debugLoggerSearchNotifierProvider);
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SafeArea(
                        child: TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            ref
                                .read(searchTextProvider.notifier)
                                .update((_) => value);
                          },
                          onEditingComplete: () {},
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      apiLogProviderValue.when(
                        data: (data) {
                          return Column(
                            children: data
                                .map((e) => CustomText(
                                      text: e,
                                    ))
                                .toList(),
                          );
                        },
                        loading: () => const SplashWidget(),
                        error: (error, stackTrace) => Text('Erro: $error'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
