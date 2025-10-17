import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';

class DesktopIconWidget extends ConsumerWidget {
  final DesktopIcon icon;
  const DesktopIconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: make the size dynamic on user interaction
    final size = Size(600, 400);
    final center =
        MediaQuery.of(context).size.center(Offset.zero) -
        Offset(size.width / 2, size.height / 2);
    return GestureDetector(
      onDoubleTap: () => ref
          .read(windowManagerProvider.notifier)
          .openWindow(
            WindowEntity(
              id: icon.id,
              title: icon.title,
              position: center,
              size: size,
            ),
          ),
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
