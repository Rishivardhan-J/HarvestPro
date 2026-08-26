import 'package:freezed_annotation/freezed_annotation.dart';

part 'yield_prediction.freezed.dart';
part 'yield_prediction.g.dart';

enum YieldStatus { good, caution, critical }
enum SourceBadge { imdWeatherVerified, agriStackLinked }

@freezed
abstract class YieldFactor with _$YieldFactor {
  const factory YieldFactor({
    required String label,
    required double contributionValue,
    required String iconKey,
  }) = _YieldFactor;

  factory YieldFactor.fromJson(Map<String, dynamic> json) => _$YieldFactorFromJson(json);
}

@freezed
abstract class YieldPrediction with _$YieldPrediction {
  const YieldPrediction._();

  const factory YieldPrediction({
    required String id,
    required String farmerProfileId,
    required double predictedYieldPercent,
    required List<YieldFactor> factors,
    required List<SourceBadge> sourceBadges,
    required DateTime generatedAt,
  }) = _YieldPrediction;

  YieldStatus get status => deriveStatus(predictedYieldPercent);

  static YieldStatus deriveStatus(double percent) {
    if (percent >= 70.0) {
      return YieldStatus.good;
    }
    if (percent >= 40.0) {
      return YieldStatus.caution;
    }
    return YieldStatus.critical;
  }

  factory YieldPrediction.fromJson(Map<String, dynamic> json) => _$YieldPredictionFromJson(json);
}
