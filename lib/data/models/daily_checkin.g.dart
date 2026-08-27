// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_checkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyCheckIn _$DailyCheckInFromJson(Map<String, dynamic> json) =>
    _DailyCheckIn(
      id: json['id'] as String,
      farmerProfileId: json['farmerProfileId'] as String,
      date: DateTime.parse(json['date'] as String),
      mood: $enumDecode(_$CheckinMoodEnumMap, json['mood']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DailyCheckInToJson(_DailyCheckIn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmerProfileId': instance.farmerProfileId,
      'date': instance.date.toIso8601String(),
      'mood': _$CheckinMoodEnumMap[instance.mood]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$CheckinMoodEnumMap = {
  CheckinMood.happy: 'happy',
  CheckinMood.neutral: 'neutral',
  CheckinMood.sad: 'sad',
};
