import 'metric.dart';

class Project {
  final String name;
  final String description;
  final String? websiteUrl;
  final String? pubDevUrl;
  final String? chromeStoreUrl;
  final String? githubUrl;
  final String? playStoreUrl;
  final List<String> tags;

  /// My role in the project, e.g. "Solo developer" or "Mobile Engineer".
  final String? role;

  final List<Metric> metrics;

  final bool isPending;

  const Project({
    required this.name,
    required this.description,
    this.websiteUrl,
    this.pubDevUrl,
    this.chromeStoreUrl,
    this.githubUrl,
    this.playStoreUrl,
    this.tags = const [],
    this.role,
    this.metrics = const [],
    this.isPending = false,
  });
}
