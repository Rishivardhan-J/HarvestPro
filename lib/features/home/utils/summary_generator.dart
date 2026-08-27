import 'package:harvestpro/l10n/app_localizations.dart';
import '../../../data/models/yield_prediction.dart';

class SummaryGenerator {
  static String generate(YieldPrediction prediction, AppLocalizations l10n) {
    if (prediction.factors.isEmpty) {
      return '';
    }

    final sortedFactors = List<YieldFactor>.from(prediction.factors)
      ..sort((a, b) => b.contributionValue.abs().compareTo(a.contributionValue.abs()));

    final topFactors = sortedFactors.take(2).toList();
    final percentStr = prediction.predictedYieldPercent.toInt().toString();

    if (topFactors.length == 1) {
      final f1 = _localizeFactor(topFactors[0].label, l10n);
      return l10n.home_yieldSummarySameSign(percentStr, f1, ''); 
      // Note: we can ignore the empty string since we assume there are always 2 factors in the template. 
      // For robustness, ideally we have a 1-factor template, but we will pass empty string for now.
    }

    final f1 = topFactors[0];
    final f2 = topFactors[1];
    
    final f1Loc = _localizeFactor(f1.label, l10n);
    final f2Loc = _localizeFactor(f2.label, l10n);

    // If both help (positive) or both hurt (negative)
    if ((f1.contributionValue >= 0 && f2.contributionValue >= 0) ||
        (f1.contributionValue < 0 && f2.contributionValue < 0)) {
      return l10n.home_yieldSummarySameSign(percentStr, f1Loc, f2Loc);
    } else {
      // Opposite signs
      // The template is "{factor1} is helping, but {factor2} is pulling it down"
      // We should put the positive one as factor1, and negative as factor2, regardless of absolute magnitude
      // to make the sentence grammatically correct.
      final positiveFactor = f1.contributionValue >= 0 ? f1Loc : f2Loc;
      final negativeFactor = f1.contributionValue < 0 ? f1Loc : f2Loc;
      return l10n.home_yieldSummaryOppositeSign(percentStr, positiveFactor, negativeFactor);
    }
  }

  static String _localizeFactor(String labelKey, AppLocalizations l10n) {
    switch (labelKey) {
      case 'factor_soilMoisture':
        return l10n.factor_soilMoisture;
      case 'factor_pestRisk':
        return l10n.factor_pestRisk;
      case 'factor_rainfall':
        return l10n.factor_rainfall;
      default:
        return labelKey; // Fallback
    }
  }
}
