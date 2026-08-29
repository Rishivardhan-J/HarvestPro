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

  @override
  String get recommendations_title => 'Recommendations';

  @override
  String get recommendations_done => 'Done';

  @override
  String get recommendations_remindLater => 'Remind later';

  @override
  String get recommendations_emptyTitle => 'You\'re all caught up';

  @override
  String recommendations_emptySubtitle(int count) {
    return 'Marked $count done today';
  }

  @override
  String recommendations_valuePerAcre(String value, String acres) {
    return 'worth an estimated ₹$value on your $acres-acre plot';
  }

  @override
  String recommendations_valueTotal(String value) {
    return 'worth an estimated ₹$value';
  }

  @override
  String get community_title => 'Community';

  @override
  String get community_emptyFeed => 'Be one of the first to share here';

  @override
  String community_helpfulBadge(int count) {
    return 'Helped $count neighbors this week';
  }

  @override
  String get community_reportAck => 'Thanks, we\'ll look into it';

  @override
  String community_streakTitle(int days) {
    return 'Your plant is sprouting! $days days in a row';
  }

  @override
  String get community_helplineExpert => 'Talk to Krishi Expert';

  @override
  String get community_helplinePerson => 'Talk to a real person';

  @override
  String get community_helplineMock => 'We\'ll call you back shortly';

  @override
  String get recommendations_fertilizer_urea => 'Apply Urea Fertilizer';

  @override
  String get recommendations_fertilizer_urea_desc =>
      'Your soil nitrogen levels are low. Applying urea now will boost vegetative growth.';

  @override
  String get recommendations_pest_stem_borer => 'Stem Borer Risk High';

  @override
  String get recommendations_pest_stem_borer_desc =>
      'Weather conditions are highly favorable for stem borers. Preventative spray recommended within 48 hours.';
}
