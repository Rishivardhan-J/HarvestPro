import 'dart:math';
import '../models/recommendation.dart';
import 'recommendation_repository.dart';

class MockRecommendationRepository implements RecommendationRepository {
  final double failureRate;
  final Random _random;

  MockRecommendationRepository({this.failureRate = 0.0, int? seed})
      : _random = Random(seed);

  Future<void> _simulateLatencyAndFailure() async {
    final delay = 300 + _random.nextInt(600);
    await Future.delayed(Duration(milliseconds: delay));
    if (_random.nextDouble() < failureRate) {
      throw Exception('Simulated network failure in MockRecommendationRepository');
    }
  }

  @override
  Future<List<Recommendation>> getActiveRecommendations(String farmerProfileId) async {
    await _simulateLatencyAndFailure();
    
    // Seed realistic paddy recommendations for a Thanjavur small-holding (~1.5 acres)
    return [
      Recommendation(
        id: 'mock_rec_1',
        farmerProfileId: farmerProfileId,
        titleKey: 'recommendation_fertilizer_urea',
        descriptionKey: 'recommendation_fertilizer_urea_desc',
        estimatedValueRupees: 450.0,
        estimatedValueUnit: EstimatedValueUnit.perAcre,
        category: RecommendationCategory.fertilizer,
        status: RecommendationStatus.pending,
        iconKey: 'science',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Recommendation(
        id: 'mock_rec_2',
        farmerProfileId: farmerProfileId,
        titleKey: 'recommendation_pest_stem_borer',
        descriptionKey: 'recommendation_pest_stem_borer_desc',
        estimatedValueRupees: 1200.0,
        estimatedValueUnit: EstimatedValueUnit.total,
        category: RecommendationCategory.pest,
        status: RecommendationStatus.pending,
        iconKey: 'pest_control',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}
