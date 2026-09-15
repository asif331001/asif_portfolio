import '../domain/entities/portfolio_project.dart';

abstract final class PortfolioProjects {
  const PortfolioProjects._();

  static const List<PortfolioProject> all = [
    PortfolioProject(
      title: 'Genesis Learning Ecosystem',
      subtitle: 'Genesis Edu • Edudent • Genesis BCS Care',
      summary:
          'A Flutter learning ecosystem serving medical, dental, and '
          'government-exam audiences through multiple connected education '
          'applications.',
      featureGraphic:
          'assets/feature_graphics/'
          'genesis_learning_ecosystem_feature_graphic.png',
      technologies: [
        'Flutter',
        'Dart',
        'GetX',
        'REST API',
        'VDoCipher',
        'WebView',
      ],
      note: 'Three related learning apps presented as one ecosystem.',
    ),
    PortfolioProject(
      title: 'Genesis Mentor',
      subtitle: 'Learning & examination workflows',
      summary:
          'A Flutter application focused on structured learning, question '
          'workflows, examinations, video content, and API-driven user '
          'experiences.',
      featureGraphic:
          'assets/feature_graphics/genesis_mentor_feature_graphic.png',
      technologies: [
        'Flutter',
        'Dart',
        'Provider',
        'REST API',
        'Repository',
        'VDoCipher',
      ],
    ),
    PortfolioProject(
      title: 'CashFile',
      subtitle: 'Local-first finance & ledger application',
      summary:
          'A production Flutter application built around local-first ledger '
          'workflows, structured persistence, transaction data, and '
          'maintainable feature-oriented architecture.',
      featureGraphic: 'assets/feature_graphics/cashfile_feature_graphic.png',
      technologies: ['Flutter', 'Dart', 'Riverpod', 'Drift', 'SQLite', 'UUID'],
    ),
    PortfolioProject(
      title: 'The Message Academy',
      subtitle: 'Islamic learning application',
      summary:
          'A multilingual Flutter learning application combining REST APIs, '
          'video, audio, deep links, web content, and Bengali/Arabic user '
          'experiences.',
      featureGraphic:
          'assets/feature_graphics/message_academy_feature_graphic.png',
      technologies: [
        'Flutter',
        'Dart',
        'REST API',
        'YouTube',
        'Audio',
        'Deep Links',
      ],
    ),
    PortfolioProject(
      title: 'PG Easy',
      subtitle: 'Medical postgraduate learning platform',
      summary:
          'A Flutter learning application with API-driven content, local '
          'storage, document workflows, web content, connectivity handling, '
          'and educational resources.',
      featureGraphic: 'assets/feature_graphics/pg_easy_feature_graphic.png',
      technologies: ['Flutter', 'Dart', 'GetX', 'REST API', 'SQLite', 'PDF'],
    ),
    PortfolioProject(
      title: 'DG HRM',
      subtitle: 'Human resource management application',
      summary:
          'A Flutter HRM application integrating REST services, Firebase '
          'messaging, calendar workflows, local preferences, file handling, '
          'and application-side state management.',
      featureGraphic: 'assets/feature_graphics/dg_hrm_feature_graphic.png',
      technologies: ['Flutter', 'Dart', 'GetX', 'Dio', 'Firebase', 'FCM'],
    ),
  ];
}
