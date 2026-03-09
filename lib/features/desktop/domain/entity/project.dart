class Project {
  final String name;
  final String description;
  final String? pubDevUrl;
  final String? chromeStoreUrl;
  final String? githubUrl;
  final String? playStoreUrl;
  final List<String> tags;
  final bool isPending;

  const Project({
    required this.name,
    required this.description,
    this.pubDevUrl,
    this.chromeStoreUrl,
    this.githubUrl,
    this.playStoreUrl,
    this.tags = const [],
    this.isPending = false,
  });
}
