import 'metric.dart';

enum EvidenceType { image, diagram, code, log, metric }

class EvidenceBlock {
  final EvidenceType type;
  final String? title;
  final String content;
  final String? src;

  const EvidenceBlock({
    required this.type,
    required this.content,
    this.title,
    this.src,
  });
}

class CaseStudy {
  final String slug;
  final String title;
  final String summary;
  final String context;
  final String problem;
  final List<String> investigation;
  final List<String> decisions;
  final List<String> implementation;
  final List<Metric> results;
  final String? lesson;
  final List<String> technologies;
  final List<EvidenceBlock> evidence;

  const CaseStudy({
    required this.slug,
    required this.title,
    required this.summary,
    required this.context,
    required this.problem,
    this.investigation = const [],
    this.decisions = const [],
    this.implementation = const [],
    this.results = const [],
    this.lesson,
    required this.technologies,
    this.evidence = const [],
  });
}
