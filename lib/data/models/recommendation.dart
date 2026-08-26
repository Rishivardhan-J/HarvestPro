import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation.freezed.dart';
part 'recommendation.g.dart';

enum EstimatedValueUnit { perAcre, total }
enum RecommendationCategory { fertilizer, pest, irrigation, harvest, other }
enum RecommendationStatus { pending, done, remindLater }

@freezed
abstract class Recommendation with _$Recommendation {
  const factory Recommendation({
    required String id,
    required String farmerProfileId,
    required String titleKey,
    required String descriptionKey,
    required double estimatedValueRupees,
    required EstimatedValueUnit estimatedValueUnit,
    required RecommendationCategory category,
    required RecommendationStatus status,
    required String iconKey,
    required DateTime createdAt,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) => _$RecommendationFromJson(json);
}
