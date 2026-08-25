import 'package:flutter/material.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

/// Section header used across windows for consistent Win7 styling.
class Win7SectionHeader extends StatelessWidget {
  const Win7SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _kWin7DarkHeader,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Small labelled container used for capability categories.
class Win7CapabilitiesCard extends StatelessWidget {
  const Win7CapabilitiesCard({super.key, required this.category, required this.items});

  final String category;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kWin7SectionBg,
        border: Border.all(color: _kWin7CardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: _kWin7DarkHeader,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            items.join(' · '),
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
