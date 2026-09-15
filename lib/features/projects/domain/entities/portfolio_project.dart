class PortfolioProject {
  const PortfolioProject({
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.featureGraphic,
    required this.technologies,
    this.note,
  });

  final String title;
  final String subtitle;
  final String summary;
  final String featureGraphic;
  final List<String> technologies;
  final String? note;
}
