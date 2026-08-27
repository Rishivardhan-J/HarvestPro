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

  @override
  String get capture_instructionPhoto => 'Point your camera at the leaf';

  @override
  String get capture_instructionVoice => 'Tap the mic to describe what you see';

  @override
  String get capture_instructionText => 'Describe what you\'re seeing';

  @override
  String get capture_retakeButton => 'Retake';

  @override
  String get capture_usePhotoButton => 'Use this photo';

  @override
  String get capture_useVoiceButton => 'Use this recording';

  @override
  String get capture_useTextButton => 'Submit note';

  @override
  String get capture_cameraRationale =>
      'HarvestPro needs your camera to check this leaf';

  @override
  String get capture_micRationale =>
      'HarvestPro needs your microphone to record your note';

  @override
  String get capture_permissionDeniedTitle => 'Permission Denied';

  @override
  String get capture_permissionDeniedText =>
      'You have permanently denied this permission. Please enable it in Settings.';

  @override
  String get capture_dailyCheckInTitle => 'How\'s your field today?';
}
