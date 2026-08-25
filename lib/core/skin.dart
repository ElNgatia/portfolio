import 'package:flutter/material.dart';

/// Semantic colour roles for window content.
///
/// The same screens render in the desktop look (Windows 7 Aero) or the
/// mobile look (Windows Phone Metro) depending on which palette is in
/// scope. Desktop code never needs to wrap anything: [SkinScope.of]
/// falls back to [kWin7Skin], while the mobile shell provides a Metro
/// palette tinted with each app's accent colour.
class SkinPalette {
  const SkinPalette({
    required this.pageBackground,
    required this.headerBarBackground,
    required this.headerBarText,
    required this.headerBarWeight,
    required this.headerBarSpacing,
    required this.cardBackground,
    required this.cardHeaderBackground,
    required this.cardBorder,
    required this.headingColor,
    required this.headingWeight,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textMuted,
    required this.iconMuted,
    required this.iconDisabled,
    required this.accent,
    required this.hoverBackground,
    required this.divider,
    required this.buttonTop,
    required this.buttonBottom,
    required this.buttonBorder,
    required this.footerBarBackground,
    required this.cardShadow,
    required this.chipBackground,
    required this.chipBorder,
    required this.chipText,
    required this.codeBackground,
    required this.codeText,
    required this.surfaceHigh,
    required this.timelineLine,
    required this.avatarBackground,
    required this.warningBadge,
    required this.successBadge,
    required this.violetBadge,
  });

  /// Window/page surface behind all content.
  final Color pageBackground;

  /// Full-width section header bar (e.g. "Work Experience").
  final Color headerBarBackground;
  final Color headerBarText;
  final FontWeight headerBarWeight;
  final double headerBarSpacing;

  /// Cards and their header strips.
  final Color cardBackground;
  final Color cardHeaderBackground;
  final Color cardBorder;

  /// Emphasised titles inside content.
  final Color headingColor;
  final FontWeight headingWeight;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textMuted;
  final Color iconMuted;
  final Color iconDisabled;

  /// Links, active markers, highlights.
  final Color accent;
  final Color hoverBackground;
  final Color divider;

  /// Chrome buttons (top/bottom gradient stops + border).
  final Color buttonTop;
  final Color buttonBottom;
  final Color buttonBorder;

  /// Bottom bar of dialog-style windows (e.g. settings OK/Cancel strip).
  final Color footerBarBackground;

  /// Subtle elevation for cards; empty on flat (Metro) surfaces.
  final List<BoxShadow> cardShadow;

  /// Small tag chips (technologies, skills).
  final Color chipBackground;
  final Color chipBorder;
  final Color chipText;

  /// Code / log evidence blocks.
  final Color codeBackground;
  final Color codeText;

  /// Inactive timeline dots and connecting lines.
  final Color surfaceHigh;
  final Color timelineLine;

  /// Fill for circular avatar placeholders.
  final Color avatarBackground;

  /// Status badges ("Pending review", pub points, GitHub-only packages).
  final BadgeColors warningBadge;
  final BadgeColors successBadge;
  final BadgeColors violetBadge;

  static SkinPalette of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SkinScope>()?.palette ??
      kWin7Skin;
}

/// Background/border/text triple for small status badges.
class BadgeColors {
  const BadgeColors({
    required this.background,
    required this.border,
    required this.text,
  });

  final Color background;
  final Color border;
  final Color text;
}

/// Provides a [SkinPalette] to the widget tree below it.
class SkinScope extends InheritedWidget {
  const SkinScope({
    super.key,
    required this.palette,
    required super.child,
  });

  final SkinPalette palette;

  @override
  bool updateShouldNotify(SkinScope oldWidget) =>
      oldWidget.palette != palette;
}

/// Windows 7 Aero palette — exact colours used by the desktop windows.
const SkinPalette kWin7Skin = SkinPalette(
  pageBackground: Color(0xFFFFFFFF),
  headerBarBackground: Color(0xFF0A246A),
  headerBarText: Color(0xFFFFFFFF),
  headerBarWeight: FontWeight.w700,
  headerBarSpacing: 0,
  cardBackground: Color(0xFFFFFFFF),
  cardHeaderBackground: Color(0xFFEFF4FB),
  cardBorder: Color(0xFFADCDEF),
  headingColor: Color(0xFF0A246A),
  headingWeight: FontWeight.w700,
  textPrimary: Color(0xFF1A1A1A),
  textSecondary: Color(0xFF333333),
  textTertiary: Color(0xFF444444),
  textMuted: Color(0xFF555555),
  iconMuted: Color(0xFF666666),
  iconDisabled: Color(0xFFBBBBBB),
  accent: Color(0xFF0078D7),
  hoverBackground: Color(0xFFE5F3FF),
  divider: Color(0xFFADCDEF),
  buttonTop: Color(0xFFF5F5F5),
  buttonBottom: Color(0xFFDCDCDC),
  buttonBorder: Color(0xFFADADAD),
  footerBarBackground: Color(0xFFD4D0C8),
  cardShadow: [
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ],
  chipBackground: Color(0xFFF0F4F8),
  chipBorder: Color(0xFF9BB8D0),
  chipText: Color(0xFF2567A5),
  codeBackground: Color(0xFF1E1E1E),
  codeText: Color(0xFFD4D4D4),
  surfaceHigh: Color(0xFFCCDDEE),
  timelineLine: Color(0xFFBDD4EA),
  avatarBackground: Color(0xFF2567A5),
  warningBadge: BadgeColors(
    background: Color(0xFFFFF3E0),
    border: Color(0xFFFFB74D),
    text: Color(0xFFE65100),
  ),
  successBadge: BadgeColors(
    background: Color(0xFFE8F5E9),
    border: Color(0xFF66BB6A),
    text: Color(0xFF2E7D32),
  ),
  violetBadge: BadgeColors(
    background: Color(0xFFF3E5F5),
    border: Color(0xFFBA68C8),
    text: Color(0xFF6A1B9A),
  ),
);

/// Windows Phone Metro palette — dark, flat, accent-tinted.
SkinPalette metroSkin(Color accent) => SkinPalette(
  pageBackground: const Color(0xFF000000),
  headerBarBackground: const Color(0xFF000000),
  headerBarText: accent,
  headerBarWeight: FontWeight.w400,
  headerBarSpacing: 1.2,
  cardBackground: const Color(0xFF151515),
  cardHeaderBackground: const Color(0xFF1F1F1F),
  cardBorder: const Color(0xFF303030),
  headingColor: const Color(0xFFFFFFFF),
  headingWeight: FontWeight.w400,
  textPrimary: const Color(0xFFEAEAEA),
  textSecondary: const Color(0xFFC7C7C7),
  textTertiary: const Color(0xFFADADAD),
  textMuted: const Color(0xFF969696),
  iconMuted: const Color(0xFF8A8A8A),
  iconDisabled: const Color(0xFF5A5A5A),
  accent: accent,
  hoverBackground: accent.withValues(alpha: 0.14),
  divider: const Color(0xFF262626),
  buttonTop: const Color(0xFF1F1F1F),
  buttonBottom: const Color(0xFF101010),
  buttonBorder: const Color(0xFF3D3D3D),
  footerBarBackground: const Color(0xFF1F1F1F),
  cardShadow: const [],
  chipBackground: const Color(0xFF1A1A1A),
  chipBorder: const Color(0xFF3D3D3D),
  chipText: const Color(0xFF7FCBF5),
  codeBackground: const Color(0xFF0A0A0A),
  codeText: const Color(0xFFCFCFCF),
  surfaceHigh: const Color(0xFF2E2E2E),
  timelineLine: const Color(0xFF333333),
  avatarBackground: accent,
  warningBadge: const BadgeColors(
    background: Color(0xFF33230E),
    border: Color(0xFFFFB74D),
    text: Color(0xFFFFCC80),
  ),
  successBadge: const BadgeColors(
    background: Color(0xFF12291C),
    border: Color(0xFF66BB6A),
    text: Color(0xFF81C784),
  ),
  violetBadge: const BadgeColors(
    background: Color(0xFF241A2E),
    border: Color(0xFFBA68C8),
    text: Color(0xFFCE93D8),
  ),
);
