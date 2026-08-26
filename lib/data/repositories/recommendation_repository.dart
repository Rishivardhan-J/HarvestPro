import '../models/recommendation.dart';

abstract class RecommendationRepository {
  Future<List<Recommendation>> getActiveRecommendations(String farmerProfileId);
}
