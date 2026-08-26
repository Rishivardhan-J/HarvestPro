// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get onboarding_languageScreenTitle =>
      'உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get onboarding_continueButton => 'தொடரவும்';

  @override
  String onboarding_languageName(String language) {
    return '$language';
  }

  @override
  String community_farmersReportedThis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'உங்களுக்கு அருகில் உள்ள $count விவசாயிகள் இதே பிரச்சினையைப் புகாரளித்துள்ளனர்',
      one: 'உங்களுக்கு அருகில் உள்ள 1 விவசாயி இதே பிரச்சினையைப் புகாரளித்துள்ளார்',
      zero: 'உங்களுக்கு அருகில் உள்ள எந்த விவசாயிகளும் இதே பிரச்சினையைப் புகாரளிக்கவில்லை',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint =>
      'பாதிக்கப்பட்ட பயிரின் தெளிவான புகைப்படத்தை எடுக்கவும்';

  @override
  String get home_gaugeStatusGood => 'நல்லது';

  @override
  String get home_gaugeStatusCaution => 'எச்சரிக்கை';

  @override
  String get home_gaugeStatusCritical => 'ஆபத்து';
}
