import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/core/url_hash.dart';
import 'package:portfolio/core/window_routes.dart';
import 'package:portfolio/features/desktop/desktop.dart';
import 'package:portfolio/features/desktop/domain/entity/window_entity.dart';
import 'package:portfolio/features/desktop/presentation/provider/window_manager.dart';
import 'package:portfolio/features/settings/settings.dart';

class DesktopView extends ConsumerStatefulWidget {
  const DesktopView({super.key});

  @override
  ConsumerState<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends ConsumerState<DesktopView> {
  bool _initialRouteHandled = false;

  void _handleInitialRoute(Size viewport) {
    final slug = readHashSlug();
    if (slug == null) return;
    final windowId = windowIdForSlug(slug);
    if (windowId == null) return;
    final icon = ref
        .read(desktopIconsProvider)
        .where((icon) => icon.id == windowId)
        .firstOrNull;
    if (icon != null) {
      ref.read(windowManagerProvider.notifier).openApp(icon, viewport);
    }
  }

  void _syncUrlHash(Map<String, WindowEntity> windows) {
    final focused = windows.values
        .where((w) => w.isOpen && !w.isMinimized && w.isFocused)
        .toList()
        .lastOrNull;
    writeHashSlug(focused == null ? null : windowIdToSlug(focused.id));
  }

  @override
  Widget build(BuildContext context) {
    final icons = ref.watch(desktopIconsProvider);
    final wallpaper =
        ref.watch(settingsProvider.select((s) => s.wallpaper));
    final viewport = MediaQuery.of(context).size;
    final isMobile = viewport.width < kMobileBreakpoint;

    if (!_initialRouteHandled) {
      _initialRouteHandled = true;
      _handleInitialRoute(viewport);
    }

    ref.listen<Map<String, WindowEntity>>(windowManagerProvider,
        (previous, next) {
      final prevFocused = previous?.values
          .where((w) => w.isOpen && !w.isMinimized && w.isFocused)
          .toList()
          .lastOrNull;
      final nextFocused = next.values
          .where((w) => w.isOpen && !w.isMinimized && w.isFocused)
          .toList()
          .lastOrNull;
      if (prevFocused?.id != nextFocused?.id) {
        _syncUrlHash(next);
      }
    });

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

        Positioned(
          right: 24,
          bottom: isMobile ? kTaskbarHeight + 16 : kTaskbarHeight + 24,
          left: isMobile ? 24 : null,
          child: IgnorePointer(
            child: _HeroTagline(compact: isMobile),
          ),
        ),

        const DesktopLayerStack(),
      ],
    );
  }
}

class _HeroTagline extends StatelessWidget {
  const _HeroTagline({this.compact = false});

  /// Smaller, full-width layout for narrow (mobile) viewports.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final eyebrowSize = compact ? 9.0 : 11.0;
    final headlineSize = compact ? 18.0 : 26.0;
    final bodySize = compact ? 11.0 : 13.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          compact ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          'MOBILE ENGINEER · FLUTTER · PRODUCTION SYSTEMS',
          textAlign: compact ? TextAlign.start : TextAlign.end,
          style: TextStyle(
            fontSize: eyebrowSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white.withValues(alpha: 0.85),
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          compact
              ? 'Building reliable mobile software for real-world operations.'
              : 'Building reliable mobile software\nfor real-world operations.',
          textAlign: compact ? TextAlign.start : TextAlign.end,
          style: TextStyle(
            fontSize: headlineSize,
            fontWeight: FontWeight.w700,
            height: 1.15,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          compact
              ? 'Offline-first · Performance · Reliability'
              : 'Offline-first systems · Performance · Automation · Production reliability',
          textAlign: compact ? TextAlign.start : TextAlign.end,
          style: TextStyle(
            fontSize: bodySize,
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

