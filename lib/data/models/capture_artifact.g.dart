// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_artifact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaptureArtifact _$CaptureArtifactFromJson(Map<String, dynamic> json) =>
    _CaptureArtifact(
      id: json['id'] as String,
      farmerProfileId: json['farmerProfileId'] as String,
      type: $enumDecode(_$CaptureTypeEnumMap, json['type']),
      localFilePath: json['localFilePath'] as String?,
      textContent: json['textContent'] as String?,
      syncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
          SyncStatus.pending,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CaptureArtifactToJson(_CaptureArtifact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmerProfileId': instance.farmerProfileId,
      'type': _$CaptureTypeEnumMap[instance.type]!,
      'localFilePath': instance.localFilePath,
      'textContent': instance.textContent,
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'retryCount': instance.retryCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$CaptureTypeEnumMap = {
  CaptureType.photo: 'photo',
  CaptureType.voiceNote: 'voiceNote',
  CaptureType.textNote: 'textNote',
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.synced: 'synced',
  SyncStatus.failed: 'failed',
};
