import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';

class DesktopView extends ConsumerWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icons = ref.watch(desktopIconsProvider);
    // final wallpaper = ref.watch(settingsProvider.select((s) => s.wallpaper));

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/windows-7.jpg',
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 24,
              runSpacing: 16,
              children: icons.map((icon) => DesktopIconWidget(icon: icon)).toList(),
            ),
          ),
        ),

        const DesktopLayerStack(),
      ],
    );
  }
}
