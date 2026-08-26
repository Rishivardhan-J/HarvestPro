// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get onboarding_languageScreenTitle => 'మీ భాషను ఎంచుకోండి';

  @override
  String get onboarding_continueButton => 'కొనసాగించు';

  @override
  String onboarding_languageName(String language) {
    return '$language';
  }

  @override
  String community_farmersReportedThis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'మీకు సమీపంలో $count రైతులు ఈ సమస్యను నివేదించారు',
      one: 'మీకు సమీపంలో 1 రైతు ఈ సమస్యను నివేదించారు',
      zero: 'మీకు సమీపంలో ఏ రైతు ఈ సమస్యను నివేదించలేదు',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint => 'ప్రభావిత పంట యొక్క స్పష్టమైన ఫోటో తీయండి';

  @override
  String get home_gaugeStatusGood => 'బాగుంది';

  @override
  String get home_gaugeStatusCaution => 'హెచ్చరిక';

  @override
  String get home_gaugeStatusCritical => 'క్లిష్టమైన';
}
