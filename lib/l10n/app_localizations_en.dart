// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboarding_languageScreenTitle => 'Choose your language';

  @override
  String get onboarding_continueButton => 'Continue';

  @override
  String onboarding_languageName(String language) {
    return '$language';
  }

  @override
  String community_farmersReportedThis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count farmers near you reported the same issue',
      one: '1 farmer near you reported the same issue',
      zero: 'No farmers near you reported the same issue',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint => 'Take a clear photo of the affected crop';

  @override
  String get home_gaugeStatusGood => 'Good';

  @override
  String get home_gaugeStatusCaution => 'Caution';

  @override
  String get home_gaugeStatusCritical => 'Critical';
}
