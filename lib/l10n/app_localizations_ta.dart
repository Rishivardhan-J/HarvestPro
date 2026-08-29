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

  @override
  String get onboarding_enterKisanIdTitle => 'கிசான் ஐடி உள்ளிடவும்';

  @override
  String get onboarding_enterKisanIdPrompt =>
      'உங்கள் 11 இலக்க கிசான் ஐடியை உள்ளிடவும்';

  @override
  String get onboarding_verifyButton => 'சரிபார்';

  @override
  String get onboarding_noKisanId => 'என்னிடம் இன்னும் கிசான் ஐடி இல்லை';

  @override
  String get onboarding_identityVerificationTitle => 'சரிபார்த்தல்';

  @override
  String get onboarding_verifying => 'சரிபார்க்கிறது...';

  @override
  String get onboarding_verifyError =>
      'அந்த ஐடியை சரிபார்க்க முடியவில்லை. நீங்கள் மீண்டும் முயற்சிக்கலாம் அல்லது இப்போது இல்லாமல் தொடரலாம்.';

  @override
  String get onboarding_retryButton => 'மீண்டும் முயற்சி செய்';

  @override
  String get onboarding_continueWithoutIt => 'அது இல்லாமல் தொடரவும்';

  @override
  String get onboarding_successTitle =>
      'உங்கள் விவரங்களை நாங்கள் கண்டுபிடித்துள்ளோம்';

  @override
  String get onboarding_looksRightContinue => 'சரியாக உள்ளது, தொடரவும்';

  @override
  String get onboarding_manualEntryTitle => 'சுயவிவர விவரங்கள்';

  @override
  String get onboarding_manualEntryPrompt =>
      'உங்கள் சுயவிவரத்தை கைமுறையாக அமைப்போம்.';

  @override
  String get onboarding_nameLabel => 'உங்கள் பெயர்';

  @override
  String get onboarding_villageLabel => 'உங்கள் கிராமம்';

  @override
  String get onboarding_cropLabel => 'முதன்மை பயிர்';

  @override
  String get onboarding_landSizeLabel => 'தோராயமான நில அளவு';

  @override
  String get onboarding_consentTitleKisanId => 'அனுமதிகள் & தனியுரிமை';

  @override
  String get onboarding_consentPromptKisanId =>
      'உங்கள் பண்ணை விவரங்களை நாங்கள் எடுப்பதற்கு முன்...';

  @override
  String get onboarding_consentPromptManual =>
      'உங்கள் சுயவிவரத்தை நாங்கள் சேமிக்கும் முன்...';

  @override
  String get onboarding_allowButton => 'அனுமதி';

  @override
  String get onboarding_notNowButton => 'இப்போது இல்லை';

  @override
  String get onboarding_consentDisclosureKisanId =>
      'உங்கள் அடையாளத்தை சரிபார்க்க இதைப் பயன்படுத்துகிறோம். உங்கள் விவரங்கள் உங்கள் சாதனத்தில் பாதுகாப்பாக குறியாக்கம் செய்யப்பட்டுள்ளன. நீங்கள் எந்த நேரத்திலும் அமைப்புகளிலிருந்து இந்தத் தரவை நீக்கலாம்.';

  @override
  String get onboarding_consentDisclosureManual =>
      'உங்கள் விவரங்கள் உங்கள் சாதனத்தில் பாதுகாப்பாக குறியாக்கம் செய்யப்பட்டுள்ளன. நாங்கள் இந்தத் தரவைப் பகிர மாட்டோம். நீங்கள் எந்த நேரத்திலும் அமைப்புகளிலிருந்து இதை நீக்கலாம்.';

  @override
  String get onboarding_learnMore => 'மேலும் அறிக';

  @override
  String get onboarding_learnMoreText =>
      'உங்கள் தரவை உள்ளூரில் பாதுகாக்க HarvestPro தொழில்-தரநிலை AES-256 குறியாக்கத்தைப் பயன்படுத்துகிறது. நீங்கள் வெளிப்படையாகப் பகிராத வரை வேறு எவருக்கும் இந்தத் தரவுக்கான அணுகல் இல்லை. உங்கள் சுயவிவரத்தை நீக்குவது தொடர்புடைய அனைத்து உள்ளூர் பதிவுகளையும் நிரந்தரமாக அகற்றும்.';

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
