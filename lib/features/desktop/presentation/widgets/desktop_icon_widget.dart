import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/features/desktop/desktop.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

class DesktopIconWidget extends ConsumerWidget {
  final DesktopIcon icon;
  const DesktopIconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewportSize = MediaQuery.of(context).size;
    final isMobile = viewportSize.width < kMobileBreakpoint;

    // Clamp window size so it never exceeds the available viewport area.
    final windowWidth = math.min(600.0, viewportSize.width);
    final windowHeight =
        math.min(400.0, viewportSize.height - kTaskbarHeight);
    final windowSize = Size(windowWidth, windowHeight);

    final center =
        viewportSize.center(Offset.zero) -
        Offset(windowSize.width / 2, windowSize.height / 2);

    return GestureDetector(
      onDoubleTap: () => ref
          .read(windowManagerProvider.notifier)
          .openWindow(
            WindowEntity(
              id: icon.id,
              icon: icon.icon,
              title: icon.title,
              // On mobile open maximised; keep restore state so the user can
              // un-maximise to a sensibly-sized floating window.
              position: isMobile ? Offset.zero : center,
              size: isMobile
                  ? Size(viewportSize.width, viewportSize.height - kTaskbarHeight)
                  : windowSize,
              isMaximized: isMobile,
              preMaximizePosition: isMobile ? center : null,
              preMaximizeSize: isMobile ? windowSize : null,
            ),
          ),
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
