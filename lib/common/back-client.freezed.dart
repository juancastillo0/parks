// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'back-client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BackResultTearOff {
  const _$BackResultTearOff();

  _Ok<T> call<T>(T value) {
    return _Ok<T>(
      value,
    );
  }

  _TimeOut<T> timeout<T>() {
    return _TimeOut<T>();
  }

  _Offline<T> offline<T>() {
    return _Offline<T>();
  }

  _Unauthorized<T> unauthorized<T>() {
    return _Unauthorized<T>();
  }

  _Unknown<T> unknown<T>() {
    return _Unknown<T>();
  }

  _Error<T> error<T>(String error) {
    return _Error<T>(
      error,
    );
  }
}

// ignore: unused_element
const $BackResult = _$BackResultTearOff();

mixin _$BackResult<T> {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  });
}

abstract class $BackResultCopyWith<T, $Res> {
  factory $BackResultCopyWith(
          BackResult<T> value, $Res Function(BackResult<T>) then) =
      _$BackResultCopyWithImpl<T, $Res>;
}

class _$BackResultCopyWithImpl<T, $Res>
    implements $BackResultCopyWith<T, $Res> {
  _$BackResultCopyWithImpl(this._value, this._then);

  final BackResult<T> _value;
  // ignore: unused_field
  final $Res Function(BackResult<T>) _then;
}

abstract class _$OkCopyWith<T, $Res> {
  factory _$OkCopyWith(_Ok<T> value, $Res Function(_Ok<T>) then) =
      __$OkCopyWithImpl<T, $Res>;
  $Res call({T value});
}

class __$OkCopyWithImpl<T, $Res> extends _$BackResultCopyWithImpl<T, $Res>
    implements _$OkCopyWith<T, $Res> {
  __$OkCopyWithImpl(_Ok<T> _value, $Res Function(_Ok<T>) _then)
      : super(_value, (v) => _then(v as _Ok<T>));

  @override
  _Ok<T> get _value => super._value as _Ok<T>;

  @override
  $Res call({
    Object value = freezed,
  }) {
    return _then(_Ok<T>(
      value == freezed ? _value.value : value as T,
    ));
  }
}

class _$_Ok<T> extends _Ok<T> with DiagnosticableTreeMixin {
  _$_Ok(this.value)
      : assert(value != null),
        super._();

  @override
  final T value;

  bool _didisOffline = false;
  bool _isOffline;

  @override
  bool get isOffline {
    if (_didisOffline == false) {
      _didisOffline = true;
      _isOffline = this.maybeWhen((value) => false,
          offline: () => true, orElse: () => false);
    }
    return _isOffline;
  }

  bool _didisOk = false;
  bool _isOk;

  @override
  bool get isOk {
    if (_didisOk == false) {
      _didisOk = true;
      _isOk = this.maybeWhen((value) => true, orElse: () => false);
    }
    return _isOk;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackResult<$T>(value: $value, isOffline: $isOffline, isOk: $isOk)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackResult<$T>'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('isOffline', isOffline))
      ..add(DiagnosticsProperty('isOk', isOk));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Ok<T> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  _$OkCopyWith<T, _Ok<T>> get copyWith =>
      __$OkCopyWithImpl<T, _Ok<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return $default(value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Ok<T> extends BackResult<T> {
  _Ok._() : super._();
  factory _Ok(T value) = _$_Ok<T>;

  T get value;
  _$OkCopyWith<T, _Ok<T>> get copyWith;
}

abstract class _$TimeOutCopyWith<T, $Res> {
  factory _$TimeOutCopyWith(
          _TimeOut<T> value, $Res Function(_TimeOut<T>) then) =
      __$TimeOutCopyWithImpl<T, $Res>;
}

class __$TimeOutCopyWithImpl<T, $Res> extends _$BackResultCopyWithImpl<T, $Res>
    implements _$TimeOutCopyWith<T, $Res> {
  __$TimeOutCopyWithImpl(_TimeOut<T> _value, $Res Function(_TimeOut<T>) _then)
      : super(_value, (v) => _then(v as _TimeOut<T>));

  @override
  _TimeOut<T> get _value => super._value as _TimeOut<T>;
}

class _$_TimeOut<T> extends _TimeOut<T> with DiagnosticableTreeMixin {
  _$_TimeOut() : super._();

  bool _didisOffline = false;
  bool _isOffline;

  @override
  bool get isOffline {
    if (_didisOffline == false) {
      _didisOffline = true;
      _isOffline = this.maybeWhen((value) => false,
          offline: () => true, orElse: () => false);
    }
    return _isOffline;
  }

  bool _didisOk = false;
  bool _isOk;

  @override
  bool get isOk {
    if (_didisOk == false) {
      _didisOk = true;
      _isOk = this.maybeWhen((value) => true, orElse: () => false);
    }
    return _isOk;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackResult<$T>.timeout(isOffline: $isOffline, isOk: $isOk)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackResult<$T>.timeout'))
      ..add(DiagnosticsProperty('isOffline', isOffline))
      ..add(DiagnosticsProperty('isOk', isOk));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _TimeOut<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return timeout();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (timeout != null) {
      return timeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class _TimeOut<T> extends BackResult<T> {
  _TimeOut._() : super._();
  factory _TimeOut() = _$_TimeOut<T>;
}

abstract class _$OfflineCopyWith<T, $Res> {
  factory _$OfflineCopyWith(
          _Offline<T> value, $Res Function(_Offline<T>) then) =
      __$OfflineCopyWithImpl<T, $Res>;
}

class __$OfflineCopyWithImpl<T, $Res> extends _$BackResultCopyWithImpl<T, $Res>
    implements _$OfflineCopyWith<T, $Res> {
  __$OfflineCopyWithImpl(_Offline<T> _value, $Res Function(_Offline<T>) _then)
      : super(_value, (v) => _then(v as _Offline<T>));

  @override
  _Offline<T> get _value => super._value as _Offline<T>;
}

class _$_Offline<T> extends _Offline<T> with DiagnosticableTreeMixin {
  _$_Offline() : super._();

  bool _didisOffline = false;
  bool _isOffline;

  @override
  bool get isOffline {
    if (_didisOffline == false) {
      _didisOffline = true;
      _isOffline = this.maybeWhen((value) => false,
          offline: () => true, orElse: () => false);
    }
    return _isOffline;
  }

  bool _didisOk = false;
  bool _isOk;

  @override
  bool get isOk {
    if (_didisOk == false) {
      _didisOk = true;
      _isOk = this.maybeWhen((value) => true, orElse: () => false);
    }
    return _isOk;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackResult<$T>.offline(isOffline: $isOffline, isOk: $isOk)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackResult<$T>.offline'))
      ..add(DiagnosticsProperty('isOffline', isOffline))
      ..add(DiagnosticsProperty('isOk', isOk));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Offline<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return offline();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (offline != null) {
      return offline();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return offline(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class _Offline<T> extends BackResult<T> {
  _Offline._() : super._();
  factory _Offline() = _$_Offline<T>;
}

abstract class _$UnauthorizedCopyWith<T, $Res> {
  factory _$UnauthorizedCopyWith(
          _Unauthorized<T> value, $Res Function(_Unauthorized<T>) then) =
      __$UnauthorizedCopyWithImpl<T, $Res>;
}

class __$UnauthorizedCopyWithImpl<T, $Res>
    extends _$BackResultCopyWithImpl<T, $Res>
    implements _$UnauthorizedCopyWith<T, $Res> {
  __$UnauthorizedCopyWithImpl(
      _Unauthorized<T> _value, $Res Function(_Unauthorized<T>) _then)
      : super(_value, (v) => _then(v as _Unauthorized<T>));

  @override
  _Unauthorized<T> get _value => super._value as _Unauthorized<T>;
}

class _$_Unauthorized<T> extends _Unauthorized<T> with DiagnosticableTreeMixin {
  _$_Unauthorized() : super._();

  bool _didisOffline = false;
  bool _isOffline;

  @override
  bool get isOffline {
    if (_didisOffline == false) {
      _didisOffline = true;
      _isOffline = this.maybeWhen((value) => false,
          offline: () => true, orElse: () => false);
    }
    return _isOffline;
  }

  bool _didisOk = false;
  bool _isOk;

  @override
  bool get isOk {
    if (_didisOk == false) {
      _didisOk = true;
      _isOk = this.maybeWhen((value) => true, orElse: () => false);
    }
    return _isOk;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackResult<$T>.unauthorized(isOffline: $isOffline, isOk: $isOk)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackResult<$T>.unauthorized'))
      ..add(DiagnosticsProperty('isOffline', isOffline))
      ..add(DiagnosticsProperty('isOk', isOk));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Unauthorized<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class _Unauthorized<T> extends BackResult<T> {
  _Unauthorized._() : super._();
  factory _Unauthorized() = _$_Unauthorized<T>;
}

abstract class _$UnknownCopyWith<T, $Res> {
  factory _$UnknownCopyWith(
          _Unknown<T> value, $Res Function(_Unknown<T>) then) =
      __$UnknownCopyWithImpl<T, $Res>;
}

class __$UnknownCopyWithImpl<T, $Res> extends _$BackResultCopyWithImpl<T, $Res>
    implements _$UnknownCopyWith<T, $Res> {
  __$UnknownCopyWithImpl(_Unknown<T> _value, $Res Function(_Unknown<T>) _then)
      : super(_value, (v) => _then(v as _Unknown<T>));

  @override
  _Unknown<T> get _value => super._value as _Unknown<T>;
}

class _$_Unknown<T> extends _Unknown<T> with DiagnosticableTreeMixin {
  _$_Unknown() : super._();

  bool _didisOffline = false;
  bool _isOffline;

  @override
  bool get isOffline {
    if (_didisOffline == false) {
      _didisOffline = true;
      _isOffline = this.maybeWhen((value) => false,
          offline: () => true, orElse: () => false);
    }
    return _isOffline;
  }

  bool _didisOk = false;
  bool _isOk;

  @override
  bool get isOk {
    if (_didisOk == false) {
      _didisOk = true;
      _isOk = this.maybeWhen((value) => true, orElse: () => false);
    }
    return _isOk;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackResult<$T>.unknown(isOffline: $isOffline, isOk: $isOk)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackResult<$T>.unknown'))
      ..add(DiagnosticsProperty('isOffline', isOffline))
      ..add(DiagnosticsProperty('isOk', isOk));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Unknown<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return unknown();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _Unknown<T> extends BackResult<T> {
  _Unknown._() : super._();
  factory _Unknown() = _$_Unknown<T>;
}

abstract class _$ErrorCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) then) =
      __$ErrorCopyWithImpl<T, $Res>;
  $Res call({String error});
}

class __$ErrorCopyWithImpl<T, $Res> extends _$BackResultCopyWithImpl<T, $Res>
    implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(_Error<T> _value, $Res Function(_Error<T>) _then)
      : super(_value, (v) => _then(v as _Error<T>));

  @override
  _Error<T> get _value => super._value as _Error<T>;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(_Error<T>(
      error == freezed ? _value.error : error as String,
    ));
  }
}

class _$_Error<T> extends _Error<T> with DiagnosticableTreeMixin {
  _$_Error(this.error)
      : assert(error != null),
        super._();

  @override
  final String error;

  bool _didisOffline = false;
  bool _isOffline;

  @override
  bool get isOffline {
    if (_didisOffline == false) {
      _didisOffline = true;
      _isOffline = this.maybeWhen((value) => false,
          offline: () => true, orElse: () => false);
    }
    return _isOffline;
  }

  bool _didisOk = false;
  bool _isOk;

  @override
  bool get isOk {
    if (_didisOk == false) {
      _didisOk = true;
      _isOk = this.maybeWhen((value) => true, orElse: () => false);
    }
    return _isOk;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackResult<$T>.error(error: $error, isOffline: $isOffline, isOk: $isOk)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackResult<$T>.error'))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('isOffline', isOffline))
      ..add(DiagnosticsProperty('isOk', isOk));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error<T> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @override
  _$ErrorCopyWith<T, _Error<T>> get copyWith =>
      __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result timeout(),
    @required Result offline(),
    @required Result unauthorized(),
    @required Result unknown(),
    @required Result error(String error),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result timeout(),
    Result offline(),
    Result unauthorized(),
    Result unknown(),
    Result error(String error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Ok<T> value), {
    @required Result timeout(_TimeOut<T> value),
    @required Result offline(_Offline<T> value),
    @required Result unauthorized(_Unauthorized<T> value),
    @required Result unknown(_Unknown<T> value),
    @required Result error(_Error<T> value),
  }) {
    assert($default != null);
    assert(timeout != null);
    assert(offline != null);
    assert(unauthorized != null);
    assert(unknown != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Ok<T> value), {
    Result timeout(_TimeOut<T> value),
    Result offline(_Offline<T> value),
    Result unauthorized(_Unauthorized<T> value),
    Result unknown(_Unknown<T> value),
    Result error(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> extends BackResult<T> {
  _Error._() : super._();
  factory _Error(String error) = _$_Error<T>;

  String get error;
  _$ErrorCopyWith<T, _Error<T>> get copyWith;
}
