import 'package:freezed_annotation/freezed_annotation.dart';

part 'farmer_profile.freezed.dart';
part 'farmer_profile.g.dart';

enum DataSource { kisanIdVerified, manualEntry }

@freezed
abstract class FarmerProfile with _$FarmerProfile {
  const factory FarmerProfile({
    required String id,
    String? kisanId,
    required String name,
    required String village,
    required String district,
    required String state,
    required String primaryCrop,
    required double landSizeAcres,
    required String preferredLanguage,
    required DataSource dataSource,
    @Default(false) bool isActive,
    required DateTime createdAt,
  }) = _FarmerProfile;

  factory FarmerProfile.fromJson(Map<String, dynamic> json) => _$FarmerProfileFromJson(json);
}
