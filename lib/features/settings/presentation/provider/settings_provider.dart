import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

/// Available wallpaper options for the desktop background.
enum WallpaperOption {
  windows7(
    label: 'Windows 7',
    assetPath: 'assets/images/windows-7.jpg',
  ),
  nightSky(
    label: 'Night Sky',
    gradientColors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
  ),
  forest(
    label: 'Forest',
    gradientColors: [Color(0xFF134E5E), Color(0xFF71B280)],
  ),
  sunset(
    label: 'Sunset',
    gradientColors: [Color(0xFFFF512F), Color(0xFFDD2476)],
  ),
  ocean(
    label: 'Ocean',
    gradientColors: [Color(0xFF1CB5E0), Color(0xFF000851)],
  );

  const WallpaperOption({
    required this.label,
    this.assetPath,
    this.gradientColors,
  });

  final String label;
  final String? assetPath;
  final List<Color>? gradientColors;

  bool get isAsset => assetPath != null;
}

class SettingsState {
  final WallpaperOption wallpaper;

  const SettingsState({this.wallpaper = WallpaperOption.windows7});

  SettingsState copyWith({WallpaperOption? wallpaper}) => SettingsState(
    wallpaper: wallpaper ?? this.wallpaper,
  );
}

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() => const SettingsState();

  void setWallpaper(WallpaperOption wallpaper) {
    state = state.copyWith(wallpaper: wallpaper);
  }
}
