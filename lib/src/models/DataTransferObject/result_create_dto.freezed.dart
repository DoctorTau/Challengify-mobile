// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_create_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResultCreateRequestDto _$ResultCreateRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _ResultCreateRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ResultCreateRequestDto {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get mediaPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultCreateRequestDtoCopyWith<ResultCreateRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCreateRequestDtoCopyWith<$Res> {
  factory $ResultCreateRequestDtoCopyWith(ResultCreateRequestDto value,
          $Res Function(ResultCreateRequestDto) then) =
      _$ResultCreateRequestDtoCopyWithImpl<$Res, ResultCreateRequestDto>;
  @useResult
  $Res call({String name, String description, String mediaPath});
}

/// @nodoc
class _$ResultCreateRequestDtoCopyWithImpl<$Res,
        $Val extends ResultCreateRequestDto>
    implements $ResultCreateRequestDtoCopyWith<$Res> {
  _$ResultCreateRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? mediaPath = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      mediaPath: null == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultCreateRequestDtoImplCopyWith<$Res>
    implements $ResultCreateRequestDtoCopyWith<$Res> {
  factory _$$ResultCreateRequestDtoImplCopyWith(
          _$ResultCreateRequestDtoImpl value,
          $Res Function(_$ResultCreateRequestDtoImpl) then) =
      __$$ResultCreateRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description, String mediaPath});
}

/// @nodoc
class __$$ResultCreateRequestDtoImplCopyWithImpl<$Res>
    extends _$ResultCreateRequestDtoCopyWithImpl<$Res,
        _$ResultCreateRequestDtoImpl>
    implements _$$ResultCreateRequestDtoImplCopyWith<$Res> {
  __$$ResultCreateRequestDtoImplCopyWithImpl(
      _$ResultCreateRequestDtoImpl _value,
      $Res Function(_$ResultCreateRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? mediaPath = null,
  }) {
    return _then(_$ResultCreateRequestDtoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      mediaPath: null == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResultCreateRequestDtoImpl
    with DiagnosticableTreeMixin
    implements _ResultCreateRequestDto {
  _$ResultCreateRequestDtoImpl(
      {required this.name, required this.description, this.mediaPath = ''});

  factory _$ResultCreateRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultCreateRequestDtoImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey()
  final String mediaPath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResultCreateRequestDto(name: $name, description: $description, mediaPath: $mediaPath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResultCreateRequestDto'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('mediaPath', mediaPath));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultCreateRequestDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.mediaPath, mediaPath) ||
                other.mediaPath == mediaPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, mediaPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultCreateRequestDtoImplCopyWith<_$ResultCreateRequestDtoImpl>
      get copyWith => __$$ResultCreateRequestDtoImplCopyWithImpl<
          _$ResultCreateRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultCreateRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _ResultCreateRequestDto implements ResultCreateRequestDto {
  factory _ResultCreateRequestDto(
      {required final String name,
      required final String description,
      final String mediaPath}) = _$ResultCreateRequestDtoImpl;

  factory _ResultCreateRequestDto.fromJson(Map<String, dynamic> json) =
      _$ResultCreateRequestDtoImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get mediaPath;
  @override
  @JsonKey(ignore: true)
  _$$ResultCreateRequestDtoImplCopyWith<_$ResultCreateRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
