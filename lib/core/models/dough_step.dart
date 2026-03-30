class DoughStep {
  const DoughStep({
    required this.name,
    required this.time,
    this.description = '',
  });

  final String name;
  final DateTime time;
  final String description;
}
