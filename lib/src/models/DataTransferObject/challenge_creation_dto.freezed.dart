// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_creation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChallengeCreationDto _$ChallengeCreationDtoFromJson(Map<String, dynamic> json) {
  return _ChallengeCreationDto.fromJson(json);
}

/// @nodoc
mixin _$ChallengeCreationDto {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get periodicity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengeCreationDtoCopyWith<ChallengeCreationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCreationDtoCopyWith<$Res> {
  factory $ChallengeCreationDtoCopyWith(ChallengeCreationDto value,
          $Res Function(ChallengeCreationDto) then) =
      _$ChallengeCreationDtoCopyWithImpl<$Res, ChallengeCreationDto>;
  @useResult
  $Res call({String title, String? description, int? periodicity});
}

/// @nodoc
class _$ChallengeCreationDtoCopyWithImpl<$Res,
        $Val extends ChallengeCreationDto>
    implements $ChallengeCreationDtoCopyWith<$Res> {
  _$ChallengeCreationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? periodicity = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      periodicity: freezed == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeCreationDtoImplCopyWith<$Res>
    implements $ChallengeCreationDtoCopyWith<$Res> {
  factory _$$ChallengeCreationDtoImplCopyWith(_$ChallengeCreationDtoImpl value,
          $Res Function(_$ChallengeCreationDtoImpl) then) =
      __$$ChallengeCreationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? description, int? periodicity});
}

/// @nodoc
class __$$ChallengeCreationDtoImplCopyWithImpl<$Res>
    extends _$ChallengeCreationDtoCopyWithImpl<$Res, _$ChallengeCreationDtoImpl>
    implements _$$ChallengeCreationDtoImplCopyWith<$Res> {
  __$$ChallengeCreationDtoImplCopyWithImpl(_$ChallengeCreationDtoImpl _value,
      $Res Function(_$ChallengeCreationDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? periodicity = freezed,
  }) {
    return _then(_$ChallengeCreationDtoImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      periodicity: freezed == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeCreationDtoImpl
    with DiagnosticableTreeMixin
    implements _ChallengeCreationDto {
  _$ChallengeCreationDtoImpl(
      {required this.title, this.description, this.periodicity});

  factory _$ChallengeCreationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeCreationDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final int? periodicity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChallengeCreationDto(title: $title, description: $description, periodicity: $periodicity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChallengeCreationDto'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('periodicity', periodicity));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeCreationDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.periodicity, periodicity) ||
                other.periodicity == periodicity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, periodicity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeCreationDtoImplCopyWith<_$ChallengeCreationDtoImpl>
      get copyWith =>
          __$$ChallengeCreationDtoImplCopyWithImpl<_$ChallengeCreationDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeCreationDtoImplToJson(
      this,
    );
  }
}

abstract class _ChallengeCreationDto implements ChallengeCreationDto {
  factory _ChallengeCreationDto(
      {required final String title,
      final String? description,
      final int? periodicity}) = _$ChallengeCreationDtoImpl;

  factory _ChallengeCreationDto.fromJson(Map<String, dynamic> json) =
      _$ChallengeCreationDtoImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  int? get periodicity;
  @override
  @JsonKey(ignore: true)
  _$$ChallengeCreationDtoImplCopyWith<_$ChallengeCreationDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
