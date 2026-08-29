import '../models/recommendation.dart';

abstract class RecommendationRepository {
  Future<List<Recommendation>> getActiveRecommendations(String farmerProfileId);
  Future<void> updateRecommendationStatus(String id, RecommendationStatus status, {DateTime? scheduledFor});
  Future<List<Recommendation>> getCompletedRecommendations(String farmerProfileId);
}
