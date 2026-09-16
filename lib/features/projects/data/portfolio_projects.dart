import '../../../core/routing/app_routes.dart';
import '../domain/entities/portfolio_project.dart';

abstract final class PortfolioProjects {
  const PortfolioProjects._();

  static const PortfolioProject genesisEdu = PortfolioProject(
    routePath: AppRoutes.genesisEdu,
    title: 'Genesis Edu',
    subtitle: 'Medical postgraduate learning application',
    summary:
        'A Flutter learning application for medical postgraduate learners '
        'and doctors, combining API-driven learning workflows, secured video, '
        'web content, notifications, and connectivity-aware experiences.',
    featureGraphic:
        'assets/feature_graphics_optimized/genesisedu_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/genesis_edu_logo.png'],
    platformLabel: 'Android & iOS',
    architecture:
        'Flutter application structured with GetX and MVVM-oriented '
        'separation, REST API integration, local preferences, secured media, '
        'WebView content, notifications, and connectivity handling.',
    responsibilities: [
      'Flutter application architecture and feature implementation',
      'Responsive UI and GetX-based application state',
      'REST API integration and client-side workflows',
      'VDoCipher secured video integration',
      'WebView, connectivity, notification, and local preference handling',
      'Device testing, debugging, maintenance, and production delivery',
    ],
    highlights: [
      'Built for medical postgraduate learners and doctors',
      'Secured educational video delivery through VDoCipher',
      'API-driven learning workflows',
      'Production delivery for Android and iOS',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'GetX',
      'MVVM',
      'REST API',
      'VDoCipher',
      'SharedPreferences',
      'Notifications',
      'WebView',
      'Connectivity',
    ],
    screenshots: [
      'assets/app_screenshots/genesis_edu_1.jpeg',
      'assets/app_screenshots/Genesis_edu_2.jpeg',
      'assets/app_screenshots/Genesis_edu_3.jpeg',
      'assets/app_screenshots/Genesis_edu_4.jpeg',
    ],
    note: 'Genesis Edu belongs to the wider Genesis learning product family.',
  );

  static const PortfolioProject edudent = PortfolioProject(
    routePath: AppRoutes.edudent,
    title: 'Edudent',
    subtitle: 'Dental learning application',
    summary:
        'A Flutter mobile learning application created for dental learners '
        'as part of the wider Genesis education product family.',
    featureGraphic:
        'assets/feature_graphics_optimized/edudent_feature_graphics.jpg',
    logoAssets: ['assets/project_logos_optimized/edudent_logo.png'],
    platformLabel: 'Android',
    architecture:
        'Flutter mobile application with dedicated dental learning workflows '
        'and application-side UI and feature implementation.',
    responsibilities: [
      'Flutter UI and feature implementation',
      'Responsive mobile interface development',
      'Application-side learning workflow implementation',
      'Client-side application logic',
      'Debugging and device testing',
      'Android production delivery',
    ],
    highlights: [
      'Dedicated learning experience for dental learners',
      'Part of the Genesis education product family',
      'Built as a Flutter mobile application',
      'Production Android release',
    ],
    technologies: ['Flutter', 'Dart', 'Responsive UI'],
    screenshots: [
      'assets/app_screenshots/edudent_1.jpeg',
      'assets/app_screenshots/edudent_2.jpeg',
      'assets/app_screenshots/edudent_3.jpeg',
      'assets/app_screenshots/edudent_4.jpeg',
    ],
    note:
        'Edudent is related to the Genesis learning ecosystem but is '
        'presented here as its own portfolio project.',
  );

  static const PortfolioProject genesisBcsCare = PortfolioProject(
    routePath: AppRoutes.genesisBcsCare,
    title: 'Genesis BCS Care',
    subtitle: 'BCS & government-exam preparation application',
    summary:
        'A Flutter learning application focused on BCS and government-exam '
        'preparation workflows within the Genesis education product family.',
    featureGraphic:
        'assets/feature_graphics_optimized/genesis_bcscare_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/genesis_bcscare_logo.png'],
    platformLabel: 'Android',
    architecture:
        'Flutter mobile application focused on competitive-exam learning '
        'workflows, responsive UI, and client-side application behavior.',
    responsibilities: [
      'Flutter UI and feature implementation',
      'Responsive mobile interface development',
      'Application-side learning workflow implementation',
      'Client-side application logic',
      'Debugging and testing',
      'Ongoing Flutter application maintenance',
    ],
    highlights: [
      'Focused on BCS and government-exam preparation',
      'Part of the Genesis education product family',
      'Built as a Flutter mobile learning application',
      'Current production-release status is not claimed',
    ],
    technologies: ['Flutter', 'Dart', 'Responsive UI'],
    screenshots: [
      'assets/app_screenshots/genesis_bcscare_1.jpeg',
      'assets/app_screenshots/genesis_bcscare_2.jpeg',
      'assets/app_screenshots/genesis_bcscare_3.jpeg',
      'assets/app_screenshots/genesis_bcscare_4.jpeg',
    ],
    note:
        'Genesis BCS Care is shown independently while its current release '
        'status remains intentionally unspecified.',
  );

  static const PortfolioProject genesisMentor = PortfolioProject(
    routePath: AppRoutes.genesisMentor,
    title: 'Genesis Mentor',
    subtitle: 'Learning & examination workflows',
    summary:
        'A Flutter application focused on structured learning, question '
        'workflows, examinations, video content, and API-driven user '
        'experiences.',
    featureGraphic:
        'assets/feature_graphics_optimized/genesis_mentor_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/genesis_mentors_logo.jpg'],
    platformLabel: 'Android & iOS',
    architecture:
        'Layered Flutter application flow using Presentation, '
        'Provider/ChangeNotifier, Repository, and Service/API layers with '
        'constructor-based dependency passing.',
    responsibilities: [
      'Flutter UI and feature implementation',
      'Provider and ChangeNotifier state management',
      'Repository and API integration workflows',
      'Question and examination-related application flows',
      'VDoCipher video and WebView integrations',
      'Local preferences, connectivity handling, testing, and maintenance',
    ],
    highlights: [
      'Structured question and examination workflows',
      'API-driven learning content and user interactions',
      'Secured video delivery using VDoCipher',
      'Production delivery for both Android and iOS',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'Provider',
      'ChangeNotifier',
      'REST API',
      'Repository',
      'Constructor DI',
      'SharedPreferences',
      'HTTP',
      'Connectivity',
      'VDoCipher',
      'WebView',
    ],
    screenshots: [
      'assets/app_screenshots/genesis_mentor_1.jpeg',
      'assets/app_screenshots/genesis_mentor_2.jpeg',
      'assets/app_screenshots/genesis_mentor_3.jpeg',
      'assets/app_screenshots/genesis_mentor_4.jpeg',
    ],
  );

  static const PortfolioProject cashFile = PortfolioProject(
    routePath: AppRoutes.cashFile,
    title: 'CashFile',
    subtitle: 'Local-first finance & ledger application',
    summary:
        'A production Flutter application built around local-first ledger '
        'workflows, structured persistence, transaction data, and '
        'maintainable feature-oriented architecture.',
    featureGraphic:
        'assets/feature_graphics_optimized/cashfile_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/cashfile_logo.png'],
    platformLabel: 'Android & iOS',
    architecture:
        'Feature-first, layered Flutter architecture using Riverpod for '
        'state management and Drift/SQLite as the local persistence layer.',
    responsibilities: [
      'Feature-first Flutter architecture and application structure',
      'Riverpod state management and presentation logic',
      'Drift and SQLite persistence implementation',
      'Local-first transaction and ledger workflows',
      'Database migrations and UUID-based entity handling',
      'Android and iOS production build and release workflows',
    ],
    highlights: [
      'Local-first financial data experience',
      'Structured ledger and transaction persistence',
      'Schema migration support for evolving local data',
      'Production Android and iOS delivery',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'Riverpod',
      'Drift',
      'SQLite',
      'Repository',
      'Feature-first',
      'UUID',
      'Database Migrations',
    ],
    screenshots: [
      'assets/app_screenshots/cashfile_1.jpeg',
      'assets/app_screenshots/cashfile_2.jpeg',
      'assets/app_screenshots/cashfile_3.jpeg',
      'assets/app_screenshots/cashfile_4.jpeg',
    ],
  );

  static const PortfolioProject theMessageAcademy = PortfolioProject(
    routePath: AppRoutes.theMessageAcademy,
    title: 'The Message Academy',
    subtitle: 'Islamic learning application',
    summary:
        'A multilingual Flutter learning application combining REST APIs, '
        'video, audio, deep links, web content, and Bengali/Arabic user '
        'experiences.',
    featureGraphic:
        'assets/feature_graphics_optimized/message_academy_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/message_academy_logo.png'],
    platformLabel: 'Android & iOS',
    architecture:
        'Modular, feature-oriented Flutter application structure combining '
        'API-backed content, multimedia experiences, local preferences, '
        'deep links, and embedded web content.',
    responsibilities: [
      'Flutter feature and responsive UI implementation',
      'REST API integration and application-side workflows',
      'YouTube, audio, and WebView content experiences',
      'Deep-link handling and local preferences',
      'Bengali and Arabic multilingual interface support',
      'Android and iOS testing, maintenance, and release delivery',
    ],
    highlights: [
      'Bengali and Arabic multilingual learning experience',
      'Integrated video, audio, and web-based educational content',
      'Deep-link supported application navigation',
      'Production Android and iOS delivery',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'REST API',
      'YouTube',
      'Audio',
      'WebView',
      'Deep Links',
      'SharedPreferences',
      'Multilingual UI',
    ],
    screenshots: [
      'assets/app_screenshots/message_academy_1.jpeg',
      'assets/app_screenshots/message_academy_2.jpeg',
      'assets/app_screenshots/message_academy_3.jpeg',
      'assets/app_screenshots/message_academy_4.jpeg',
    ],
  );

  static const PortfolioProject pgEasy = PortfolioProject(
    routePath: AppRoutes.pgEasy,
    title: 'PG Easy',
    subtitle: 'Medical postgraduate learning platform',
    summary:
        'A Flutter learning application with API-driven content, local '
        'storage, document workflows, web content, connectivity handling, '
        'and educational resources.',
    featureGraphic:
        'assets/feature_graphics_optimized/pg_easy_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/pg_easy_logo.png'],
    platformLabel: 'Android & iOS',
    architecture:
        'Layered Flutter application flow separating Presentation, '
        'Data/Services/Models, and Network responsibilities.',
    responsibilities: [
      'Flutter UI and application feature development',
      'GetX-based application state and navigation flows',
      'REST API and HTTP integration',
      'SQLite and SharedPreferences local persistence',
      'PDF, printing, WebView, and file-related workflows',
      'Connectivity handling, debugging, and Android delivery',
    ],
    highlights: [
      'Medical postgraduate learning workflows',
      'Local storage for application-side data requirements',
      'PDF and printing support',
      'Web content and connectivity-aware user experiences',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'GetX',
      'REST API',
      'HTTP',
      'SQLite',
      'SharedPreferences',
      'WebView',
      'Connectivity',
      'PDF',
      'Printing',
    ],
    screenshots: [
      'assets/app_screenshots/pgeasy_1.jpeg',
      'assets/app_screenshots/pgeasy_2.jpeg',
      'assets/app_screenshots/pgeasy_3.jpeg',
      'assets/app_screenshots/pgeasy_4.jpeg',
    ],
  );

  static const PortfolioProject dgHrm = PortfolioProject(
    routePath: AppRoutes.dgHrm,
    title: 'DG HRM',
    subtitle: 'Human resource management application',
    summary:
        'A Flutter HRM application integrating REST services, Firebase '
        'messaging, calendar workflows, local preferences, file handling, '
        'and application-side state management.',
    featureGraphic:
        'assets/feature_graphics_optimized/dg_hrm_feature_graphic.jpg',
    logoAssets: ['assets/project_logos_optimized/dg_hrm_logo.png'],
    platformLabel: 'Android',
    architecture:
        'Layered Flutter application structure with separation of UI, '
        'application state, network communication, integrations, and '
        'local preferences.',
    responsibilities: [
      'Flutter UI and HRM feature development',
      'GetX state management and application flows',
      'Dio, HTTP, and REST API integration',
      'Firebase and FCM messaging integration',
      'Calendar, file, and cached-image workflows',
      'SharedPreferences, debugging, maintenance, and Android delivery',
    ],
    highlights: [
      'HRM-focused mobile workflows',
      'Firebase Cloud Messaging integration',
      'Calendar-based application functionality',
      'Network, local preference, and file-handling integration',
    ],
    technologies: [
      'Flutter',
      'Dart',
      'GetX',
      'Dio',
      'HTTP',
      'REST API',
      'Firebase',
      'FCM',
      'SharedPreferences',
      'Table Calendar',
      'File Handling',
    ],
    screenshots: [
      'assets/app_screenshots/dg_hrm_1.jpeg',
      'assets/app_screenshots/dg_hrm_2.jpeg',
      'assets/app_screenshots/dg_hrm_3.jpeg',
      'assets/app_screenshots/dg_hrm_4.jpeg',
    ],
  );

  static const List<PortfolioProject> all = [
    cashFile,
    genesisEdu,
    genesisMentor,
    theMessageAcademy,
    pgEasy,
    dgHrm,
    edudent,
    genesisBcsCare,
  ];
}
