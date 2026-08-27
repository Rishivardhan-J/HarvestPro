// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_artifact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaptureArtifact {

 String get id; String get farmerProfileId; CaptureType get type; String? get localFilePath; String? get textContent; SyncStatus get syncStatus; int get retryCount; DateTime get createdAt;
/// Create a copy of CaptureArtifact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptureArtifactCopyWith<CaptureArtifact> get copyWith => _$CaptureArtifactCopyWithImpl<CaptureArtifact>(this as CaptureArtifact, _$identity);

  /// Serializes this CaptureArtifact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureArtifact&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.type, type) || other.type == type)&&(identical(other.localFilePath, localFilePath) || other.localFilePath == localFilePath)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,type,localFilePath,textContent,syncStatus,retryCount,createdAt);

@override
String toString() {
  return 'CaptureArtifact(id: $id, farmerProfileId: $farmerProfileId, type: $type, localFilePath: $localFilePath, textContent: $textContent, syncStatus: $syncStatus, retryCount: $retryCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CaptureArtifactCopyWith<$Res>  {
  factory $CaptureArtifactCopyWith(CaptureArtifact value, $Res Function(CaptureArtifact) _then) = _$CaptureArtifactCopyWithImpl;
@useResult
$Res call({
 String id, String farmerProfileId, CaptureType type, String? localFilePath, String? textContent, SyncStatus syncStatus, int retryCount, DateTime createdAt
});




}
/// @nodoc
class _$CaptureArtifactCopyWithImpl<$Res>
    implements $CaptureArtifactCopyWith<$Res> {
  _$CaptureArtifactCopyWithImpl(this._self, this._then);

  final CaptureArtifact _self;
  final $Res Function(CaptureArtifact) _then;

/// Create a copy of CaptureArtifact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? farmerProfileId = null,Object? type = null,Object? localFilePath = freezed,Object? textContent = freezed,Object? syncStatus = null,Object? retryCount = null,Object? createdAt = null,}) {
  return _then(CaptureArtifact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CaptureType,localFilePath: freezed == localFilePath ? _self.localFilePath : localFilePath // ignore: cast_nullable_to_non_nullable
as String?,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CaptureArtifact].
extension CaptureArtifactPatterns on CaptureArtifact {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptureArtifact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptureArtifact() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptureArtifact value)  $default,){
final _that = this;
switch (_that) {
case _CaptureArtifact():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptureArtifact value)?  $default,){
final _that = this;
switch (_that) {
case _CaptureArtifact() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  CaptureType type,  String? localFilePath,  String? textContent,  SyncStatus syncStatus,  int retryCount,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptureArtifact() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.type,_that.localFilePath,_that.textContent,_that.syncStatus,_that.retryCount,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  CaptureType type,  String? localFilePath,  String? textContent,  SyncStatus syncStatus,  int retryCount,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CaptureArtifact():
return $default(_that.id,_that.farmerProfileId,_that.type,_that.localFilePath,_that.textContent,_that.syncStatus,_that.retryCount,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String farmerProfileId,  CaptureType type,  String? localFilePath,  String? textContent,  SyncStatus syncStatus,  int retryCount,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CaptureArtifact() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.type,_that.localFilePath,_that.textContent,_that.syncStatus,_that.retryCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaptureArtifact implements CaptureArtifact {
  const _CaptureArtifact({required this.id, required this.farmerProfileId, required this.type, this.localFilePath, this.textContent, this.syncStatus = SyncStatus.pending, this.retryCount = 0, required this.createdAt});
  factory _CaptureArtifact.fromJson(Map<String, dynamic> json) => _$CaptureArtifactFromJson(json);

@override final  String id;
@override final  String farmerProfileId;
@override final  CaptureType type;
@override final  String? localFilePath;
@override final  String? textContent;
@override@JsonKey() final  SyncStatus syncStatus;
@override@JsonKey() final  int retryCount;
@override final  DateTime createdAt;

/// Create a copy of CaptureArtifact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptureArtifactCopyWith<_CaptureArtifact> get copyWith => __$CaptureArtifactCopyWithImpl<_CaptureArtifact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptureArtifactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptureArtifact&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.type, type) || other.type == type)&&(identical(other.localFilePath, localFilePath) || other.localFilePath == localFilePath)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,type,localFilePath,textContent,syncStatus,retryCount,createdAt);

@override
String toString() {
  return 'CaptureArtifact(id: $id, farmerProfileId: $farmerProfileId, type: $type, localFilePath: $localFilePath, textContent: $textContent, syncStatus: $syncStatus, retryCount: $retryCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CaptureArtifactCopyWith<$Res> implements $CaptureArtifactCopyWith<$Res> {
  factory _$CaptureArtifactCopyWith(_CaptureArtifact value, $Res Function(_CaptureArtifact) _then) = __$CaptureArtifactCopyWithImpl;
@override @useResult
$Res call({
 String id, String farmerProfileId, CaptureType type, String? localFilePath, String? textContent, SyncStatus syncStatus, int retryCount, DateTime createdAt
});




}
/// @nodoc
class __$CaptureArtifactCopyWithImpl<$Res>
    implements _$CaptureArtifactCopyWith<$Res> {
  __$CaptureArtifactCopyWithImpl(this._self, this._then);

  final _CaptureArtifact _self;
  final $Res Function(_CaptureArtifact) _then;

/// Create a copy of CaptureArtifact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? farmerProfileId = null,Object? type = null,Object? localFilePath = freezed,Object? textContent = freezed,Object? syncStatus = null,Object? retryCount = null,Object? createdAt = null,}) {
  return _then(_CaptureArtifact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CaptureType,localFilePath: freezed == localFilePath ? _self.localFilePath : localFilePath // ignore: cast_nullable_to_non_nullable
as String?,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
