// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get onboarding_languageScreenTitle => 'ਆਪਣੀ ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get onboarding_continueButton => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String onboarding_languageName(String language) {
    return '$language';
  }

  @override
  String community_farmersReportedThis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ਤੁਹਾਡੇ ਨੇੜੇ $count ਕਿਸਾਨਾਂ ਨੇ ਇਸ ਸਮੱਸਿਆ ਦੀ ਰਿਪੋਰਟ ਕੀਤੀ',
      one: 'ਤੁਹਾਡੇ ਨੇੜੇ 1 ਕਿਸਾਨ ਨੇ ਇਸ ਸਮੱਸਿਆ ਦੀ ਰਿਪੋਰਟ ਕੀਤੀ',
      zero: 'ਤੁਹਾਡੇ ਨੇੜੇ ਕਿਸੇ ਵੀ ਕਿਸਾਨ ਨੇ ਇਸ ਸਮੱਸਿਆ ਦੀ ਰਿਪੋਰਟ ਨਹੀਂ ਕੀਤੀ',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint => 'ਪ੍ਰਭਾਵਿਤ ਫਸਲ ਦੀ ਸਪਸ਼ਟ ਫੋਟੋ ਲਓ';

  @override
  String get home_gaugeStatusGood => 'ਵਧੀਆ';

  @override
  String get home_gaugeStatusCaution => 'ਸਾਵਧਾਨੀ';

  @override
  String get home_gaugeStatusCritical => 'ਗੰਭੀਰ';
}
