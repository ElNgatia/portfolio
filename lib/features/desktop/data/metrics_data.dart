import 'package:portfolio/features/desktop/domain/entity/metric.dart';

/// Impact metrics shown in the strip below the hero.
///
/// Only metrics verified against real data sources (Play Console,
/// Crashlytics, CI/CD records, pub.dev) may have [Metric.verified] = true.
/// Unverified values must keep their "[VERIFY]" placeholder.
const List<Metric> impactMetrics = [
  Metric(
    label: 'Deployment efficiency',
    value: '30%',
    context: 'Improvement in mobile deployment workflow',
    verified: true,
  ),
  Metric(
    label: 'Field users supported',
    value: '[VERIFY]',
    context: 'Production SFA application across African markets',
  ),
  Metric(
    label: 'Production releases',
    value: '[VERIFY]',
    context: 'Releases shipped to the Play Store',
  ),
  Metric(
    label: 'pub.dev points',
    value: '160/160',
    context: 'timeago_plus package quality score',
    verified: true,
  ),
];
