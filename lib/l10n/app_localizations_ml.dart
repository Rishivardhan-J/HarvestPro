// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get onboarding_languageScreenTitle =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ ഭാഷ തിരഞ്ഞെടുക്കുക';

  @override
  String get onboarding_continueButton => '[NEEDS_NATIVE_REVIEW] തുടരുക';

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
          '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ അടുത്തുള്ള $count കർഷകർക്ക് ഇതേ പ്രശ്നം അനുഭവപ്പെട്ടു',
      one: '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ അടുത്തുള്ള ഒരു കർഷകന് ഇതേ പ്രശ്നം അനുഭവപ്പെട്ടു',
      zero: '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ അടുത്തുള്ള കർഷകർക്കൊന്നും ഇതേ പ്രശ്നം അനുഭവപ്പെട്ടിട്ടില്ല',
    );
    return '$_temp0';
  }

  @override
  String get capture_shutterHint =>
      '[NEEDS_NATIVE_REVIEW] ബാധിച്ച വിളയുടെ വ്യക്തമായ ചിത്രമെടുക്കുക';

  @override
  String get home_gaugeStatusGood => '[NEEDS_NATIVE_REVIEW] നല്ലത്';

  @override
  String get home_gaugeStatusCaution => '[NEEDS_NATIVE_REVIEW] ശ്രദ്ധിക്കുക';

  @override
  String get home_gaugeStatusCritical => '[NEEDS_NATIVE_REVIEW] ഗുരുതരം';

  @override
  String get onboarding_enterKisanIdTitle =>
      '[NEEDS_NATIVE_REVIEW] കിസാൻ ഐഡി നൽകുക';

  @override
  String get onboarding_enterKisanIdPrompt =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ 11 അക്ക കിസാൻ ഐഡി നൽകുക';

  @override
  String get onboarding_verifyButton => '[NEEDS_NATIVE_REVIEW] പരിശോധിക്കുക';

  @override
  String get onboarding_noKisanId =>
      '[NEEDS_NATIVE_REVIEW] എനിക്ക് ഇതുവരെ കിസാൻ ഐഡി ഇല്ല';

  @override
  String get onboarding_identityVerificationTitle =>
      '[NEEDS_NATIVE_REVIEW] പരിശോധന';

  @override
  String get onboarding_verifying => '[NEEDS_NATIVE_REVIEW] പരിശോധിക്കുന്നു...';

  @override
  String get onboarding_verifyError =>
      '[NEEDS_NATIVE_REVIEW] ആ ഐഡി പരിശോധിക്കാൻ ഞങ്ങൾക്ക് കഴിഞ്ഞില്ല. നിങ്ങൾക്ക് വീണ്ടും ശ്രമിക്കാം, അല്ലെങ്കിൽ തൽക്കാലം അതില്ലാതെ തുടരാം.';

  @override
  String get onboarding_retryButton =>
      '[NEEDS_NATIVE_REVIEW] വീണ്ടും ശ്രമിക്കുക';

  @override
  String get onboarding_continueWithoutIt =>
      '[NEEDS_NATIVE_REVIEW] അതില്ലാതെ തുടരുക';

  @override
  String get onboarding_successTitle =>
      '[NEEDS_NATIVE_REVIEW] ഞങ്ങൾ നിങ്ങളുടെ വിവരങ്ങൾ കണ്ടെത്തി';

  @override
  String get onboarding_looksRightContinue =>
      '[NEEDS_NATIVE_REVIEW] ശരിയാണെന്ന് തോന്നുന്നു, തുടരുക';

  @override
  String get onboarding_manualEntryTitle =>
      '[NEEDS_NATIVE_REVIEW] പ്രൊഫൈൽ വിവരങ്ങൾ';

  @override
  String get onboarding_manualEntryPrompt =>
      '[NEEDS_NATIVE_REVIEW] നമുക്ക് നിങ്ങളുടെ പ്രൊഫൈൽ സ്വമേധയാ സജ്ജമാക്കാം.';

  @override
  String get onboarding_nameLabel => '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ പേര്';

  @override
  String get onboarding_villageLabel =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ ഗ്രാമം';

  @override
  String get onboarding_cropLabel => '[NEEDS_NATIVE_REVIEW] പ്രധാന വിള';

  @override
  String get onboarding_landSizeLabel =>
      '[NEEDS_NATIVE_REVIEW] ഏകദേശ ഭൂമിയുടെ വലിപ്പം';

  @override
  String get onboarding_consentTitleKisanId =>
      '[NEEDS_NATIVE_REVIEW] അനുമതികളും സ്വകാര്യതയും';

  @override
  String get onboarding_consentPromptKisanId =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ കൃഷിയിടത്തിന്റെ വിവരങ്ങൾ എടുക്കുന്നതിന് മുമ്പ്...';

  @override
  String get onboarding_consentPromptManual =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ പ്രൊഫൈൽ സംരക്ഷിക്കുന്നതിന് മുമ്പ്...';

  @override
  String get onboarding_allowButton => '[NEEDS_NATIVE_REVIEW] അനുവദിക്കുക';

  @override
  String get onboarding_notNowButton => '[NEEDS_NATIVE_REVIEW] ഇപ്പോളില്ല';

  @override
  String get onboarding_consentDisclosureKisanId =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ ഐഡന്റിറ്റി പരിശോധിക്കാൻ ഞങ്ങൾ ഇത് ഉപയോഗിക്കുന്നു. നിങ്ങളുടെ വിവരങ്ങൾ നിങ്ങളുടെ ഉപകരണത്തിൽ സുരക്ഷിതമായി എൻക്രിപ്റ്റ് ചെയ്തിരിക്കുന്നു. ക്രമീകരണങ്ങളിൽ നിന്ന് നിങ്ങൾക്ക് എപ്പോൾ വേണമെങ്കിലും ഈ ഡാറ്റ ഇല്ലാതാക്കാൻ കഴിയും.';

  @override
  String get onboarding_consentDisclosureManual =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ വിവരങ്ങൾ നിങ്ങളുടെ ഉപകരണത്തിൽ സുരക്ഷിതമായി എൻക്രിപ്റ്റ് ചെയ്തിരിക്കുന്നു. ഞങ്ങൾ ഈ ഡാറ്റ പങ്കിടില്ല. ക്രമീകരണങ്ങളിൽ നിന്ന് നിങ്ങൾക്ക് എപ്പോൾ വേണമെങ്കിലും ഇത് ഇല്ലാതാക്കാൻ കഴിയും.';

  @override
  String get onboarding_learnMore => '[NEEDS_NATIVE_REVIEW] കൂടുതൽ അറിയുക';

  @override
  String get onboarding_learnMoreText =>
      '[NEEDS_NATIVE_REVIEW] നിങ്ങളുടെ ഡാറ്റ പ്രാദേശികമായി പരിരക്ഷിക്കുന്നതിന് ഹാർവെസ്റ്റ്പ്രോ വ്യവസായ നിലവാരമുള്ള AES-256 എൻക്രിപ്ഷൻ ഉപയോഗിക്കുന്നു. നിങ്ങൾ വ്യക്തമായി പങ്കിടുന്നില്ലെങ്കിൽ മറ്റാർക്കും ഈ ഡാറ്റയിലേക്ക് ആക്സസ് ഇല്ല. നിങ്ങളുടെ പ്രൊഫൈൽ ഇല്ലാതാക്കുന്നത് ബന്ധപ്പെട്ട എല്ലാ പ്രാദേശിക രേഖകളും ശാശ്വതമായി നീക്കംചെയ്യും.';

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
