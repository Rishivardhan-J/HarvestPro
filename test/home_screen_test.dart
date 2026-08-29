// ignore_for_file: non_constant_identifier_names
import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/data/models/yield_prediction.dart';
import 'package:harvestpro/features/home/utils/summary_generator.dart';
import 'package:harvestpro/l10n/app_localizations.dart';

// Dummy wrapper for l10n to test summary logic
class TestLocalizations extends AppLocalizations {
  TestLocalizations() : super('en');

  @override
  String get onboarding_languageScreenTitle => '';
  @override
  String get onboarding_continueButton => '';
  @override
  String onboarding_languageName(String language) => '';
  @override
  String community_farmersReportedThis(int count) => '';
  @override
  String get capture_shutterHint => '';
  @override
  String get home_gaugeStatusGood => '';
  @override
  String get home_gaugeStatusCaution => '';
  @override
  String get home_gaugeStatusCritical => '';
  @override
  String get onboarding_enterKisanIdTitle => '';
  @override
  String get onboarding_enterKisanIdPrompt => '';
  @override
  String get onboarding_verifyButton => '';
  @override
  String get onboarding_noKisanId => '';
  @override
  String get onboarding_identityVerificationTitle => '';
  @override
  String get onboarding_verifying => '';
  @override
  String get onboarding_verifyError => '';
  @override
  String get onboarding_retryButton => '';
  @override
  String get onboarding_continueWithoutIt => '';
  @override
  String get onboarding_successTitle => '';
  @override
  String get onboarding_looksRightContinue => '';
  @override
  String get onboarding_manualEntryTitle => '';
  @override
  String get onboarding_manualEntryPrompt => '';
  @override
  String get onboarding_nameLabel => '';
  @override
  String get onboarding_villageLabel => '';
  @override
  String get onboarding_cropLabel => '';
  @override
  String get onboarding_landSizeLabel => '';
  @override
  String get onboarding_consentTitleKisanId => '';
  @override
  String get onboarding_consentPromptKisanId => '';
  @override
  String get onboarding_consentPromptManual => '';
  @override
  String get onboarding_allowButton => '';
  @override
  String get onboarding_notNowButton => '';
  @override
  String get onboarding_consentDisclosureKisanId => '';
  @override
  String get onboarding_consentDisclosureManual => '';
  @override
  String get onboarding_learnMore => '';
  @override
  String get onboarding_learnMoreText => '';
  
  @override
  String get capture_cameraRationale => '';
  @override
  String get capture_dailyCheckInTitle => '';
  @override
  String get capture_instructionPhoto => '';
  @override
  String get capture_instructionText => '';
  @override
  String get capture_instructionVoice => '';
  @override
  String get capture_micRationale => '';
  @override
  String get capture_permissionDeniedText => '';
  @override
  String get capture_permissionDeniedTitle => '';
  @override
  String get capture_retakeButton => '';
  @override
  String get capture_usePhotoButton => '';
  @override
  String get capture_useTextButton => '';
  @override
  String get capture_useVoiceButton => '';

  @override
  String home_yieldSummarySameSign(String percent, String factor1, String factor2) {
    return 'Your predicted yield is $percent% due to $factor1 and $factor2';
  }

  @override
  String home_yieldSummaryOppositeSign(String percent, String factor1, String factor2) {
    return 'Your predicted yield is $percent% — $factor1 is helping, but $factor2 is pulling it down';
  }

  @override
  String get factor_soilMoisture => 'Soil Moisture';
  @override
  String get factor_pestRisk => 'Pest Risk';
  @override
  String get factor_rainfall => 'Rainfall';

  // Phase 7 Mock Strings
  @override
  String get recommendations_title => '';
  @override
  String get recommendations_done => '';
  @override
  String get recommendations_remindLater => '';
  @override
  String get recommendations_emptyTitle => '';
  @override
  String recommendations_emptySubtitle(int count) => '';
  @override
  String recommendations_valuePerAcre(String value, String acres) => '';
  @override
  String recommendations_valueTotal(String value) => '';
  @override
  String get community_title => '';
  @override
  String get community_emptyFeed => '';
  @override
  String community_helpfulBadge(int count) => '';
  @override
  String get community_reportAck => '';
  @override
  String community_streakTitle(int days) => '';
  @override
  String get community_helplineExpert => '';
  @override
  String get community_helplinePerson => '';
  @override
  String get community_helplineMock => '';

  @override
  String get recommendations_fertilizer_urea => '';
  @override
  String get recommendations_fertilizer_urea_desc => '';
  @override
  String get recommendations_pest_stem_borer => '';
  @override
  String get recommendations_pest_stem_borer_desc => '';
}

void main() {
  group('SummaryGenerator', () {
    test('Opposite signs formatting', () {
      final prediction = YieldPrediction(
        id: 'test',
        farmerProfileId: '1',
        predictedYieldPercent: 65,
        factors: const [
          YieldFactor(label: 'factor_soilMoisture', contributionValue: 0.15, iconKey: 'water'),
          YieldFactor(label: 'factor_pestRisk', contributionValue: -0.10, iconKey: 'bug'),
        ],
        sourceBadges: [],
        generatedAt: DateTime.now(),
      );

      final result = SummaryGenerator.generate(prediction, TestLocalizations());
      expect(result, 'Your predicted yield is 65% — Soil Moisture is helping, but Pest Risk is pulling it down');
    });

    test('Same signs formatting', () {
      final prediction = YieldPrediction(
        id: 'test',
        farmerProfileId: '1',
        predictedYieldPercent: 23,
        factors: const [
          YieldFactor(label: 'factor_rainfall', contributionValue: -0.40, iconKey: 'cloud'),
          YieldFactor(label: 'factor_soilMoisture', contributionValue: -0.20, iconKey: 'water'),
        ],
        sourceBadges: [],
        generatedAt: DateTime.now(),
      );

      final result = SummaryGenerator.generate(prediction, TestLocalizations());
      expect(result, 'Your predicted yield is 23% due to Rainfall and Soil Moisture');
    });
  });
}
