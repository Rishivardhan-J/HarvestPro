// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Recommendation {

 String get id; String get farmerProfileId; String get titleKey; String get descriptionKey; double get estimatedValueRupees; EstimatedValueUnit get estimatedValueUnit; RecommendationCategory get category; RecommendationStatus get status; String get iconKey; DateTime get createdAt;
/// Create a copy of Recommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendationCopyWith<Recommendation> get copyWith => _$RecommendationCopyWithImpl<Recommendation>(this as Recommendation, _$identity);

  /// Serializes this Recommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recommendation&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.estimatedValueRupees, estimatedValueRupees) || other.estimatedValueRupees == estimatedValueRupees)&&(identical(other.estimatedValueUnit, estimatedValueUnit) || other.estimatedValueUnit == estimatedValueUnit)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,titleKey,descriptionKey,estimatedValueRupees,estimatedValueUnit,category,status,iconKey,createdAt);

@override
String toString() {
  return 'Recommendation(id: $id, farmerProfileId: $farmerProfileId, titleKey: $titleKey, descriptionKey: $descriptionKey, estimatedValueRupees: $estimatedValueRupees, estimatedValueUnit: $estimatedValueUnit, category: $category, status: $status, iconKey: $iconKey, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RecommendationCopyWith<$Res>  {
  factory $RecommendationCopyWith(Recommendation value, $Res Function(Recommendation) _then) = _$RecommendationCopyWithImpl;
@useResult
$Res call({
 String id, String farmerProfileId, String titleKey, String descriptionKey, double estimatedValueRupees, EstimatedValueUnit estimatedValueUnit, RecommendationCategory category, RecommendationStatus status, String iconKey, DateTime createdAt
});




}
/// @nodoc
class _$RecommendationCopyWithImpl<$Res>
    implements $RecommendationCopyWith<$Res> {
  _$RecommendationCopyWithImpl(this._self, this._then);

  final Recommendation _self;
  final $Res Function(Recommendation) _then;

/// Create a copy of Recommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? farmerProfileId = null,Object? titleKey = null,Object? descriptionKey = null,Object? estimatedValueRupees = null,Object? estimatedValueUnit = null,Object? category = null,Object? status = null,Object? iconKey = null,Object? createdAt = null,}) {
  return _then(Recommendation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,estimatedValueRupees: null == estimatedValueRupees ? _self.estimatedValueRupees : estimatedValueRupees // ignore: cast_nullable_to_non_nullable
as double,estimatedValueUnit: null == estimatedValueUnit ? _self.estimatedValueUnit : estimatedValueUnit // ignore: cast_nullable_to_non_nullable
as EstimatedValueUnit,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RecommendationCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecommendationStatus,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Recommendation].
extension RecommendationPatterns on Recommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Recommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Recommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Recommendation value)  $default,){
final _that = this;
switch (_that) {
case _Recommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Recommendation value)?  $default,){
final _that = this;
switch (_that) {
case _Recommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  String titleKey,  String descriptionKey,  double estimatedValueRupees,  EstimatedValueUnit estimatedValueUnit,  RecommendationCategory category,  RecommendationStatus status,  String iconKey,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Recommendation() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.titleKey,_that.descriptionKey,_that.estimatedValueRupees,_that.estimatedValueUnit,_that.category,_that.status,_that.iconKey,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  String titleKey,  String descriptionKey,  double estimatedValueRupees,  EstimatedValueUnit estimatedValueUnit,  RecommendationCategory category,  RecommendationStatus status,  String iconKey,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Recommendation():
return $default(_that.id,_that.farmerProfileId,_that.titleKey,_that.descriptionKey,_that.estimatedValueRupees,_that.estimatedValueUnit,_that.category,_that.status,_that.iconKey,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String farmerProfileId,  String titleKey,  String descriptionKey,  double estimatedValueRupees,  EstimatedValueUnit estimatedValueUnit,  RecommendationCategory category,  RecommendationStatus status,  String iconKey,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Recommendation() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.titleKey,_that.descriptionKey,_that.estimatedValueRupees,_that.estimatedValueUnit,_that.category,_that.status,_that.iconKey,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Recommendation implements Recommendation {
  const _Recommendation({required this.id, required this.farmerProfileId, required this.titleKey, required this.descriptionKey, required this.estimatedValueRupees, required this.estimatedValueUnit, required this.category, required this.status, required this.iconKey, required this.createdAt});
  factory _Recommendation.fromJson(Map<String, dynamic> json) => _$RecommendationFromJson(json);

@override final  String id;
@override final  String farmerProfileId;
@override final  String titleKey;
@override final  String descriptionKey;
@override final  double estimatedValueRupees;
@override final  EstimatedValueUnit estimatedValueUnit;
@override final  RecommendationCategory category;
@override final  RecommendationStatus status;
@override final  String iconKey;
@override final  DateTime createdAt;

/// Create a copy of Recommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendationCopyWith<_Recommendation> get copyWith => __$RecommendationCopyWithImpl<_Recommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recommendation&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.estimatedValueRupees, estimatedValueRupees) || other.estimatedValueRupees == estimatedValueRupees)&&(identical(other.estimatedValueUnit, estimatedValueUnit) || other.estimatedValueUnit == estimatedValueUnit)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,titleKey,descriptionKey,estimatedValueRupees,estimatedValueUnit,category,status,iconKey,createdAt);

@override
String toString() {
  return 'Recommendation(id: $id, farmerProfileId: $farmerProfileId, titleKey: $titleKey, descriptionKey: $descriptionKey, estimatedValueRupees: $estimatedValueRupees, estimatedValueUnit: $estimatedValueUnit, category: $category, status: $status, iconKey: $iconKey, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RecommendationCopyWith<$Res> implements $RecommendationCopyWith<$Res> {
  factory _$RecommendationCopyWith(_Recommendation value, $Res Function(_Recommendation) _then) = __$RecommendationCopyWithImpl;
@override @useResult
$Res call({
 String id, String farmerProfileId, String titleKey, String descriptionKey, double estimatedValueRupees, EstimatedValueUnit estimatedValueUnit, RecommendationCategory category, RecommendationStatus status, String iconKey, DateTime createdAt
});




}
/// @nodoc
class __$RecommendationCopyWithImpl<$Res>
    implements _$RecommendationCopyWith<$Res> {
  __$RecommendationCopyWithImpl(this._self, this._then);

  final _Recommendation _self;
  final $Res Function(_Recommendation) _then;

/// Create a copy of Recommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? farmerProfileId = null,Object? titleKey = null,Object? descriptionKey = null,Object? estimatedValueRupees = null,Object? estimatedValueUnit = null,Object? category = null,Object? status = null,Object? iconKey = null,Object? createdAt = null,}) {
  return _then(_Recommendation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,estimatedValueRupees: null == estimatedValueRupees ? _self.estimatedValueRupees : estimatedValueRupees // ignore: cast_nullable_to_non_nullable
as double,estimatedValueUnit: null == estimatedValueUnit ? _self.estimatedValueUnit : estimatedValueUnit // ignore: cast_nullable_to_non_nullable
as EstimatedValueUnit,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RecommendationCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecommendationStatus,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
