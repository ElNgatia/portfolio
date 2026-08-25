import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/constants.dart';
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

        const Positioned(
          right: 24,
          bottom: kTaskbarHeight + 24,
          child: _HeroTagline(),
        ),

        const DesktopLayerStack(),
      ],
    );
  }
}

class _HeroTagline extends StatelessWidget {
  const _HeroTagline();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Elvis Ngatia',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Flutter Mobile Engineer · Building polished apps for Android & iOS',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
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

