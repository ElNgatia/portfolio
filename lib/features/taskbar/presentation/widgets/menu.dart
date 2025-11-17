import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class StartMenu extends ConsumerWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      // padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () {},
                  ),
                  const Text('Files'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () {},
                  ),
                  const Text('Files'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
