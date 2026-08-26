// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get onboarding_languageScreenTitle => 'तुमची भाषा निवडा';

  @override
  String get onboarding_continueButton => 'पुढे सुरू ठेवा';

  @override
  String onboarding_languageName(String language) {
    return '$language';
  }

  @override
  String community_farmersReportedThis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'तुमच्या जवळील $count शेतकऱ्यांनी या समस्येची तक्रार केली',
      one: 'तुमच्या जवळील 1 शेतकऱ्याने या समस्येची तक्रार केली',
      zero: 'तुमच्या जवळील कोणत्याही शेतकऱ्याने या समस्येची तक्रार केली नाही',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint => 'बाधित पिकाचा स्पष्ट फोटो काढा';

  @override
  String get home_gaugeStatusGood => 'चांगले';

  @override
  String get home_gaugeStatusCaution => 'सावधान';

  @override
  String get home_gaugeStatusCritical => 'गंभीर';
}
