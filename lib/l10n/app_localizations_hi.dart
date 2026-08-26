// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get onboarding_languageScreenTitle => 'अपनी भाषा चुनें';

  @override
  String get onboarding_continueButton => 'जारी रखें';

  @override
  String onboarding_languageName(String language) {
    return '$language';
  }

  @override
  String community_farmersReportedThis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपके आस-पास $count किसानों ने इस समस्या की रिपोर्ट की है',
      one: 'आपके आस-पास 1 किसान ने इस समस्या की रिपोर्ट की है',
      zero: 'आपके आस-पास किसी भी किसान ने इस समस्या की रिपोर्ट नहीं की है',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint => 'प्रभावित फसल की एक स्पष्ट तस्वीर लें';

  @override
  String get home_gaugeStatusGood => 'अच्छा';

  @override
  String get home_gaugeStatusCaution => 'सावधान';

  @override
  String get home_gaugeStatusCritical => 'गंभीर';
}
