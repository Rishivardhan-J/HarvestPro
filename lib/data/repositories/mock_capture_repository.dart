import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/capture_artifact.dart';
import '../models/daily_checkin.dart';
import 'capture_repository.dart';

class MockCaptureRepository implements CaptureRepository {
  static const String _artifactsBoxName = 'capture_artifacts';
  static const String _checkInsBoxName = 'daily_checkins';

  Box<String>? _artifactsBox;
  Box<String>? _checkInsBox;

  @override
  Future<void> init() async {
    // In a real app we'd get the HiveAesCipher here if not opened globally.
    // For the mock, we assume the boxes are either already open or we just open them.
    if (!Hive.isBoxOpen(_artifactsBoxName)) {
      _artifactsBox = await Hive.openBox<String>(_artifactsBoxName);
    } else {
      _artifactsBox = Hive.box<String>(_artifactsBoxName);
    }

    if (!Hive.isBoxOpen(_checkInsBoxName)) {
      _checkInsBox = await Hive.openBox<String>(_checkInsBoxName);
    } else {
      _checkInsBox = Hive.box<String>(_checkInsBoxName);
    }
  }

  @override
  Future<void> saveArtifact(CaptureArtifact artifact) async {
    await init();
    // Assuming simple JSON encoding for the mock
    // Freezed generates fromJson / toJson but since we don't have part files generated yet we can't use .toJson() directly in this mock unless we assume it's generated.
    final jsonStr = jsonEncode(artifact.toJson());
    await _artifactsBox!.put(artifact.id, jsonStr);
  }

  @override
  Future<List<CaptureArtifact>> getArtifactsForProfile(String profileId) async {
    await init();
    return _artifactsBox!.values.map((jsonStr) {
      return CaptureArtifact.fromJson(jsonDecode(jsonStr));
    }).where((a) => a.farmerProfileId == profileId).toList();
  }

  @override
  Future<void> saveDailyCheckIn(DailyCheckIn checkIn) async {
    await init();
    final jsonStr = jsonEncode(checkIn.toJson());
    await _checkInsBox!.put(checkIn.id, jsonStr);
  }

  @override
  Future<DailyCheckIn?> getDailyCheckInForDate(String profileId, DateTime date) async {
    await init();
    for (final value in _checkInsBox!.values) {
      final checkIn = DailyCheckIn.fromJson(jsonDecode(value));
      if (checkIn.farmerProfileId == profileId && 
          checkIn.date.year == date.year && 
          checkIn.date.month == date.month && 
          checkIn.date.day == date.day) {
        return checkIn;
      }
    }
    return null;
  }
}
