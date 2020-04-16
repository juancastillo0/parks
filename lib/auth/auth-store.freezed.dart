// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'auth-store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  Authenticated call(String token) {
    return Authenticated(
      token,
    );
  }

  Error err(String message) {
    return Error(
      message,
    );
  }

  Loading loading() {
    return const Loading();
  }

  None none() {
    return const None();
  }
}

// ignore: unused_element
const $AuthState = _$AuthStateTearOff();

mixin _$AuthState {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String token), {
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String token), {
    Result err(String message),
    Result loading(),
    Result none(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Authenticated value), {
    @required Result err(Error value),
    @required Result loading(Loading value),
    @required Result none(None value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Authenticated value), {
    Result err(Error value),
    Result loading(Loading value),
    Result none(None value),
    @required Result orElse(),
  });
}

abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

abstract class $AuthenticatedCopyWith<$Res> {
  factory $AuthenticatedCopyWith(
          Authenticated value, $Res Function(Authenticated) then) =
      _$AuthenticatedCopyWithImpl<$Res>;
  $Res call({String token});
}

class _$AuthenticatedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthenticatedCopyWith<$Res> {
  _$AuthenticatedCopyWithImpl(
      Authenticated _value, $Res Function(Authenticated) _then)
      : super(_value, (v) => _then(v as Authenticated));

  @override
  Authenticated get _value => super._value as Authenticated;

  @override
  $Res call({
    Object token = freezed,
  }) {
    return _then(Authenticated(
      token == freezed ? _value.token : token as String,
    ));
  }
}

class _$Authenticated with DiagnosticableTreeMixin implements Authenticated {
  const _$Authenticated(this.token) : assert(token != null);

  @override
  final String token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState(token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState'))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Authenticated &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(token);

  @override
  $AuthenticatedCopyWith<Authenticated> get copyWith =>
      _$AuthenticatedCopyWithImpl<Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String token), {
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return $default(token);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String token), {
    Result err(String message),
    Result loading(),
    Result none(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Authenticated value), {
    @required Result err(Error value),
    @required Result loading(Loading value),
    @required Result none(None value),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Authenticated value), {
    Result err(Error value),
    Result loading(Loading value),
    Result none(None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Authenticated implements AuthState {
  const factory Authenticated(String token) = _$Authenticated;

  String get token;
  $AuthenticatedCopyWith<Authenticated> get copyWith;
}

abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

class _$ErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(Error(
      message == freezed ? _value.message : message as String,
    ));
  }
}

class _$Error with DiagnosticableTreeMixin implements Error {
  const _$Error(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.err(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.err'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String token), {
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return err(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String token), {
    Result err(String message),
    Result loading(),
    Result none(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (err != null) {
      return err(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Authenticated value), {
    @required Result err(Error value),
    @required Result loading(Loading value),
    @required Result none(None value),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return err(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Authenticated value), {
    Result err(Error value),
    Result loading(Loading value),
    Result none(None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (err != null) {
      return err(this);
    }
    return orElse();
  }
}

abstract class Error implements AuthState {
  const factory Error(String message) = _$Error;

  String get message;
  $ErrorCopyWith<Error> get copyWith;
}

abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

class _$LoadingCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

class _$Loading with DiagnosticableTreeMixin implements Loading {
  const _$Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String token), {
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String token), {
    Result err(String message),
    Result loading(),
    Result none(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Authenticated value), {
    @required Result err(Error value),
    @required Result loading(Loading value),
    @required Result none(None value),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Authenticated value), {
    Result err(Error value),
    Result loading(Loading value),
    Result none(None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements AuthState {
  const factory Loading() = _$Loading;
}

abstract class $NoneCopyWith<$Res> {
  factory $NoneCopyWith(None value, $Res Function(None) then) =
      _$NoneCopyWithImpl<$Res>;
}

class _$NoneCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $NoneCopyWith<$Res> {
  _$NoneCopyWithImpl(None _value, $Res Function(None) _then)
      : super(_value, (v) => _then(v as None));

  @override
  None get _value => super._value as None;
}

class _$None with DiagnosticableTreeMixin implements None {
  const _$None();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.none()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.none'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String token), {
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return none();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String token), {
    Result err(String message),
    Result loading(),
    Result none(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Authenticated value), {
    @required Result err(Error value),
    @required Result loading(Loading value),
    @required Result none(None value),
  }) {
    assert($default != null);
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return none(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Authenticated value), {
    Result err(Error value),
    Result loading(Loading value),
    Result none(None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class None implements AuthState {
  const factory None() = _$None;
}
