import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/daily_checkin.dart';
import '../../../data/repositories/capture_repository.dart';

final todayCheckInProvider = FutureProvider.family<DailyCheckIn?, String>((ref, profileId) async {
  if (profileId.isEmpty) {
    return null;
  }
  final repo = ref.read(captureRepositoryProvider);
  return repo.getDailyCheckInForDate(profileId, DateTime.now());
});
