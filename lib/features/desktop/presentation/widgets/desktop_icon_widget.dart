import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';

class DesktopIconWidget extends ConsumerWidget {
  final DesktopIcon icon;
  const DesktopIconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      // onDoubleTap: () => ref.read(windowManagerProvider.notifier).open(icon.appType),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon.icon, width: 48, height: 48),
          const SizedBox(height: 4),
          Text(icon.title, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
