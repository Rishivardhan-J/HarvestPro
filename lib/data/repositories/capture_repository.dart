import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/capture_artifact.dart';
import '../models/daily_checkin.dart';
import 'mock_capture_repository.dart';

abstract class CaptureRepository {
  Future<void> init();
  Future<void> saveArtifact(CaptureArtifact artifact);
  Future<List<CaptureArtifact>> getArtifactsForProfile(String profileId);
  Future<void> saveDailyCheckIn(DailyCheckIn checkIn);
  Future<DailyCheckIn?> getDailyCheckInForDate(String profileId, DateTime date);
}

final captureRepositoryProvider = Provider<CaptureRepository>((ref) {
  return MockCaptureRepository();
});
