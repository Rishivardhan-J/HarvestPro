// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['id'] as String,
  authorProfileId: json['authorProfileId'] as String,
  authorDisplayName: json['authorDisplayName'] as String,
  village: json['village'] as String,
  district: json['district'] as String,
  contentText: json['contentText'] as String,
  postType: $enumDecode(_$PostTypeEnumMap, json['postType']),
  reportCount: (json['reportCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'authorProfileId': instance.authorProfileId,
  'authorDisplayName': instance.authorDisplayName,
  'village': instance.village,
  'district': instance.district,
  'contentText': instance.contentText,
  'postType': _$PostTypeEnumMap[instance.postType]!,
  'reportCount': instance.reportCount,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$PostTypeEnumMap = {
  PostType.observation: 'observation',
  PostType.question: 'question',
  PostType.tip: 'tip',
};
