/// Represents a single professional work experience entry.
///
/// Used to populate the Experience window in the portfolio desktop UI.
/// [companyUrl] is stored for future use (e.g., linking the company name).
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
    this.isCurrent = false,
  });
}
