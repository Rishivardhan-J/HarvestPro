import 'dart:math';
import '../models/farmer_profile.dart';
import 'farmer_profile_repository.dart';

class MockFarmerProfileRepository implements FarmerProfileRepository {
  final double failureRate;
  final Random _random;
  final List<FarmerProfile> _profiles = [];

  MockFarmerProfileRepository({this.failureRate = 0.0, int? seed}) 
      : _random = Random(seed);

  Future<void> _simulateLatencyAndFailure() async {
    final delay = 300 + _random.nextInt(600);
    await Future.delayed(Duration(milliseconds: delay));
    if (_random.nextDouble() < failureRate) {
      throw Exception('Simulated network failure in MockFarmerProfileRepository');
    }
  }

  @override
  Future<List<FarmerProfile>> getAllProfiles() async {
    await _simulateLatencyAndFailure();
    return List.unmodifiable(_profiles);
  }

  @override
  Future<FarmerProfile?> getProfile(String id) async {
    await _simulateLatencyAndFailure();
    try {
      return _profiles.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<FarmerProfile> createProfile(FarmerProfile profile) async {
    await _simulateLatencyAndFailure();
    _profiles.add(profile);
    return profile;
  }

  @override
  Future<void> deleteProfile(String id) async {
    await _simulateLatencyAndFailure();
    _profiles.removeWhere((p) => p.id == id);
  }
}
