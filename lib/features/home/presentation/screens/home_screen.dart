import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
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
                    vertical: AppSpacing.xxl,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppBreakpoints.maxContentWidth,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'MD. ASIF AHMED',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
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
