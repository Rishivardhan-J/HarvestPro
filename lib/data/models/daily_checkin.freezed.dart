// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_checkin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyCheckIn {

 String get id; String get farmerProfileId; DateTime get date; CheckinMood get mood; DateTime get createdAt;
/// Create a copy of DailyCheckIn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyCheckInCopyWith<DailyCheckIn> get copyWith => _$DailyCheckInCopyWithImpl<DailyCheckIn>(this as DailyCheckIn, _$identity);

  /// Serializes this DailyCheckIn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyCheckIn&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.date, date) || other.date == date)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,date,mood,createdAt);

@override
String toString() {
  return 'DailyCheckIn(id: $id, farmerProfileId: $farmerProfileId, date: $date, mood: $mood, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DailyCheckInCopyWith<$Res>  {
  factory $DailyCheckInCopyWith(DailyCheckIn value, $Res Function(DailyCheckIn) _then) = _$DailyCheckInCopyWithImpl;
@useResult
$Res call({
 String id, String farmerProfileId, DateTime date, CheckinMood mood, DateTime createdAt
});




}
/// @nodoc
class _$DailyCheckInCopyWithImpl<$Res>
    implements $DailyCheckInCopyWith<$Res> {
  _$DailyCheckInCopyWithImpl(this._self, this._then);

  final DailyCheckIn _self;
  final $Res Function(DailyCheckIn) _then;

/// Create a copy of DailyCheckIn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? farmerProfileId = null,Object? date = null,Object? mood = null,Object? createdAt = null,}) {
  return _then(DailyCheckIn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as CheckinMood,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyCheckIn].
extension DailyCheckInPatterns on DailyCheckIn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyCheckIn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyCheckIn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyCheckIn value)  $default,){
final _that = this;
switch (_that) {
case _DailyCheckIn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyCheckIn value)?  $default,){
final _that = this;
switch (_that) {
case _DailyCheckIn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  DateTime date,  CheckinMood mood,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyCheckIn() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.date,_that.mood,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  DateTime date,  CheckinMood mood,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DailyCheckIn():
return $default(_that.id,_that.farmerProfileId,_that.date,_that.mood,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String farmerProfileId,  DateTime date,  CheckinMood mood,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DailyCheckIn() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.date,_that.mood,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyCheckIn implements DailyCheckIn {
  const _DailyCheckIn({required this.id, required this.farmerProfileId, required this.date, required this.mood, required this.createdAt});
  factory _DailyCheckIn.fromJson(Map<String, dynamic> json) => _$DailyCheckInFromJson(json);

@override final  String id;
@override final  String farmerProfileId;
@override final  DateTime date;
@override final  CheckinMood mood;
@override final  DateTime createdAt;

/// Create a copy of DailyCheckIn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyCheckInCopyWith<_DailyCheckIn> get copyWith => __$DailyCheckInCopyWithImpl<_DailyCheckIn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyCheckInToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyCheckIn&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.date, date) || other.date == date)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,date,mood,createdAt);

@override
String toString() {
  return 'DailyCheckIn(id: $id, farmerProfileId: $farmerProfileId, date: $date, mood: $mood, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DailyCheckInCopyWith<$Res> implements $DailyCheckInCopyWith<$Res> {
  factory _$DailyCheckInCopyWith(_DailyCheckIn value, $Res Function(_DailyCheckIn) _then) = __$DailyCheckInCopyWithImpl;
@override @useResult
$Res call({
 String id, String farmerProfileId, DateTime date, CheckinMood mood, DateTime createdAt
});




}
/// @nodoc
class __$DailyCheckInCopyWithImpl<$Res>
    implements _$DailyCheckInCopyWith<$Res> {
  __$DailyCheckInCopyWithImpl(this._self, this._then);

  final _DailyCheckIn _self;
  final $Res Function(_DailyCheckIn) _then;

/// Create a copy of DailyCheckIn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? farmerProfileId = null,Object? date = null,Object? mood = null,Object? createdAt = null,}) {
  return _then(_DailyCheckIn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as CheckinMood,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
