import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/community_repository.dart';
import '../../data/repositories/farmer_profile_repository.dart';
import '../../data/repositories/mock_community_repository.dart';
import '../../data/repositories/mock_farmer_profile_repository.dart';
import '../../data/repositories/mock_recommendation_repository.dart';
import '../../data/repositories/mock_yield_repository.dart';
import '../../data/repositories/recommendation_repository.dart';
import '../../data/repositories/yield_repository.dart';

export '../../data/repositories/capture_repository.dart';
export '../../data/repositories/community_repository.dart';
export '../../data/repositories/recommendation_repository.dart';

final farmerProfileRepositoryProvider = Provider<FarmerProfileRepository>((ref) {
  return MockFarmerProfileRepository(seed: 42);
});

final yieldRepositoryProvider = Provider<YieldRepository>((ref) {
  return MockYieldRepository(seed: 42);
});

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return MockCommunityRepository(seed: 42);
});

final recommendationRepositoryProvider = Provider<RecommendationRepository>((ref) {
  return MockRecommendationRepository(seed: 42);
});
