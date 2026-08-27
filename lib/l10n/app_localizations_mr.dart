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

  @override
  String get onboarding_enterKisanIdTitle => 'Enter Kisan ID';

  @override
  String get onboarding_enterKisanIdPrompt =>
      'Please enter your 11-digit Kisan ID';

  @override
  String get onboarding_verifyButton => 'Verify';

  @override
  String get onboarding_noKisanId => 'I don\'t have a Kisan ID yet';

  @override
  String get onboarding_identityVerificationTitle => 'Verification';

  @override
  String get onboarding_verifying => 'Verifying...';

  @override
  String get onboarding_verifyError =>
      'We couldn\'t verify that ID. You can try again, or continue without it for now.';

  @override
  String get onboarding_retryButton => 'Retry';

  @override
  String get onboarding_continueWithoutIt => 'Continue without it';

  @override
  String get onboarding_successTitle => 'We found your details';

  @override
  String get onboarding_looksRightContinue => 'Looks right, continue';

  @override
  String get onboarding_manualEntryTitle => 'Profile Details';

  @override
  String get onboarding_manualEntryPrompt =>
      'Let\'s set up your profile manually.';

  @override
  String get onboarding_nameLabel => 'Your Name';

  @override
  String get onboarding_villageLabel => 'Your Village';

  @override
  String get onboarding_cropLabel => 'Primary Crop';

  @override
  String get onboarding_landSizeLabel => 'Rough Land Size';

  @override
  String get onboarding_consentTitleKisanId => 'Permissions & Privacy';

  @override
  String get onboarding_consentPromptKisanId =>
      'Before we pull your farm details...';

  @override
  String get onboarding_consentPromptManual => 'Before we save your profile...';

  @override
  String get onboarding_allowButton => 'Allow';

  @override
  String get onboarding_notNowButton => 'Not now';

  @override
  String get onboarding_consentDisclosureKisanId =>
      'We use this to verify your identity. Your details are encrypted safely on your device. You can delete this data at any time from Settings.';

  @override
  String get onboarding_consentDisclosureManual =>
      'Your details are encrypted safely on your device. We do not share this data. You can delete it at any time from Settings.';

  @override
  String get onboarding_learnMore => 'Learn more';

  @override
  String get onboarding_learnMoreText =>
      'HarvestPro uses industry-standard AES-256 encryption to protect your data locally. No one else has access to this data unless you explicitly share it. Deleting your profile will permanently remove all associated local records.';

  @override
  String home_yieldSummarySameSign(
    String percent,
    String factor1,
    String factor2,
  ) {
    return 'Your predicted yield is $percent% due to $factor1 and $factor2';
  }

  @override
  String home_yieldSummaryOppositeSign(
    String percent,
    String factor1,
    String factor2,
  ) {
    return 'Your predicted yield is $percent% — $factor1 is helping, but $factor2 is pulling it down';
  }

  @override
  String get factor_soilMoisture => 'Soil Moisture';

  @override
  String get factor_pestRisk => 'Pest Risk';

  @override
  String get factor_rainfall => 'Rainfall';
}
