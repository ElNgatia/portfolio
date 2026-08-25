class PubPackage {
  final String name;
  final String description;
  final String ecosystem;
  final String pubDevUrl;
  final String? githubUrl;
  final String? latestVersion;
  final int? pubPoints;
  final int? maxPoints;
  final bool publishedOnPubDev;

  const PubPackage({
    required this.name,
    required this.description,
    required this.ecosystem,
    required this.pubDevUrl,
    this.githubUrl,
    this.latestVersion,
    this.pubPoints,
    this.maxPoints,
    this.publishedOnPubDev = true,
  });
}
