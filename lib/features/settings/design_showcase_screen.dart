import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/locale_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';
import '../../shared_widgets/action_card.dart';
import '../../shared_widgets/app_bottom_nav.dart';
import '../../shared_widgets/reason_chip.dart';
import '../../shared_widgets/status_badge.dart';
import '../../shared_widgets/yield_gauge.dart';

class DesignShowcaseScreen extends ConsumerStatefulWidget {
  const DesignShowcaseScreen({super.key});

  @override
  ConsumerState<DesignShowcaseScreen> createState() => _DesignShowcaseScreenState();
}

class _DesignShowcaseScreenState extends ConsumerState<DesignShowcaseScreen> {
  bool _isPseudo = false;

  String _pseudo(String text) {
    if (!_isPseudo) {
      return text;
    }
    final extra = (text.length * 0.4).round();
    final pad = 'x' * extra;
    return '[$text $pad]';
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_pseudo('Design System Showcase')),
        elevation: 0,
        actions: [
          Row(
            children: [
              Text(_pseudo('Pseudo')),
              Switch(
                value: _isPseudo,
                onChanged: (val) => setState(() => _isPseudo = val),
              ),
            ],
          ),
          DropdownButton<String>(
            value: currentLocale.languageCode,
            items: supportedLocales.map((l) => DropdownMenuItem(
              value: l.languageCode,
              child: Text(l.languageCode.toUpperCase()),
            )).toList(),
            onChanged: (code) {
              if (code != null) {
                ref.read(localeProvider.notifier).setLocale(Locale(code));
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Theme(
              data: AppTheme.getLightTheme(currentLocale),
              child: _ShowcaseContent(themeName: _pseudo('Light Theme'), pseudo: _pseudo, locale: currentLocale),
            ),
          ),
          Expanded(
            child: Theme(
              data: AppTheme.getDarkTheme(currentLocale),
              child: _ShowcaseContent(themeName: _pseudo('Dark Theme'), pseudo: _pseudo, locale: currentLocale),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseContent extends StatelessWidget {
  final String themeName;
  final String Function(String) pseudo;
  final Locale locale;
  
  const _ShowcaseContent({required this.themeName, required this.pseudo, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          Text(themeName, style: context.textTheme.displayMedium),
          const SizedBox(height: HarvestSpacing.xl),

          // Script Smoke Test
          Text(pseudo('Script Smoke Test'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.sm),
          Container(
            padding: const EdgeInsets.all(HarvestSpacing.sm),
            decoration: BoxDecoration(
              border: Border.all(color: context.theme.colorScheme.primary),
              borderRadius: HarvestRadius.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'English: Crop health is good.',
                  style: AppTheme.getLightTheme(const Locale('en')).textTheme.bodyLarge,
                ),
                Text(
                  'Tamil: பயிர் ஆரோக்கியம் நன்றாக உள்ளது.',
                  style: AppTheme.getLightTheme(const Locale('ta')).textTheme.bodyLarge,
                ),
                Text(
                  'Telugu: పంట ఆరోగ్యం బాగుంది.',
                  style: AppTheme.getLightTheme(const Locale('te')).textTheme.bodyLarge,
                ),
                Text(
                  'Hindi: फसल का स्वास्थ्य अच्छा है।',
                  style: AppTheme.getLightTheme(const Locale('hi')).textTheme.bodyLarge,
                ),
                Text(
                  'Punjabi: ਫਸਲ ਦੀ ਸਿਹਤ ਚੰਗੀ ਹੈ।',
                  style: AppTheme.getLightTheme(const Locale('pa')).textTheme.bodyLarge,
                ),
                Text(
                  'Marathi: पिकाचे आरोग्य चांगले आहे.',
                  style: AppTheme.getLightTheme(const Locale('mr')).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: HarvestSpacing.xl),

          // Typography
          Text(pseudo('Typography'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.sm),
          Text(pseudo('Display 32sp'), style: context.textTheme.displayLarge),
          Text(pseudo('Display Small 28sp'), style: context.textTheme.displayMedium),
          Text(pseudo('H2 20sp'), style: context.textTheme.headlineLarge),
          Text(pseudo('H2 Small 18sp'), style: context.textTheme.headlineMedium),
          Text(pseudo('Body 15sp'), style: context.textTheme.bodyLarge),
          Text(pseudo('Body Small 14sp'), style: context.textTheme.bodyMedium),
          Text(pseudo('Caption 12sp'), style: context.textTheme.labelLarge),
          Text(pseudo('Caption Small 11sp'), style: context.textTheme.labelSmall),
          const SizedBox(height: HarvestSpacing.xl),

          // YieldGauge
          Text(pseudo('Yield Gauges'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          YieldGauge(value: 0.82, status: const StatusGood(), statusLabel: pseudo('Good')),
          const SizedBox(height: HarvestSpacing.lg),
          YieldGauge(value: 0.54, status: const StatusCaution(), statusLabel: pseudo('Caution')),
          const SizedBox(height: HarvestSpacing.lg),
          YieldGauge(value: 0.23, status: const StatusCritical(), statusLabel: pseudo('Critical')),
          const SizedBox(height: HarvestSpacing.xl),

          // StatusBadges
          Text(pseudo('Status Badges'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          Wrap(
            spacing: HarvestSpacing.sm,
            runSpacing: HarvestSpacing.sm,
            children: [
              StatusBadge(status: const StatusGood(), label: pseudo('Good')),
              StatusBadge(status: const StatusGood(), label: pseudo('Good'), size: StatusBadgeSize.large),
              StatusBadge(status: const StatusCaution(), label: pseudo('Caution')),
              StatusBadge(status: const StatusCaution(), label: pseudo('Caution'), size: StatusBadgeSize.large),
              StatusBadge(status: const StatusCritical(), label: pseudo('Critical')),
              StatusBadge(status: const StatusCritical(), label: pseudo('Critical'), size: StatusBadgeSize.large),
            ],
          ),
          const SizedBox(height: HarvestSpacing.xl),

          // ReasonChips
          Text(pseudo('Reason Chips'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          SizedBox(
            height: 80,
            child: ReasonChipRow(
              chips: [
                ReasonChip(label: pseudo('Rainfall'), contribution: -0.6),
                ReasonChip(label: pseudo('Soil Moisture'), contribution: 0.4),
                ReasonChip(label: pseudo('Pest Risk'), contribution: -0.1),
                ReasonChip(label: pseudo('Nutrients'), contribution: 0.55),
              ],
            ),
          ),
          const SizedBox(height: HarvestSpacing.xl),

          // ActionCard
          Text(pseudo('Action Card'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          ActionCard(
            icon: Icons.water_drop_outlined,
            headline: pseudo('Apply nitrogen top-dressing today'),
            body: pseudo('Your soil nitrogen is trending low for this growth stage. A light top-dressing now can add an estimated ₹850/acre in recovered yield.'),
            buttonLabel: pseudo('Mark as done'),
            onButtonPressed: () {},
          ),
          const SizedBox(height: HarvestSpacing.xl),
          
          // AppBottomNav
          Text(pseudo('Bottom Nav'), style: context.textTheme.headlineLarge),
          const SizedBox(height: HarvestSpacing.lg),
          AppBottomNav(
            currentIndex: 0,
            onItemSelected: (_) {},
            items: [
              AppBottomNavItem(outlineIcon: Icons.home_outlined, filledIcon: Icons.home, label: pseudo('Home')),
              AppBottomNavItem(outlineIcon: Icons.camera_alt_outlined, filledIcon: Icons.camera_alt, label: pseudo('Capture')),
              AppBottomNavItem(outlineIcon: Icons.eco_outlined, filledIcon: Icons.eco, label: pseudo('Advice')),
              AppBottomNavItem(outlineIcon: Icons.people_outline, filledIcon: Icons.people, label: pseudo('Community')),
            ],
          )
        ],
      ),
    );
  }
}
