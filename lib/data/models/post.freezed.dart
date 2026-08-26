// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {

 String get id; String get authorProfileId; String get authorDisplayName; String get village; String get district; String get contentText; PostType get postType; int get reportCount; DateTime get createdAt;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.authorProfileId, authorProfileId) || other.authorProfileId == authorProfileId)&&(identical(other.authorDisplayName, authorDisplayName) || other.authorDisplayName == authorDisplayName)&&(identical(other.village, village) || other.village == village)&&(identical(other.district, district) || other.district == district)&&(identical(other.contentText, contentText) || other.contentText == contentText)&&(identical(other.postType, postType) || other.postType == postType)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorProfileId,authorDisplayName,village,district,contentText,postType,reportCount,createdAt);

@override
String toString() {
  return 'Post(id: $id, authorProfileId: $authorProfileId, authorDisplayName: $authorDisplayName, village: $village, district: $district, contentText: $contentText, postType: $postType, reportCount: $reportCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String id, String authorProfileId, String authorDisplayName, String village, String district, String contentText, PostType postType, int reportCount, DateTime createdAt
});




}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorProfileId = null,Object? authorDisplayName = null,Object? village = null,Object? district = null,Object? contentText = null,Object? postType = null,Object? reportCount = null,Object? createdAt = null,}) {
  return _then(Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorProfileId: null == authorProfileId ? _self.authorProfileId : authorProfileId // ignore: cast_nullable_to_non_nullable
as String,authorDisplayName: null == authorDisplayName ? _self.authorDisplayName : authorDisplayName // ignore: cast_nullable_to_non_nullable
as String,village: null == village ? _self.village : village // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,contentText: null == contentText ? _self.contentText : contentText // ignore: cast_nullable_to_non_nullable
as String,postType: null == postType ? _self.postType : postType // ignore: cast_nullable_to_non_nullable
as PostType,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorProfileId,  String authorDisplayName,  String village,  String district,  String contentText,  PostType postType,  int reportCount,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.authorProfileId,_that.authorDisplayName,_that.village,_that.district,_that.contentText,_that.postType,_that.reportCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorProfileId,  String authorDisplayName,  String village,  String district,  String contentText,  PostType postType,  int reportCount,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.authorProfileId,_that.authorDisplayName,_that.village,_that.district,_that.contentText,_that.postType,_that.reportCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorProfileId,  String authorDisplayName,  String village,  String district,  String contentText,  PostType postType,  int reportCount,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.authorProfileId,_that.authorDisplayName,_that.village,_that.district,_that.contentText,_that.postType,_that.reportCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post extends Post {
  const _Post({required this.id, required this.authorProfileId, required this.authorDisplayName, required this.village, required this.district, required this.contentText, required this.postType, required this.reportCount, required this.createdAt}): super._();
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  String id;
@override final  String authorProfileId;
@override final  String authorDisplayName;
@override final  String village;
@override final  String district;
@override final  String contentText;
@override final  PostType postType;
@override final  int reportCount;
@override final  DateTime createdAt;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.authorProfileId, authorProfileId) || other.authorProfileId == authorProfileId)&&(identical(other.authorDisplayName, authorDisplayName) || other.authorDisplayName == authorDisplayName)&&(identical(other.village, village) || other.village == village)&&(identical(other.district, district) || other.district == district)&&(identical(other.contentText, contentText) || other.contentText == contentText)&&(identical(other.postType, postType) || other.postType == postType)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorProfileId,authorDisplayName,village,district,contentText,postType,reportCount,createdAt);

@override
String toString() {
  return 'Post(id: $id, authorProfileId: $authorProfileId, authorDisplayName: $authorDisplayName, village: $village, district: $district, contentText: $contentText, postType: $postType, reportCount: $reportCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorProfileId, String authorDisplayName, String village, String district, String contentText, PostType postType, int reportCount, DateTime createdAt
});




}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorProfileId = null,Object? authorDisplayName = null,Object? village = null,Object? district = null,Object? contentText = null,Object? postType = null,Object? reportCount = null,Object? createdAt = null,}) {
  return _then(_Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorProfileId: null == authorProfileId ? _self.authorProfileId : authorProfileId // ignore: cast_nullable_to_non_nullable
as String,authorDisplayName: null == authorDisplayName ? _self.authorDisplayName : authorDisplayName // ignore: cast_nullable_to_non_nullable
as String,village: null == village ? _self.village : village // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,contentText: null == contentText ? _self.contentText : contentText // ignore: cast_nullable_to_non_nullable
as String,postType: null == postType ? _self.postType : postType // ignore: cast_nullable_to_non_nullable
as PostType,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
