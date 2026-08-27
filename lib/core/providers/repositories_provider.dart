import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/farmer_profile_repository.dart';
import '../../data/repositories/mock_farmer_profile_repository.dart';
import '../../data/repositories/mock_yield_repository.dart';
import '../../data/repositories/yield_repository.dart';

final farmerProfileRepositoryProvider = Provider<FarmerProfileRepository>((ref) {
  return MockFarmerProfileRepository(seed: 42);
});

final yieldRepositoryProvider = Provider<YieldRepository>((ref) {
  return MockYieldRepository(seed: 42);
});
