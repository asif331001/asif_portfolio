import 'package:flutter/material.dart';

import '../../../../core/constants/app_links.dart';
import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/services/external_link_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  static const Set<PortfolioSection> _enabledSections = {PortfolioSection.home};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSectionSelected(PortfolioSection section) {
    if (section != PortfolioSection.home) {
      return;
    }

    if (!_scrollController.hasClients) {
      return;
    }

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _openExternalLink(String url) async {
    final launched = await ExternalLinkService.open(url);

    if (!mounted || launched) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open the link. Please try again.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PortfolioNavbar(
            activeSection: PortfolioSection.home,
            enabledSections: _enabledSections,
            onSectionSelected: _handleSectionSelected,
          ),
          Expanded(
            child: ResponsiveLayout(
              builder: (context, windowSize, constraints) {
                final horizontalPadding = switch (windowSize) {
                  AppWindowSize.compact => AppSpacing.md,
                  AppWindowSize.medium => AppSpacing.xl,
                  AppWindowSize.expanded => AppSpacing.xxl,
                };

                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: switch (windowSize) {
                      AppWindowSize.compact => AppSpacing.md,
                      AppWindowSize.medium => AppSpacing.xl,
                      AppWindowSize.expanded => AppSpacing.xxl,
                    },
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppBreakpoints.maxContentWidth,
                      ),
                      child: HeroSection(
                        windowSize: windowSize,
                        onViewProjectsPressed: null,
                        onResumePressed: null,
                        onLinkedInPressed: () {
                          _openExternalLink(AppLinks.linkedIn);
                        },
                        onGitHubPressed: () {
                          _openExternalLink(AppLinks.github);
                        },
                        onWhatsAppPressed: () {
                          _openExternalLink(AppLinks.whatsapp);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
