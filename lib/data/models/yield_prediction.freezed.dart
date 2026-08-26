// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yield_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YieldFactor {

 String get label; double get contributionValue; String get iconKey;
/// Create a copy of YieldFactor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YieldFactorCopyWith<YieldFactor> get copyWith => _$YieldFactorCopyWithImpl<YieldFactor>(this as YieldFactor, _$identity);

  /// Serializes this YieldFactor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YieldFactor&&(identical(other.label, label) || other.label == label)&&(identical(other.contributionValue, contributionValue) || other.contributionValue == contributionValue)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,contributionValue,iconKey);

@override
String toString() {
  return 'YieldFactor(label: $label, contributionValue: $contributionValue, iconKey: $iconKey)';
}


}

/// @nodoc
abstract mixin class $YieldFactorCopyWith<$Res>  {
  factory $YieldFactorCopyWith(YieldFactor value, $Res Function(YieldFactor) _then) = _$YieldFactorCopyWithImpl;
@useResult
$Res call({
 String label, double contributionValue, String iconKey
});




}
/// @nodoc
class _$YieldFactorCopyWithImpl<$Res>
    implements $YieldFactorCopyWith<$Res> {
  _$YieldFactorCopyWithImpl(this._self, this._then);

  final YieldFactor _self;
  final $Res Function(YieldFactor) _then;

/// Create a copy of YieldFactor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? contributionValue = null,Object? iconKey = null,}) {
  return _then(YieldFactor(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,contributionValue: null == contributionValue ? _self.contributionValue : contributionValue // ignore: cast_nullable_to_non_nullable
as double,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [YieldFactor].
extension YieldFactorPatterns on YieldFactor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YieldFactor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YieldFactor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YieldFactor value)  $default,){
final _that = this;
switch (_that) {
case _YieldFactor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YieldFactor value)?  $default,){
final _that = this;
switch (_that) {
case _YieldFactor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double contributionValue,  String iconKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YieldFactor() when $default != null:
return $default(_that.label,_that.contributionValue,_that.iconKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double contributionValue,  String iconKey)  $default,) {final _that = this;
switch (_that) {
case _YieldFactor():
return $default(_that.label,_that.contributionValue,_that.iconKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double contributionValue,  String iconKey)?  $default,) {final _that = this;
switch (_that) {
case _YieldFactor() when $default != null:
return $default(_that.label,_that.contributionValue,_that.iconKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YieldFactor implements YieldFactor {
  const _YieldFactor({required this.label, required this.contributionValue, required this.iconKey});
  factory _YieldFactor.fromJson(Map<String, dynamic> json) => _$YieldFactorFromJson(json);

@override final  String label;
@override final  double contributionValue;
@override final  String iconKey;

/// Create a copy of YieldFactor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YieldFactorCopyWith<_YieldFactor> get copyWith => __$YieldFactorCopyWithImpl<_YieldFactor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YieldFactorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YieldFactor&&(identical(other.label, label) || other.label == label)&&(identical(other.contributionValue, contributionValue) || other.contributionValue == contributionValue)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,contributionValue,iconKey);

@override
String toString() {
  return 'YieldFactor(label: $label, contributionValue: $contributionValue, iconKey: $iconKey)';
}


}

/// @nodoc
abstract mixin class _$YieldFactorCopyWith<$Res> implements $YieldFactorCopyWith<$Res> {
  factory _$YieldFactorCopyWith(_YieldFactor value, $Res Function(_YieldFactor) _then) = __$YieldFactorCopyWithImpl;
@override @useResult
$Res call({
 String label, double contributionValue, String iconKey
});




}
/// @nodoc
class __$YieldFactorCopyWithImpl<$Res>
    implements _$YieldFactorCopyWith<$Res> {
  __$YieldFactorCopyWithImpl(this._self, this._then);

  final _YieldFactor _self;
  final $Res Function(_YieldFactor) _then;

/// Create a copy of YieldFactor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? contributionValue = null,Object? iconKey = null,}) {
  return _then(_YieldFactor(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,contributionValue: null == contributionValue ? _self.contributionValue : contributionValue // ignore: cast_nullable_to_non_nullable
as double,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$YieldPrediction {

 String get id; String get farmerProfileId; double get predictedYieldPercent; List<YieldFactor> get factors; List<SourceBadge> get sourceBadges; DateTime get generatedAt;
/// Create a copy of YieldPrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YieldPredictionCopyWith<YieldPrediction> get copyWith => _$YieldPredictionCopyWithImpl<YieldPrediction>(this as YieldPrediction, _$identity);

  /// Serializes this YieldPrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YieldPrediction&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.predictedYieldPercent, predictedYieldPercent) || other.predictedYieldPercent == predictedYieldPercent)&&const DeepCollectionEquality().equals(other.factors, factors)&&const DeepCollectionEquality().equals(other.sourceBadges, sourceBadges)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,predictedYieldPercent,const DeepCollectionEquality().hash(factors),const DeepCollectionEquality().hash(sourceBadges),generatedAt);

@override
String toString() {
  return 'YieldPrediction(id: $id, farmerProfileId: $farmerProfileId, predictedYieldPercent: $predictedYieldPercent, factors: $factors, sourceBadges: $sourceBadges, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $YieldPredictionCopyWith<$Res>  {
  factory $YieldPredictionCopyWith(YieldPrediction value, $Res Function(YieldPrediction) _then) = _$YieldPredictionCopyWithImpl;
@useResult
$Res call({
 String id, String farmerProfileId, double predictedYieldPercent, List<YieldFactor> factors, List<SourceBadge> sourceBadges, DateTime generatedAt
});




}
/// @nodoc
class _$YieldPredictionCopyWithImpl<$Res>
    implements $YieldPredictionCopyWith<$Res> {
  _$YieldPredictionCopyWithImpl(this._self, this._then);

  final YieldPrediction _self;
  final $Res Function(YieldPrediction) _then;

/// Create a copy of YieldPrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? farmerProfileId = null,Object? predictedYieldPercent = null,Object? factors = null,Object? sourceBadges = null,Object? generatedAt = null,}) {
  return _then(YieldPrediction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,predictedYieldPercent: null == predictedYieldPercent ? _self.predictedYieldPercent : predictedYieldPercent // ignore: cast_nullable_to_non_nullable
as double,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as List<YieldFactor>,sourceBadges: null == sourceBadges ? _self.sourceBadges : sourceBadges // ignore: cast_nullable_to_non_nullable
as List<SourceBadge>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [YieldPrediction].
extension YieldPredictionPatterns on YieldPrediction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YieldPrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YieldPrediction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YieldPrediction value)  $default,){
final _that = this;
switch (_that) {
case _YieldPrediction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YieldPrediction value)?  $default,){
final _that = this;
switch (_that) {
case _YieldPrediction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  double predictedYieldPercent,  List<YieldFactor> factors,  List<SourceBadge> sourceBadges,  DateTime generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YieldPrediction() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.predictedYieldPercent,_that.factors,_that.sourceBadges,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String farmerProfileId,  double predictedYieldPercent,  List<YieldFactor> factors,  List<SourceBadge> sourceBadges,  DateTime generatedAt)  $default,) {final _that = this;
switch (_that) {
case _YieldPrediction():
return $default(_that.id,_that.farmerProfileId,_that.predictedYieldPercent,_that.factors,_that.sourceBadges,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String farmerProfileId,  double predictedYieldPercent,  List<YieldFactor> factors,  List<SourceBadge> sourceBadges,  DateTime generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _YieldPrediction() when $default != null:
return $default(_that.id,_that.farmerProfileId,_that.predictedYieldPercent,_that.factors,_that.sourceBadges,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YieldPrediction extends YieldPrediction {
  const _YieldPrediction({required this.id, required this.farmerProfileId, required this.predictedYieldPercent, required  List<YieldFactor> factors, required  List<SourceBadge> sourceBadges, required this.generatedAt}): _factors = factors,_sourceBadges = sourceBadges,super._();
  factory _YieldPrediction.fromJson(Map<String, dynamic> json) => _$YieldPredictionFromJson(json);

@override final  String id;
@override final  String farmerProfileId;
@override final  double predictedYieldPercent;
 final  List<YieldFactor> _factors;
@override List<YieldFactor> get factors {
  if (_factors is EqualUnmodifiableListView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_factors);
}

 final  List<SourceBadge> _sourceBadges;
@override List<SourceBadge> get sourceBadges {
  if (_sourceBadges is EqualUnmodifiableListView) return _sourceBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sourceBadges);
}

@override final  DateTime generatedAt;

/// Create a copy of YieldPrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YieldPredictionCopyWith<_YieldPrediction> get copyWith => __$YieldPredictionCopyWithImpl<_YieldPrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YieldPredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YieldPrediction&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerProfileId, farmerProfileId) || other.farmerProfileId == farmerProfileId)&&(identical(other.predictedYieldPercent, predictedYieldPercent) || other.predictedYieldPercent == predictedYieldPercent)&&const DeepCollectionEquality().equals(other._factors, _factors)&&const DeepCollectionEquality().equals(other._sourceBadges, _sourceBadges)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerProfileId,predictedYieldPercent,const DeepCollectionEquality().hash(_factors),const DeepCollectionEquality().hash(_sourceBadges),generatedAt);

@override
String toString() {
  return 'YieldPrediction(id: $id, farmerProfileId: $farmerProfileId, predictedYieldPercent: $predictedYieldPercent, factors: $factors, sourceBadges: $sourceBadges, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$YieldPredictionCopyWith<$Res> implements $YieldPredictionCopyWith<$Res> {
  factory _$YieldPredictionCopyWith(_YieldPrediction value, $Res Function(_YieldPrediction) _then) = __$YieldPredictionCopyWithImpl;
@override @useResult
$Res call({
 String id, String farmerProfileId, double predictedYieldPercent, List<YieldFactor> factors, List<SourceBadge> sourceBadges, DateTime generatedAt
});




}
/// @nodoc
class __$YieldPredictionCopyWithImpl<$Res>
    implements _$YieldPredictionCopyWith<$Res> {
  __$YieldPredictionCopyWithImpl(this._self, this._then);

  final _YieldPrediction _self;
  final $Res Function(_YieldPrediction) _then;

/// Create a copy of YieldPrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? farmerProfileId = null,Object? predictedYieldPercent = null,Object? factors = null,Object? sourceBadges = null,Object? generatedAt = null,}) {
  return _then(_YieldPrediction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,farmerProfileId: null == farmerProfileId ? _self.farmerProfileId : farmerProfileId // ignore: cast_nullable_to_non_nullable
as String,predictedYieldPercent: null == predictedYieldPercent ? _self.predictedYieldPercent : predictedYieldPercent // ignore: cast_nullable_to_non_nullable
as double,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as List<YieldFactor>,sourceBadges: null == sourceBadges ? _self._sourceBadges : sourceBadges // ignore: cast_nullable_to_non_nullable
as List<SourceBadge>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
