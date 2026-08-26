// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yield_prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YieldFactor _$YieldFactorFromJson(Map<String, dynamic> json) => _YieldFactor(
  label: json['label'] as String,
  contributionValue: (json['contributionValue'] as num).toDouble(),
  iconKey: json['iconKey'] as String,
);

Map<String, dynamic> _$YieldFactorToJson(_YieldFactor instance) =>
    <String, dynamic>{
      'label': instance.label,
      'contributionValue': instance.contributionValue,
      'iconKey': instance.iconKey,
    };

_YieldPrediction _$YieldPredictionFromJson(Map<String, dynamic> json) =>
    _YieldPrediction(
      id: json['id'] as String,
      farmerProfileId: json['farmerProfileId'] as String,
      predictedYieldPercent: (json['predictedYieldPercent'] as num).toDouble(),
      factors: (json['factors'] as List<dynamic>)
          .map((e) => YieldFactor.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceBadges: (json['sourceBadges'] as List<dynamic>)
          .map((e) => $enumDecode(_$SourceBadgeEnumMap, e))
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$YieldPredictionToJson(_YieldPrediction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmerProfileId': instance.farmerProfileId,
      'predictedYieldPercent': instance.predictedYieldPercent,
      'factors': instance.factors,
      'sourceBadges': instance.sourceBadges
          .map((e) => _$SourceBadgeEnumMap[e]!)
          .toList(),
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

const _$SourceBadgeEnumMap = {
  SourceBadge.imdWeatherVerified: 'imdWeatherVerified',
  SourceBadge.agriStackLinked: 'agriStackLinked',
};
