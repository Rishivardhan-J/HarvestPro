import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';
import '../../shared_widgets/action_card.dart';
import '../../shared_widgets/app_bottom_nav.dart';
import '../../shared_widgets/reason_chip.dart';
import '../../shared_widgets/status_badge.dart';
import '../../shared_widgets/yield_gauge.dart';

class DesignShowcaseScreen extends StatelessWidget {
  const DesignShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
        elevation: 0,
      ),
      body: Row(
        children: [
          Expanded(
            child: Theme(
              data: AppTheme.lightTheme,
              child: const _ShowcaseContent(themeName: 'Light Theme'),
            ),
          ),
          Expanded(
            child: Theme(
              data: AppTheme.darkTheme,
              child: const _ShowcaseContent(themeName: 'Dark Theme'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseContent extends StatelessWidget {
  final String themeName;
  const _ShowcaseContent({required this.themeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          Text(themeName, style: context.textTheme.displayMedium),
          const SizedBox(height: HarvestSpacing.xl),

          // Typography
          Text('Typography', style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.sm),
          Text('Display 32sp', style: context.textTheme.displayLarge),
          Text('Display Small 28sp', style: context.textTheme.displayMedium),
          Text('H2 20sp', style: context.textTheme.headlineLarge),
          Text('H2 Small 18sp', style: context.textTheme.headlineMedium),
          Text('Body 15sp', style: context.textTheme.bodyLarge),
          Text('Body Small 14sp', style: context.textTheme.bodyMedium),
          Text('Caption 12sp', style: context.textTheme.labelLarge),
          Text('Caption Small 11sp', style: context.textTheme.labelSmall),
          const SizedBox(height: HarvestSpacing.xl),

          // YieldGauge
          Text('Yield Gauges', style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          const YieldGauge(value: 0.82, status: StatusGood(), statusLabel: 'Good'),
          const SizedBox(height: HarvestSpacing.lg),
          const YieldGauge(value: 0.54, status: StatusCaution(), statusLabel: 'Caution'),
          const SizedBox(height: HarvestSpacing.lg),
          const YieldGauge(value: 0.23, status: StatusCritical(), statusLabel: 'Critical'),
          const SizedBox(height: HarvestSpacing.xl),

          // StatusBadges
          Text('Status Badges', style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          const Wrap(
            spacing: HarvestSpacing.sm,
            runSpacing: HarvestSpacing.sm,
            children: [
              StatusBadge(status: StatusGood(), label: 'Good'),
              StatusBadge(status: StatusGood(), label: 'Good', size: StatusBadgeSize.large),
              StatusBadge(status: StatusCaution(), label: 'Caution'),
              StatusBadge(status: StatusCaution(), label: 'Caution', size: StatusBadgeSize.large),
              StatusBadge(status: StatusCritical(), label: 'Critical'),
              StatusBadge(status: StatusCritical(), label: 'Critical', size: StatusBadgeSize.large),
            ],
          ),
          const SizedBox(height: HarvestSpacing.xl),

          // ReasonChips
          Text('Reason Chips', style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          const SizedBox(
            height: 80,
            child: ReasonChipRow(
              chips: [
                ReasonChip(label: 'Rainfall', contribution: -0.6),
                ReasonChip(label: 'Soil Moisture', contribution: 0.4),
                ReasonChip(label: 'Pest Risk', contribution: -0.1),
                ReasonChip(label: 'Nutrients', contribution: 0.55),
              ],
            ),
          ),
          const SizedBox(height: HarvestSpacing.xl),

          // ActionCard
          Text('Action Card', style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          ActionCard(
            icon: Icons.water_drop_outlined,
            headline: 'Apply nitrogen top-dressing today',
            body: 'Your soil nitrogen is trending low for this growth stage. A light top-dressing now can add an estimated ₹850/acre in recovered yield.',
            buttonLabel: 'Mark as done',
            onButtonPressed: () {},
          ),
          const SizedBox(height: HarvestSpacing.xl),
          
          // AppBottomNav
          Text('Bottom Nav', style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          AppBottomNav(
            currentIndex: 0,
            onItemSelected: (_) {},
            items: const [
              AppBottomNavItem(outlineIcon: Icons.home_outlined, filledIcon: Icons.home, label: 'Home'),
              AppBottomNavItem(outlineIcon: Icons.camera_alt_outlined, filledIcon: Icons.camera_alt, label: 'Capture'),
              AppBottomNavItem(outlineIcon: Icons.eco_outlined, filledIcon: Icons.eco, label: 'Advice'),
              AppBottomNavItem(outlineIcon: Icons.people_outline, filledIcon: Icons.people, label: 'Community'),
            ],
          )
        ],
      ),
    );
  }
}
