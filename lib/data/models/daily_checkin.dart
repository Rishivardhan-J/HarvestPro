import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_checkin.freezed.dart';
part 'daily_checkin.g.dart';

enum CheckinMood { happy, neutral, sad }

@freezed
abstract class DailyCheckIn with _$DailyCheckIn {
  const factory DailyCheckIn({
    required String id,
    required String farmerProfileId,
    required DateTime date,
    required CheckinMood mood,
    required DateTime createdAt,
  }) = _DailyCheckIn;

  factory DailyCheckIn.fromJson(Map<String, dynamic> json) => _$DailyCheckInFromJson(json);
}
