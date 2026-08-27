// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get onboarding_languageScreenTitle =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get onboarding_continueButton => '[NEEDS_NATIVE_REVIEW] ಮುಂದುವರಿಸಿ';

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
          '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಸಮೀಪದ $count ರೈತರು ಇದೇ ಸಮಸ್ಯೆಯನ್ನು ವರದಿ ಮಾಡಿದ್ದಾರೆ',
      one: '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಸಮೀಪದ 1 ರೈತರು ಇದೇ ಸಮಸ್ಯೆಯನ್ನು ವರದಿ ಮಾಡಿದ್ದಾರೆ',
      zero: '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಸಮೀಪದ ಯಾವುದೇ ರೈತರು ಇದೇ ಸಮಸ್ಯೆಯನ್ನು ವರದಿ ಮಾಡಿಲ್ಲ',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint =>
      '[NEEDS_NATIVE_REVIEW] ಬಾಧಿತ ಬೆಳೆಯ ಸ್ಪಷ್ಟ ಫೋಟೋ ತೆಗೆದುಕೊಳ್ಳಿ';

  @override
  String get home_gaugeStatusGood => '[NEEDS_NATIVE_REVIEW] ಉತ್ತಮ';

  @override
  String get home_gaugeStatusCaution => '[NEEDS_NATIVE_REVIEW] ಎಚ್ಚರಿಕೆ';

  @override
  String get home_gaugeStatusCritical => '[NEEDS_NATIVE_REVIEW] ಗಂಭೀರ';

  @override
  String get onboarding_enterKisanIdTitle =>
      '[NEEDS_NATIVE_REVIEW] ಕಿಸಾನ್ ಐಡಿ ನಮೂದಿಸಿ';

  @override
  String get onboarding_enterKisanIdPrompt =>
      '[NEEDS_NATIVE_REVIEW] ದಯವಿಟ್ಟು ನಿಮ್ಮ 11-ಅಂಕಿಯ ಕಿಸಾನ್ ಐಡಿಯನ್ನು ನಮೂದಿಸಿ';

  @override
  String get onboarding_verifyButton => '[NEEDS_NATIVE_REVIEW] ಪರಿಶೀಲಿಸಿ';

  @override
  String get onboarding_noKisanId =>
      '[NEEDS_NATIVE_REVIEW] ನನಗೆ ಇನ್ನೂ ಕಿಸಾನ್ ಐಡಿ ಇಲ್ಲ';

  @override
  String get onboarding_identityVerificationTitle =>
      '[NEEDS_NATIVE_REVIEW] ಪರಿಶೀಲನೆ';

  @override
  String get onboarding_verifying =>
      '[NEEDS_NATIVE_REVIEW] ಪರಿಶೀಲಿಸಲಾಗುತ್ತಿದೆ...';

  @override
  String get onboarding_verifyError =>
      '[NEEDS_NATIVE_REVIEW] ನಾವು ಆ ಐಡಿಯನ್ನು ಪರಿಶೀಲಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನೀವು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಬಹುದು ಅಥವಾ ಸದ್ಯಕ್ಕೆ ಅದಿಲ್ಲದೆ ಮುಂದುವರಿಯಬಹುದು.';

  @override
  String get onboarding_retryButton => '[NEEDS_NATIVE_REVIEW] ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get onboarding_continueWithoutIt =>
      '[NEEDS_NATIVE_REVIEW] ಅದಿಲ್ಲದೆ ಮುಂದುವರಿಯಿರಿ';

  @override
  String get onboarding_successTitle =>
      '[NEEDS_NATIVE_REVIEW] ನಾವು ನಿಮ್ಮ ವಿವರಗಳನ್ನು ಕಂಡುಕೊಂಡಿದ್ದೇವೆ';

  @override
  String get onboarding_looksRightContinue =>
      '[NEEDS_NATIVE_REVIEW] ಸರಿಯಾಗಿದೆ, ಮುಂದುವರಿಸಿ';

  @override
  String get onboarding_manualEntryTitle =>
      '[NEEDS_NATIVE_REVIEW] ಪ್ರೊಫೈಲ್ ವಿವರಗಳು';

  @override
  String get onboarding_manualEntryPrompt =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಪ್ರೊಫೈಲ್ ಅನ್ನು ಹಸ್ತಚಾಲಿತವಾಗಿ ಹೊಂದಿಸೋಣ.';

  @override
  String get onboarding_nameLabel => '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಹೆಸರು';

  @override
  String get onboarding_villageLabel => '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಗ್ರಾಮ';

  @override
  String get onboarding_cropLabel => '[NEEDS_NATIVE_REVIEW] ಮುಖ್ಯ ಬೆಳೆ';

  @override
  String get onboarding_landSizeLabel =>
      '[NEEDS_NATIVE_REVIEW] ಅಂದಾಜು ಭೂಮಿಯ ಗಾತ್ರ';

  @override
  String get onboarding_consentTitleKisanId =>
      '[NEEDS_NATIVE_REVIEW] ಅನುಮತಿಗಳು ಮತ್ತು ಗೌಪ್ಯತೆ';

  @override
  String get onboarding_consentPromptKisanId =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಜಮೀನಿನ ವಿವರಗಳನ್ನು ಪಡೆಯುವ ಮೊದಲು...';

  @override
  String get onboarding_consentPromptManual =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಪ್ರೊಫೈಲ್ ಅನ್ನು ಉಳಿಸುವ ಮೊದಲು...';

  @override
  String get onboarding_allowButton => '[NEEDS_NATIVE_REVIEW] ಅನುಮತಿಸಿ';

  @override
  String get onboarding_notNowButton => '[NEEDS_NATIVE_REVIEW] ಈಗ ಬೇಡ';

  @override
  String get onboarding_consentDisclosureKisanId =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಗುರುತನ್ನು ಪರಿಶೀಲಿಸಲು ನಾವು ಇದನ್ನು ಬಳಸುತ್ತೇವೆ. ನಿಮ್ಮ ವಿವರಗಳನ್ನು ನಿಮ್ಮ ಸಾಧನದಲ್ಲಿ ಸುರಕ್ಷಿತವಾಗಿ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಲಾಗಿದೆ. ನೀವು ಸೆಟ್ಟಿಂಗ್‌ಗಳಿಂದ ಯಾವುದೇ ಸಮಯದಲ್ಲಿ ಈ ಡೇಟಾವನ್ನು ಅಳಿಸಬಹುದು.';

  @override
  String get onboarding_consentDisclosureManual =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ವಿವರಗಳನ್ನು ನಿಮ್ಮ ಸಾಧನದಲ್ಲಿ ಸುರಕ್ಷಿತವಾಗಿ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಲಾಗಿದೆ. ನಾವು ಈ ಡೇಟಾವನ್ನು ಹಂಚಿಕೊಳ್ಳುವುದಿಲ್ಲ. ನೀವು ಸೆಟ್ಟಿಂಗ್‌ಗಳಿಂದ ಯಾವುದೇ ಸಮಯದಲ್ಲಿ ಇದನ್ನು ಅಳಿಸಬಹುದು.';

  @override
  String get onboarding_learnMore => '[NEEDS_NATIVE_REVIEW] ಇನ್ನಷ್ಟು ತಿಳಿಯಿರಿ';

  @override
  String get onboarding_learnMoreText =>
      '[NEEDS_NATIVE_REVIEW] ನಿಮ್ಮ ಡೇಟಾವನ್ನು ಸ್ಥಳೀಯವಾಗಿ ರಕ್ಷಿಸಲು ಹಾರ್ವೆಸ್ಟ್‌ಪ್ರೊ ಉದ್ಯಮ-ಗುಣಮಟ್ಟದ AES-256 ಎನ್‌ಕ್ರಿಪ್ಶನ್ ಅನ್ನು ಬಳಸುತ್ತದೆ. ನೀವು ಸ್ಪಷ್ಟವಾಗಿ ಹಂಚಿಕೊಳ್ಳದ ಹೊರತು ಬೇರೆ ಯಾರಿಗೂ ಈ ಡೇಟಾಗೆ ಪ್ರವೇಶವಿಲ್ಲ. ನಿಮ್ಮ ಪ್ರೊಫೈಲ್ ಅನ್ನು ಅಳಿಸುವುದರಿಂದ ಅದಕ್ಕೆ ಸಂಬಂಧಿಸಿದ ಎಲ್ಲಾ ಸ್ಥಳೀಯ ದಾಖಲೆಗಳನ್ನು ಶಾಶ್ವತವಾಗಿ ತೆಗೆದುಹಾಕಲಾಗುತ್ತದೆ.';

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
