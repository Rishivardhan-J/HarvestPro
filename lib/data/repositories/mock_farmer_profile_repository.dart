import 'dart:convert';
import 'dart:math';
import '../../core/storage/hive_box_manager.dart';
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
      throw StorageException('Simulated network failure in MockFarmerProfileRepository');
    }
  }

  @override
  Future<List<FarmerProfile>> getAllProfiles() async {
    await _simulateLatencyAndFailure();
    try {
      final box = await HiveBoxManager().openBox('profiles');
      return box.values.map((e) => FarmerProfile.fromJson(jsonDecode(e))).toList();
    } catch (e) {
      throw StorageException('Failed to get profiles', e);
    }
  }

  @override
  Future<FarmerProfile?> getProfile(String id) async {
    await _simulateLatencyAndFailure();
    try {
      final box = await HiveBoxManager().openBox('profiles');
      final data = box.get(id);
      if (data == null) {
        return null;
      }
      return FarmerProfile.fromJson(jsonDecode(data));
    } catch (e) {
      throw StorageException('Failed to get profile $id', e);
    }
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
    try {
      final box = await HiveBoxManager().openBox('profiles');
      await box.put(profile.id, jsonEncode(profile.toJson()));
      return profile;
    } catch (e) {
      throw StorageException('Failed to create profile', e);
    }
  }

  @override
  Future<void> deleteProfile(String id) async {
    await _simulateLatencyAndFailure();
    try {
      // Delete the profile
      final profilesBox = await HiveBoxManager().openBox('profiles');
      await profilesBox.delete(id);
      
      // Delete tied data (Isolation requirement)
      final yieldBox = await HiveBoxManager().openBox('yield_predictions');
      final keysToDeleteYield = yieldBox.keys.where((k) {
        final strData = yieldBox.get(k);
        if (strData == null) {
          return false;
        }
        final data = jsonDecode(strData);
        return data['farmerProfileId'] == id;
      }).toList();
      await yieldBox.deleteAll(keysToDeleteYield);
      
      final recBox = await HiveBoxManager().openBox('recommendations');
      final keysToDeleteRec = recBox.keys.where((k) {
        final strData = recBox.get(k);
        if (strData == null) {
          return false;
        }
        final data = jsonDecode(strData);
        return data['farmerProfileId'] == id;
      }).toList();
      await recBox.deleteAll(keysToDeleteRec);
    } catch (e) {
      throw StorageException('Failed to delete profile $id and its tied data', e);
    }
  }
}
