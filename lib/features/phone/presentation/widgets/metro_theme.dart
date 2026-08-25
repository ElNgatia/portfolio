import 'package:flutter/material.dart';

/// Windows Phone accent palette used across the mobile (Metro) shell.
class MetroColors {
  static const cyan = Color(0xFF1BA1E2);
  static const teal = Color(0xFF00ABA9);
  static const lime = Color(0xFFA4C400);
  static const green = Color(0xFF008A00);
  static const orange = Color(0xFFF09609);
  static const magenta = Color(0xFFD80073);
  static const purple = Color(0xFFA200FF);
  static const red = Color(0xFFE51400);
  static const blue = Color(0xFF0050EF);
  static const gray = Color(0xFF6B6B6B);

  static const background = Color(0xFF000000);
  static const appBar = Color(0xFF141414);
}

/// Tile shape on the Start screen.
enum MetroTileSize { medium, wide }

/// Visual spec for a Start-screen tile, keyed by the app (window) id.
class MetroTileSpec {
  final String id;
  final Color accent;
  final MetroTileSize size;

  const MetroTileSpec({
    required this.id,
    required this.accent,
    required this.size,
  });
}

/// Order and styling of tiles on the Start screen.
const List<MetroTileSpec> kMetroTileSpecs = [
  // Wide "Me" tile
  MetroTileSpec(id: '123', accent: MetroColors.cyan, size: MetroTileSize.wide),
  MetroTileSpec(
    id: '456',
    accent: MetroColors.orange,
    size: MetroTileSize.medium,
  ),
  MetroTileSpec(
    id: '234',
    accent: MetroColors.teal,
    size: MetroTileSize.medium,
  ),
  // Wide "Experience" tile
  MetroTileSpec(id: '789', accent: MetroColors.green, size: MetroTileSize.wide),
  MetroTileSpec(
    id: '567',
    accent: MetroColors.lime,
    size: MetroTileSize.medium,
  ),
  MetroTileSpec(
    id: '345',
    accent: MetroColors.purple,
    size: MetroTileSize.medium,
  ),
  MetroTileSpec(
    id: '012',
    accent: MetroColors.magenta,
    size: MetroTileSize.medium,
  ),
  MetroTileSpec(
    id: '901',
    accent: MetroColors.blue,
    size: MetroTileSize.medium,
  ),
  MetroTileSpec(id: '678', accent: MetroColors.gray, size: MetroTileSize.medium),
];

/// Accent colour for an app id; used for header underlines etc.
Color metroAccentFor(String id) {
  for (final spec in kMetroTileSpecs) {
    if (spec.id == id) return spec.accent;
  }
  return MetroColors.cyan;
}
