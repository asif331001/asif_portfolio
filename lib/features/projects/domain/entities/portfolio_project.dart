class PortfolioProject {
  const PortfolioProject({
    required this.routePath,
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.featureGraphic,
    required this.logoAssets,
    required this.platformLabel,
    required this.architecture,
    required this.responsibilities,
    required this.highlights,
    required this.technologies,
    required this.screenshots,
    this.note,
  });

  final String routePath;
  final String title;
  final String subtitle;
  final String summary;
  final String featureGraphic;
  final List<String> logoAssets;
  final String platformLabel;
  final String architecture;
  final List<String> responsibilities;
  final List<String> highlights;
  final List<String> technologies;
  final List<String> screenshots;
  final String? note;
}
