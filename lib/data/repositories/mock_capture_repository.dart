import 'dart:convert';
import '../../core/storage/hive_box_manager.dart';
import '../models/capture_artifact.dart';
import '../models/daily_checkin.dart';
import 'capture_repository.dart';

class MockCaptureRepository implements CaptureRepository {
  static const String _artifactsBoxName = 'capture_artifacts';
  static const String _checkInsBoxName = 'daily_checkins';

  @override
  Future<void> init() async {
    // No-op for compatibility. HiveBoxManager handles initialization lazily on access.
  }

  @override
  Future<void> saveArtifact(CaptureArtifact artifact) async {
    try {
      final jsonStr = jsonEncode(artifact.toJson());
      final box = await HiveBoxManager().openBox(_artifactsBoxName);
      await box.put(artifact.id, jsonStr);
    } catch (e) {
      throw StorageException('Failed to save artifact', e);
    }
  }

  @override
  Future<List<CaptureArtifact>> getArtifactsForProfile(String profileId) async {
    try {
      final box = await HiveBoxManager().openBox(_artifactsBoxName);
      return box.values.map((jsonStr) {
        return CaptureArtifact.fromJson(jsonDecode(jsonStr));
      }).where((a) => a.farmerProfileId == profileId).toList();
    } catch (e) {
      throw StorageException('Failed to get artifacts', e);
    }
  }

  @override
  Future<void> saveDailyCheckIn(DailyCheckIn checkIn) async {
    try {
      final jsonStr = jsonEncode(checkIn.toJson());
      final box = await HiveBoxManager().openBox(_checkInsBoxName);
      await box.put(checkIn.id, jsonStr);
    } catch (e) {
      throw StorageException('Failed to save checkin', e);
    }
  }

  @override
  Future<DailyCheckIn?> getDailyCheckInForDate(String profileId, DateTime date) async {
    try {
      final box = await HiveBoxManager().openBox(_checkInsBoxName);
      for (final value in box.values) {
        final checkIn = DailyCheckIn.fromJson(jsonDecode(value));
        if (checkIn.farmerProfileId == profileId && 
            checkIn.date.year == date.year && 
            checkIn.date.month == date.month && 
            checkIn.date.day == date.day) {
          return checkIn;
        }
      }
      return null;
    } catch (e) {
      throw StorageException('Failed to get checkin', e);
    }
  }

  @override
  Future<List<DailyCheckIn>> getAllDailyCheckIns(String profileId) async {
    try {
      final box = await HiveBoxManager().openBox(_checkInsBoxName);
      final list = <DailyCheckIn>[];
      for (final value in box.values) {
        final checkIn = DailyCheckIn.fromJson(jsonDecode(value));
        if (checkIn.farmerProfileId == profileId) {
          list.add(checkIn);
        }
      }
      return list;
    } catch (e) {
      throw StorageException('Failed to get checkins', e);
    }
  }
}
