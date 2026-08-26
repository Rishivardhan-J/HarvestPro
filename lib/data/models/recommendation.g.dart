// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    _Recommendation(
      id: json['id'] as String,
      farmerProfileId: json['farmerProfileId'] as String,
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
      estimatedValueRupees: (json['estimatedValueRupees'] as num).toDouble(),
      estimatedValueUnit: $enumDecode(
        _$EstimatedValueUnitEnumMap,
        json['estimatedValueUnit'],
      ),
      category: $enumDecode(_$RecommendationCategoryEnumMap, json['category']),
      status: $enumDecode(_$RecommendationStatusEnumMap, json['status']),
      iconKey: json['iconKey'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecommendationToJson(_Recommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmerProfileId': instance.farmerProfileId,
      'titleKey': instance.titleKey,
      'descriptionKey': instance.descriptionKey,
      'estimatedValueRupees': instance.estimatedValueRupees,
      'estimatedValueUnit':
          _$EstimatedValueUnitEnumMap[instance.estimatedValueUnit]!,
      'category': _$RecommendationCategoryEnumMap[instance.category]!,
      'status': _$RecommendationStatusEnumMap[instance.status]!,
      'iconKey': instance.iconKey,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$EstimatedValueUnitEnumMap = {
  EstimatedValueUnit.perAcre: 'perAcre',
  EstimatedValueUnit.total: 'total',
};

const _$RecommendationCategoryEnumMap = {
  RecommendationCategory.fertilizer: 'fertilizer',
  RecommendationCategory.pest: 'pest',
  RecommendationCategory.irrigation: 'irrigation',
  RecommendationCategory.harvest: 'harvest',
  RecommendationCategory.other: 'other',
};

const _$RecommendationStatusEnumMap = {
  RecommendationStatus.pending: 'pending',
  RecommendationStatus.done: 'done',
  RecommendationStatus.remindLater: 'remindLater',
};
