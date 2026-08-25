import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';

/// Section header used across windows for consistent styling.
class WindowSectionHeader extends StatelessWidget {
  const WindowSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      width: double.infinity,
      color: skin.headerBarBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          color: skin.headerBarText,
          fontSize: 14,
          fontWeight: skin.headerBarWeight,
          letterSpacing: skin.headerBarSpacing,
        ),
      ),
    );
  }
}

/// Small labelled container used for capability categories.
class WindowCapabilitiesCard extends StatelessWidget {
  const WindowCapabilitiesCard({
    super.key,
    required this.category,
    required this.items,
  });

  final String category;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: skin.cardHeaderBackground,
        border: Border.all(color: skin.cardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: skin.headingColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            items.join(' · '),
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: skin.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
