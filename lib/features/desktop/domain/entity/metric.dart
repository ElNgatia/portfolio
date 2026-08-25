class Metric {
  final String label;
  final String value;
  final String? context;

  /// Whether the value has been verified against a real data source.
  /// Unverified values must remain explicit "[VERIFY]" placeholders.
  final bool verified;

  const Metric({
    required this.label,
    required this.value,
    this.context,
    this.verified = false,
  });
}
