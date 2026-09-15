import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/projects/data/portfolio_projects.dart';
import '../../features/projects/presentation/screens/project_detail_screen.dart';
import '../../features/resume/presentation/screens/resume_screen.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.resume,
        builder: (context, state) => const ResumeScreen(),
      ),
      GoRoute(
        path: AppRoutes.genesisEdu,
        builder: (context, state) =>
            const ProjectDetailScreen(project: PortfolioProjects.genesisEdu),
      ),
      GoRoute(
        path: AppRoutes.edudent,
        builder: (context, state) =>
            const ProjectDetailScreen(project: PortfolioProjects.edudent),
      ),
      GoRoute(
        path: AppRoutes.genesisBcsCare,
        builder: (context, state) => const ProjectDetailScreen(
          project: PortfolioProjects.genesisBcsCare,
        ),
      ),
      GoRoute(
        path: AppRoutes.genesisMentor,
        builder: (context, state) =>
            const ProjectDetailScreen(project: PortfolioProjects.genesisMentor),
      ),
      GoRoute(
        path: AppRoutes.cashFile,
        builder: (context, state) =>
            const ProjectDetailScreen(project: PortfolioProjects.cashFile),
      ),
      GoRoute(
        path: AppRoutes.theMessageAcademy,
        builder: (context, state) => const ProjectDetailScreen(
          project: PortfolioProjects.theMessageAcademy,
        ),
      ),
      GoRoute(
        path: AppRoutes.pgEasy,
        builder: (context, state) =>
            const ProjectDetailScreen(project: PortfolioProjects.pgEasy),
      ),
      GoRoute(
        path: AppRoutes.dgHrm,
        builder: (context, state) =>
            const ProjectDetailScreen(project: PortfolioProjects.dgHrm),
      ),
      GoRoute(
        path: AppRoutes.genesisLearningLegacy,
        redirect: (context, state) => AppRoutes.genesisEdu,
      ),
    ],
  );
}
