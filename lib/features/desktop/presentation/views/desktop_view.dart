import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/desktop/desktop.dart';
import 'package:portfolio/features/settings/settings.dart';

class DesktopView extends ConsumerWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icons = ref.watch(desktopIconsProvider);
    final wallpaper =
        ref.watch(settingsProvider.select((s) => s.wallpaper));

    return Stack(
      children: [
        Positioned.fill(child: _WallpaperBackground(wallpaper: wallpaper)),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 24,
              runSpacing: 16,
              children: icons
                  .map((icon) => DesktopIconWidget(icon: icon))
                  .toList(),
            ),
          ),
        ),

        const DesktopLayerStack(),
      ],
    );
  }
}

class _WallpaperBackground extends StatelessWidget {
  const _WallpaperBackground({required this.wallpaper});

  final WallpaperOption wallpaper;

  @override
  Widget build(BuildContext context) {
    if (wallpaper.isAsset) {
      return Image.asset(wallpaper.assetPath!, fit: BoxFit.cover);
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: wallpaper.gradientColors!,
        ),
      ),
    );
  }
}

