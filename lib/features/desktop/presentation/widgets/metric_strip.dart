import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/domain/entity/metric.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

/// A compact, data-driven strip of impact metric cards.
///
/// Unverified metrics ([Metric.verified] == false) render their raw
/// placeholder value with a "pending verification" badge so fabricated
/// numbers never appear as facts.
class MetricStrip extends StatelessWidget {
  const MetricStrip({super.key, required this.metrics});

  final List<Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: metrics.map((metric) => _MetricCard(metric: metric)).toList(),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final Metric metric;

  @override
  Widget build(BuildContext context) {
    final isPlaceholder = !metric.verified;
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kWin7CardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color:
                  isPlaceholder ? const Color(0xFF999999) : _kWin7DarkHeader,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            metric.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          if (metric.context != null) ...[
            const SizedBox(height: 4),
            Text(
              metric.context!,
              style: const TextStyle(
                fontSize: 10,
                height: 1.3,
                color: Color(0xFF666666),
              ),
            ),
          ],
          if (isPlaceholder)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                border: Border.all(color: const Color(0xFFFFD54F)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Text(
                'Pending verification',
                style: TextStyle(fontSize: 9, color: Color(0xFFB8860B)),
              ),
            ),
        ],
      ),
    );
  }
}

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
