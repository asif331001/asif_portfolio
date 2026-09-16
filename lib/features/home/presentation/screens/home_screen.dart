import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_links.dart';
import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/services/external_link_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/about_section.dart';
import '../widgets/animated_portfolio_background.dart';
import '../widgets/contact_section.dart';
import '../widgets/credibility_strip.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_navbar.dart';
import '../widgets/projects_section.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _aboutSectionKey = GlobalKey();
  final GlobalKey _experienceSectionKey = GlobalKey();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _skillsSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  static const Set<PortfolioSection> _enabledSections = {
    PortfolioSection.home,
    PortfolioSection.about,
    PortfolioSection.experience,
    PortfolioSection.projects,
    PortfolioSection.skills,
    PortfolioSection.contact,
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSectionSelected(PortfolioSection section) {
    switch (section) {
      case PortfolioSection.home:
        _scrollToTop();
      case PortfolioSection.about:
        _scrollToSection(_aboutSectionKey);
      case PortfolioSection.experience:
        _scrollToSection(_experienceSectionKey);
      case PortfolioSection.projects:
        _scrollToSection(_projectsSectionKey);
      case PortfolioSection.skills:
        _scrollToSection(_skillsSectionKey);
      case PortfolioSection.contact:
        _scrollToSection(_contactSectionKey);
    }
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) {
      return;
    }

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  void _scrollToSection(GlobalKey key) {
    final sectionContext = key.currentContext;

    if (sectionContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
      alignment: 0.04,
    );
  }

  void _viewResume() {
    context.push<void>(AppRoutes.resume);
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
            onResumePressed: _viewResume,
          ),
          Expanded(
            child: ResponsiveLayout(
              builder: (context, windowSize, _) {
                final horizontalPadding = switch (windowSize) {
                  AppWindowSize.compact => AppSpacing.md,
                  AppWindowSize.medium => AppSpacing.xl,
                  AppWindowSize.expanded => AppSpacing.xxl,
                };

                final sectionGap = switch (windowSize) {
                  AppWindowSize.compact => AppSpacing.lg,
                  AppWindowSize.medium => AppSpacing.xl,
                  AppWindowSize.expanded => AppSpacing.xxl,
                };

                return Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedPortfolioBackground(
                        compact: windowSize == AppWindowSize.compact,
                      ),
                    ),
                    SingleChildScrollView(
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
                          child: Column(
                            children: [
                              HeroSection(
                                windowSize: windowSize,
                                onViewProjectsPressed: () {
                                  _scrollToSection(_projectsSectionKey);
                                },
                                onResumePressed: _viewResume,
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
                              SizedBox(height: sectionGap),
                              ScrollReveal(
                                controller: _scrollController,
                                child: CredibilityStrip(windowSize: windowSize),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _aboutSectionKey,
                                child: ScrollReveal(
                                  controller: _scrollController,
                                  child: AboutSection(windowSize: windowSize),
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _experienceSectionKey,
                                child: ScrollReveal(
                                  controller: _scrollController,
                                  child: ExperienceSection(
                                    windowSize: windowSize,
                                  ),
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _projectsSectionKey,
                                child: ScrollReveal(
                                  controller: _scrollController,
                                  child: ProjectsSection(
                                    windowSize: windowSize,
                                  ),
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _skillsSectionKey,
                                child: ScrollReveal(
                                  controller: _scrollController,
                                  child: SkillsSection(windowSize: windowSize),
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _contactSectionKey,
                                child: ScrollReveal(
                                  controller: _scrollController,
                                  child: ContactSection(
                                    windowSize: windowSize,
                                    onEmailPressed: () {
                                      _openExternalLink(AppLinks.email);
                                    },
                                    onWhatsAppPressed: () {
                                      _openExternalLink(AppLinks.whatsapp);
                                    },
                                    onLinkedInPressed: () {
                                      _openExternalLink(AppLinks.linkedIn);
                                    },
                                    onGitHubPressed: () {
                                      _openExternalLink(AppLinks.github);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              ScrollReveal(
                                controller: _scrollController,
                                child: PortfolioFooter(
                                  windowSize: windowSize,
                                  onEmailPressed: () {
                                    _openExternalLink(AppLinks.email);
                                  },
                                  onLinkedInPressed: () {
                                    _openExternalLink(AppLinks.linkedIn);
                                  },
                                  onGitHubPressed: () {
                                    _openExternalLink(AppLinks.github);
                                  },
                                  onWhatsAppPressed: () {
                                    _openExternalLink(AppLinks.whatsapp);
                                  },
                                  onBackToTopPressed: _scrollToTop,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedPortfolioBackground(
                        compact: windowSize == AppWindowSize.compact,
                        overlay: true,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
