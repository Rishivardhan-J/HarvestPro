import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/farmer_profile.dart';
import 'farmer_profile_repository.dart';

class MockFarmerProfileRepository implements FarmerProfileRepository {
  final double failureRate;
  final Random _random;

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
    final box = Hive.box('profiles');
    return box.values.map((e) => FarmerProfile.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  @override
  Future<FarmerProfile?> getProfile(String id) async {
    await _simulateLatencyAndFailure();
    final box = Hive.box('profiles');
    final data = box.get(id);
    if (data == null) {
      return null;
    }
    return FarmerProfile.fromJson(Map<String, dynamic>.from(data as Map));
  }

  @override
  Future<FarmerProfile?> getProfileByKisanId(String kisanId) async {
    await _simulateLatencyAndFailure();
    // In a real scenario, this would query the backend AgriStack API.
    // For our mock, we just return a fake profile if it simulates success.
    // We already throw an exception in _simulateLatencyAndFailure if it simulates failure.
    return FarmerProfile(
      id: 'mock_agristack_${kisanId.substring(0, 4)}',
      kisanId: kisanId,
      name: 'Anand Kumar',
      village: 'Karur Village',
      district: 'Karur',
      state: 'Tamil Nadu',
      primaryCrop: 'Paddy',
      landSizeAcres: 2.5,
      preferredLanguage: 'ta',
      dataSource: DataSource.kisanIdVerified,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<FarmerProfile> createProfile(FarmerProfile profile) async {
    await _simulateLatencyAndFailure();
    final box = Hive.box('profiles');
    await box.put(profile.id, profile.toJson());
    return profile;
  }

  @override
  Future<void> deleteProfile(String id) async {
    await _simulateLatencyAndFailure();
    
    // Delete the profile
    final profilesBox = Hive.box('profiles');
    await profilesBox.delete(id);
    
    // Delete tied data (Isolation requirement)
    final yieldBox = Hive.box('yield_predictions');
    final keysToDeleteYield = yieldBox.keys.where((k) {
      final data = yieldBox.get(k) as Map;
      return data['farmerProfileId'] == id;
    }).toList();
    await yieldBox.deleteAll(keysToDeleteYield);
    
    final recBox = Hive.box('recommendations');
    final keysToDeleteRec = recBox.keys.where((k) {
      final data = recBox.get(k) as Map;
      return data['farmerProfileId'] == id;
    }).toList();
    await recBox.deleteAll(keysToDeleteRec);
  }
}
