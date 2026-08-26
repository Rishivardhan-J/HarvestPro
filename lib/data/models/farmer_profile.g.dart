// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FarmerProfile _$FarmerProfileFromJson(Map<String, dynamic> json) =>
    _FarmerProfile(
      id: json['id'] as String,
      kisanId: json['kisanId'] as String?,
      name: json['name'] as String,
      village: json['village'] as String,
      district: json['district'] as String,
      state: json['state'] as String,
      primaryCrop: json['primaryCrop'] as String,
      landSizeAcres: (json['landSizeAcres'] as num).toDouble(),
      preferredLanguage: json['preferredLanguage'] as String,
      dataSource: $enumDecode(_$DataSourceEnumMap, json['dataSource']),
      isActive: json['isActive'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FarmerProfileToJson(_FarmerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kisanId': instance.kisanId,
      'name': instance.name,
      'village': instance.village,
      'district': instance.district,
      'state': instance.state,
      'primaryCrop': instance.primaryCrop,
      'landSizeAcres': instance.landSizeAcres,
      'preferredLanguage': instance.preferredLanguage,
      'dataSource': _$DataSourceEnumMap[instance.dataSource]!,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$DataSourceEnumMap = {
  DataSource.kisanIdVerified: 'kisanIdVerified',
  DataSource.manualEntry: 'manualEntry',
};
