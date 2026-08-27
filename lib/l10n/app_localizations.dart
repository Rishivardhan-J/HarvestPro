import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
    Locale('ml'),
    Locale('mr'),
    Locale('pa'),
    Locale('ta'),
    Locale('te'),
  ];

  /// Title text on the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get onboarding_languageScreenTitle;

  /// Primary action button to confirm the language selection
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboarding_continueButton;

  /// Semantic label for screen readers to read the language natively and in English
  ///
  /// In en, this message translates to:
  /// **'{language}'**
  String onboarding_languageName(String language);

  /// Pluralized text indicating how many farmers reported a specific issue
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No farmers near you reported the same issue} =1{1 farmer near you reported the same issue} other{{count} farmers near you reported the same issue}}'**
  String community_farmersReportedThis(int count);

  /// Hint text displayed near the camera shutter button
  ///
  /// In en, this message translates to:
  /// **'Take a clear photo of the affected crop'**
  String get capture_shutterHint;

  /// Status text indicating healthy crop status in the yield gauge
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get home_gaugeStatusGood;

  /// Status text indicating cautious crop status in the yield gauge
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get home_gaugeStatusCaution;

  /// Status text indicating critical crop status in the yield gauge
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get home_gaugeStatusCritical;

  /// No description provided for @onboarding_enterKisanIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Kisan ID'**
  String get onboarding_enterKisanIdTitle;

  /// No description provided for @onboarding_enterKisanIdPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter your 11-digit Kisan ID'**
  String get onboarding_enterKisanIdPrompt;

  /// No description provided for @onboarding_verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get onboarding_verifyButton;

  /// No description provided for @onboarding_noKisanId.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have a Kisan ID yet'**
  String get onboarding_noKisanId;

  /// No description provided for @onboarding_identityVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get onboarding_identityVerificationTitle;

  /// No description provided for @onboarding_verifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get onboarding_verifying;

  /// No description provided for @onboarding_verifyError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t verify that ID. You can try again, or continue without it for now.'**
  String get onboarding_verifyError;

  /// No description provided for @onboarding_retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get onboarding_retryButton;

  /// No description provided for @onboarding_continueWithoutIt.
  ///
  /// In en, this message translates to:
  /// **'Continue without it'**
  String get onboarding_continueWithoutIt;

  /// No description provided for @onboarding_successTitle.
  ///
  /// In en, this message translates to:
  /// **'We found your details'**
  String get onboarding_successTitle;

  /// No description provided for @onboarding_looksRightContinue.
  ///
  /// In en, this message translates to:
  /// **'Looks right, continue'**
  String get onboarding_looksRightContinue;

  /// No description provided for @onboarding_manualEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get onboarding_manualEntryTitle;

  /// No description provided for @onboarding_manualEntryPrompt.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your profile manually.'**
  String get onboarding_manualEntryPrompt;

  /// No description provided for @onboarding_nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get onboarding_nameLabel;

  /// No description provided for @onboarding_villageLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Village'**
  String get onboarding_villageLabel;

  /// No description provided for @onboarding_cropLabel.
  ///
  /// In en, this message translates to:
  /// **'Primary Crop'**
  String get onboarding_cropLabel;

  /// No description provided for @onboarding_landSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Rough Land Size'**
  String get onboarding_landSizeLabel;

  /// No description provided for @onboarding_consentTitleKisanId.
  ///
  /// In en, this message translates to:
  /// **'Permissions & Privacy'**
  String get onboarding_consentTitleKisanId;

  /// No description provided for @onboarding_consentPromptKisanId.
  ///
  /// In en, this message translates to:
  /// **'Before we pull your farm details...'**
  String get onboarding_consentPromptKisanId;

  /// No description provided for @onboarding_consentPromptManual.
  ///
  /// In en, this message translates to:
  /// **'Before we save your profile...'**
  String get onboarding_consentPromptManual;

  /// No description provided for @onboarding_allowButton.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get onboarding_allowButton;

  /// No description provided for @onboarding_notNowButton.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get onboarding_notNowButton;

  /// No description provided for @onboarding_consentDisclosureKisanId.
  ///
  /// In en, this message translates to:
  /// **'We use this to verify your identity. Your details are encrypted safely on your device. You can delete this data at any time from Settings.'**
  String get onboarding_consentDisclosureKisanId;

  /// No description provided for @onboarding_consentDisclosureManual.
  ///
  /// In en, this message translates to:
  /// **'Your details are encrypted safely on your device. We do not share this data. You can delete it at any time from Settings.'**
  String get onboarding_consentDisclosureManual;

  /// No description provided for @onboarding_learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get onboarding_learnMore;

  /// No description provided for @onboarding_learnMoreText.
  ///
  /// In en, this message translates to:
  /// **'HarvestPro uses industry-standard AES-256 encryption to protect your data locally. No one else has access to this data unless you explicitly share it. Deleting your profile will permanently remove all associated local records.'**
  String get onboarding_learnMoreText;

  /// No description provided for @home_yieldSummarySameSign.
  ///
  /// In en, this message translates to:
  /// **'Your predicted yield is {percent}% due to {factor1} and {factor2}'**
  String home_yieldSummarySameSign(
    String percent,
    String factor1,
    String factor2,
  );

  /// No description provided for @home_yieldSummaryOppositeSign.
  ///
  /// In en, this message translates to:
  /// **'Your predicted yield is {percent}% — {factor1} is helping, but {factor2} is pulling it down'**
  String home_yieldSummaryOppositeSign(
    String percent,
    String factor1,
    String factor2,
  );

  /// No description provided for @factor_soilMoisture.
  ///
  /// In en, this message translates to:
  /// **'Soil Moisture'**
  String get factor_soilMoisture;

  /// No description provided for @factor_pestRisk.
  ///
  /// In en, this message translates to:
  /// **'Pest Risk'**
  String get factor_pestRisk;

  /// No description provided for @factor_rainfall.
  ///
  /// In en, this message translates to:
  /// **'Rainfall'**
  String get factor_rainfall;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'hi',
    'kn',
    'ml',
    'mr',
    'pa',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
