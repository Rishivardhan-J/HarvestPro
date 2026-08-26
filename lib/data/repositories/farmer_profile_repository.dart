import '../models/farmer_profile.dart';

abstract class FarmerProfileRepository {
  Future<FarmerProfile?> getProfile(String id);
  Future<List<FarmerProfile>> getAllProfiles();
  Future<FarmerProfile> createProfile(FarmerProfile profile);
  Future<void> deleteProfile(String id);
}
