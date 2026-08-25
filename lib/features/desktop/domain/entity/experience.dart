/// Represents a single professional work experience entry.
///
/// Used to populate the Experience window in the portfolio desktop UI.
/// [companyUrl] is stored for future use (e.g., linking the company name).
/// [repositories] lists publicly visible repositories evidencing the work.
class Experience {
  final String role;
  final String company;
  final String? companyUrl;
  final String duration;
  final String? location;
  final String? employmentType;
  final String description;
  final List<String> highlights;
  final List<String> skills;
  final List<WorkRepository> repositories;
  final bool isCurrent;

  const Experience({
    required this.role,
    required this.company,
    this.companyUrl,
    required this.duration,
    this.location,
    this.employmentType,
    required this.description,
    this.highlights = const [],
    this.skills = const [],
    this.repositories = const [],
    this.isCurrent = false,
  });
}

/// A publicly visible repository contributed to during a role.
class WorkRepository {
  final String name;
  final String url;
  final String? description;

  /// Verified commit count from the repository's contributor stats.
  final int? commits;

  const WorkRepository({
    required this.name,
    required this.url,
    this.description,
    this.commits,
  });
}
