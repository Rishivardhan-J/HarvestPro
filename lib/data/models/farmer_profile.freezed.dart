// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'farmer_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FarmerProfile {

 String get id; String? get kisanId; String get name; String get village; String get district; String get state; String get primaryCrop; double get landSizeAcres; String get preferredLanguage; DataSource get dataSource; bool get isActive; DateTime get createdAt;
/// Create a copy of FarmerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FarmerProfileCopyWith<FarmerProfile> get copyWith => _$FarmerProfileCopyWithImpl<FarmerProfile>(this as FarmerProfile, _$identity);

  /// Serializes this FarmerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FarmerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.kisanId, kisanId) || other.kisanId == kisanId)&&(identical(other.name, name) || other.name == name)&&(identical(other.village, village) || other.village == village)&&(identical(other.district, district) || other.district == district)&&(identical(other.state, state) || other.state == state)&&(identical(other.primaryCrop, primaryCrop) || other.primaryCrop == primaryCrop)&&(identical(other.landSizeAcres, landSizeAcres) || other.landSizeAcres == landSizeAcres)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kisanId,name,village,district,state,primaryCrop,landSizeAcres,preferredLanguage,dataSource,isActive,createdAt);

@override
String toString() {
  return 'FarmerProfile(id: $id, kisanId: $kisanId, name: $name, village: $village, district: $district, state: $state, primaryCrop: $primaryCrop, landSizeAcres: $landSizeAcres, preferredLanguage: $preferredLanguage, dataSource: $dataSource, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FarmerProfileCopyWith<$Res>  {
  factory $FarmerProfileCopyWith(FarmerProfile value, $Res Function(FarmerProfile) _then) = _$FarmerProfileCopyWithImpl;
@useResult
$Res call({
 String id, String? kisanId, String name, String village, String district, String state, String primaryCrop, double landSizeAcres, String preferredLanguage, DataSource dataSource, bool isActive, DateTime createdAt
});




}
/// @nodoc
class _$FarmerProfileCopyWithImpl<$Res>
    implements $FarmerProfileCopyWith<$Res> {
  _$FarmerProfileCopyWithImpl(this._self, this._then);

  final FarmerProfile _self;
  final $Res Function(FarmerProfile) _then;

/// Create a copy of FarmerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kisanId = freezed,Object? name = null,Object? village = null,Object? district = null,Object? state = null,Object? primaryCrop = null,Object? landSizeAcres = null,Object? preferredLanguage = null,Object? dataSource = null,Object? isActive = null,Object? createdAt = null,}) {
  return _then(FarmerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kisanId: freezed == kisanId ? _self.kisanId : kisanId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,village: null == village ? _self.village : village // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,primaryCrop: null == primaryCrop ? _self.primaryCrop : primaryCrop // ignore: cast_nullable_to_non_nullable
as String,landSizeAcres: null == landSizeAcres ? _self.landSizeAcres : landSizeAcres // ignore: cast_nullable_to_non_nullable
as double,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,dataSource: null == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as DataSource,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FarmerProfile].
extension FarmerProfilePatterns on FarmerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FarmerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FarmerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FarmerProfile value)  $default,){
final _that = this;
switch (_that) {
case _FarmerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FarmerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _FarmerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? kisanId,  String name,  String village,  String district,  String state,  String primaryCrop,  double landSizeAcres,  String preferredLanguage,  DataSource dataSource,  bool isActive,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FarmerProfile() when $default != null:
return $default(_that.id,_that.kisanId,_that.name,_that.village,_that.district,_that.state,_that.primaryCrop,_that.landSizeAcres,_that.preferredLanguage,_that.dataSource,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? kisanId,  String name,  String village,  String district,  String state,  String primaryCrop,  double landSizeAcres,  String preferredLanguage,  DataSource dataSource,  bool isActive,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _FarmerProfile():
return $default(_that.id,_that.kisanId,_that.name,_that.village,_that.district,_that.state,_that.primaryCrop,_that.landSizeAcres,_that.preferredLanguage,_that.dataSource,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? kisanId,  String name,  String village,  String district,  String state,  String primaryCrop,  double landSizeAcres,  String preferredLanguage,  DataSource dataSource,  bool isActive,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FarmerProfile() when $default != null:
return $default(_that.id,_that.kisanId,_that.name,_that.village,_that.district,_that.state,_that.primaryCrop,_that.landSizeAcres,_that.preferredLanguage,_that.dataSource,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FarmerProfile implements FarmerProfile {
  const _FarmerProfile({required this.id, this.kisanId, required this.name, required this.village, required this.district, required this.state, required this.primaryCrop, required this.landSizeAcres, required this.preferredLanguage, required this.dataSource, this.isActive = false, required this.createdAt});
  factory _FarmerProfile.fromJson(Map<String, dynamic> json) => _$FarmerProfileFromJson(json);

@override final  String id;
@override final  String? kisanId;
@override final  String name;
@override final  String village;
@override final  String district;
@override final  String state;
@override final  String primaryCrop;
@override final  double landSizeAcres;
@override final  String preferredLanguage;
@override final  DataSource dataSource;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;

/// Create a copy of FarmerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FarmerProfileCopyWith<_FarmerProfile> get copyWith => __$FarmerProfileCopyWithImpl<_FarmerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FarmerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FarmerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.kisanId, kisanId) || other.kisanId == kisanId)&&(identical(other.name, name) || other.name == name)&&(identical(other.village, village) || other.village == village)&&(identical(other.district, district) || other.district == district)&&(identical(other.state, state) || other.state == state)&&(identical(other.primaryCrop, primaryCrop) || other.primaryCrop == primaryCrop)&&(identical(other.landSizeAcres, landSizeAcres) || other.landSizeAcres == landSizeAcres)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kisanId,name,village,district,state,primaryCrop,landSizeAcres,preferredLanguage,dataSource,isActive,createdAt);

@override
String toString() {
  return 'FarmerProfile(id: $id, kisanId: $kisanId, name: $name, village: $village, district: $district, state: $state, primaryCrop: $primaryCrop, landSizeAcres: $landSizeAcres, preferredLanguage: $preferredLanguage, dataSource: $dataSource, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FarmerProfileCopyWith<$Res> implements $FarmerProfileCopyWith<$Res> {
  factory _$FarmerProfileCopyWith(_FarmerProfile value, $Res Function(_FarmerProfile) _then) = __$FarmerProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String? kisanId, String name, String village, String district, String state, String primaryCrop, double landSizeAcres, String preferredLanguage, DataSource dataSource, bool isActive, DateTime createdAt
});




}
/// @nodoc
class __$FarmerProfileCopyWithImpl<$Res>
    implements _$FarmerProfileCopyWith<$Res> {
  __$FarmerProfileCopyWithImpl(this._self, this._then);

  final _FarmerProfile _self;
  final $Res Function(_FarmerProfile) _then;

/// Create a copy of FarmerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kisanId = freezed,Object? name = null,Object? village = null,Object? district = null,Object? state = null,Object? primaryCrop = null,Object? landSizeAcres = null,Object? preferredLanguage = null,Object? dataSource = null,Object? isActive = null,Object? createdAt = null,}) {
  return _then(_FarmerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kisanId: freezed == kisanId ? _self.kisanId : kisanId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,village: null == village ? _self.village : village // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,primaryCrop: null == primaryCrop ? _self.primaryCrop : primaryCrop // ignore: cast_nullable_to_non_nullable
as String,landSizeAcres: null == landSizeAcres ? _self.landSizeAcres : landSizeAcres // ignore: cast_nullable_to_non_nullable
as double,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,dataSource: null == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as DataSource,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
