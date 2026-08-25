import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

class DesktopIconWidget extends ConsumerWidget {
  final DesktopIcon icon;
  const DesktopIconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewportSize = MediaQuery.of(context).size;

    return GestureDetector(
      onDoubleTap: () => ref
          .read(windowManagerProvider.notifier)
          .openApp(icon, viewportSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon.icon.icon, size: 48, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            icon.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              shadows: [
                Shadow(
                  color: Colors.black87,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
