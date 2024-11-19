import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

class CounterPage extends ConsumerWidget {
  const CounterPage({
    super.key,
  });
  void _incrementCounter(WidgetRef ref) {
    ref.read(counterStateProvider.notifier).state++;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${ref.watch(counterStateProvider)}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              _incrementCounter(ref);
            },
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }
}
