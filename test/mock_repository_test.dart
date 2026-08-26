import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/data/repositories/mock_farmer_profile_repository.dart';

void main() {
  group('MockFarmerProfileRepository', () {
    test('Simulates failure based on rate', () async {
      final repo = MockFarmerProfileRepository(failureRate: 1.0, seed: 1); // 100% failure
      expect(() => repo.getAllProfiles(), throwsException);
    });

    test('Succeeds when failure rate is 0', () async {
      final repo = MockFarmerProfileRepository(seed: 1); // 0% failure
      final profiles = await repo.getAllProfiles();
      expect(profiles, isEmpty);
    });
  });
}
