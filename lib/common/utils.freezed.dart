// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'utils.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ResultTearOff {
  const _$ResultTearOff();

  _Data<T> call<T>(T value) {
    return _Data<T>(
      value,
    );
  }

  _Error<T> err<T>(String message) {
    return _Error<T>(
      message,
    );
  }
}

// ignore: unused_element
const $Result = _$ResultTearOff();

mixin _$Result<T> {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result err(String message),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result err(String message),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_Data<T> value), {
    @required Result err(_Error<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Data<T> value), {
    Result err(_Error<T> value),
    @required Result orElse(),
  });
}

abstract class $ResultCopyWith<T, $Res> {
  factory $ResultCopyWith(Result<T> value, $Res Function(Result<T>) then) =
      _$ResultCopyWithImpl<T, $Res>;
}

class _$ResultCopyWithImpl<T, $Res> implements $ResultCopyWith<T, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  final Result<T> _value;
  // ignore: unused_field
  final $Res Function(Result<T>) _then;
}

abstract class _$DataCopyWith<T, $Res> {
  factory _$DataCopyWith(_Data<T> value, $Res Function(_Data<T>) then) =
      __$DataCopyWithImpl<T, $Res>;
  $Res call({T value});
}

class __$DataCopyWithImpl<T, $Res> extends _$ResultCopyWithImpl<T, $Res>
    implements _$DataCopyWith<T, $Res> {
  __$DataCopyWithImpl(_Data<T> _value, $Res Function(_Data<T>) _then)
      : super(_value, (v) => _then(v as _Data<T>));

  @override
  _Data<T> get _value => super._value as _Data<T>;

  @override
  $Res call({
    Object value = freezed,
  }) {
    return _then(_Data<T>(
      value == freezed ? _value.value : value as T,
    ));
  }
}

class _$_Data<T> extends _Data<T> with DiagnosticableTreeMixin {
  const _$_Data(this.value)
      : assert(value != null),
        super._();

  @override
  final T value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Result<$T>(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Result<$T>'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Data<T> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  _$DataCopyWith<T, _Data<T>> get copyWith =>
      __$DataCopyWithImpl<T, _Data<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result err(String message),
  }) {
    assert($default != null);
    assert(err != null);
    return $default(value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result err(String message),
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
    Result $default(_Data<T> value), {
    @required Result err(_Error<T> value),
  }) {
    assert($default != null);
    assert(err != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Data<T> value), {
    Result err(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Data<T> extends Result<T> {
  const _Data._() : super._();
  const factory _Data(T value) = _$_Data<T>;

  T get value;
  _$DataCopyWith<T, _Data<T>> get copyWith;
}

abstract class _$ErrorCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) then) =
      __$ErrorCopyWithImpl<T, $Res>;
  $Res call({String message});
}

class __$ErrorCopyWithImpl<T, $Res> extends _$ResultCopyWithImpl<T, $Res>
    implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(_Error<T> _value, $Res Function(_Error<T>) _then)
      : super(_value, (v) => _then(v as _Error<T>));

  @override
  _Error<T> get _value => super._value as _Error<T>;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_Error<T>(
      message == freezed ? _value.message : message as String,
    ));
  }
}

class _$_Error<T> extends _Error<T> with DiagnosticableTreeMixin {
  const _$_Error(this.message)
      : assert(message != null),
        super._();

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Result<$T>.err(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Result<$T>.err'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error<T> &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$ErrorCopyWith<T, _Error<T>> get copyWith =>
      __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(T value), {
    @required Result err(String message),
  }) {
    assert($default != null);
    assert(err != null);
    return err(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(T value), {
    Result err(String message),
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
    Result $default(_Data<T> value), {
    @required Result err(_Error<T> value),
  }) {
    assert($default != null);
    assert(err != null);
    return err(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_Data<T> value), {
    Result err(_Error<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (err != null) {
      return err(this);
    }
    return orElse();
  }
}

abstract class _Error<T> extends Result<T> {
  const _Error._() : super._();
  const factory _Error(String message) = _$_Error<T>;

  String get message;
  _$ErrorCopyWith<T, _Error<T>> get copyWith;
}

class _$RequestStateTearOff {
  const _$RequestStateTearOff();

  _Err err(String message) {
    return _Err(
      message,
    );
  }

  _Loading loading() {
    return _Loading();
  }

  _None none() {
    return _None();
  }
}

// ignore: unused_element
const $RequestState = _$RequestStateTearOff();

mixin _$RequestState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result err(String message),
    Result loading(),
    Result none(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result err(_Err value),
    @required Result loading(_Loading value),
    @required Result none(_None value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result err(_Err value),
    Result loading(_Loading value),
    Result none(_None value),
    @required Result orElse(),
  });
}

abstract class $RequestStateCopyWith<$Res> {
  factory $RequestStateCopyWith(
          RequestState value, $Res Function(RequestState) then) =
      _$RequestStateCopyWithImpl<$Res>;
}

class _$RequestStateCopyWithImpl<$Res> implements $RequestStateCopyWith<$Res> {
  _$RequestStateCopyWithImpl(this._value, this._then);

  final RequestState _value;
  // ignore: unused_field
  final $Res Function(RequestState) _then;
}

abstract class _$ErrCopyWith<$Res> {
  factory _$ErrCopyWith(_Err value, $Res Function(_Err) then) =
      __$ErrCopyWithImpl<$Res>;
  $Res call({String message});
}

class __$ErrCopyWithImpl<$Res> extends _$RequestStateCopyWithImpl<$Res>
    implements _$ErrCopyWith<$Res> {
  __$ErrCopyWithImpl(_Err _value, $Res Function(_Err) _then)
      : super(_value, (v) => _then(v as _Err));

  @override
  _Err get _value => super._value as _Err;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_Err(
      message == freezed ? _value.message : message as String,
    ));
  }
}

class _$_Err extends _Err with DiagnosticableTreeMixin {
  _$_Err(this.message)
      : assert(message != null),
        super._();

  @override
  final String message;

  bool _didisLoading = false;
  bool _isLoading;

  @override
  bool get isLoading {
    if (_didisLoading == false) {
      _didisLoading = true;
      _isLoading = this.maybeWhen(loading: () => true, orElse: () => false);
    }
    return _isLoading;
  }

  bool _didisError = false;
  bool _isError;

  @override
  bool get isError {
    if (_didisError == false) {
      _didisError = true;
      _isError = this.maybeWhen(err: (_) => true, orElse: () => false);
    }
    return _isError;
  }

  bool _diderror = false;
  String _error;

  @override
  String get error {
    if (_diderror == false) {
      _diderror = true;
      _error = this.maybeWhen(err: (e) => e, orElse: () => null);
    }
    return _error;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RequestState.err(message: $message, isLoading: $isLoading, isError: $isError, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RequestState.err'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Err &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$ErrCopyWith<_Err> get copyWith =>
      __$ErrCopyWithImpl<_Err>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return err(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
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
  Result map<Result extends Object>({
    @required Result err(_Err value),
    @required Result loading(_Loading value),
    @required Result none(_None value),
  }) {
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return err(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result err(_Err value),
    Result loading(_Loading value),
    Result none(_None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (err != null) {
      return err(this);
    }
    return orElse();
  }
}

abstract class _Err extends RequestState {
  _Err._() : super._();
  factory _Err(String message) = _$_Err;

  String get message;
  _$ErrCopyWith<_Err> get copyWith;
}

abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

class __$LoadingCopyWithImpl<$Res> extends _$RequestStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

class _$_Loading extends _Loading with DiagnosticableTreeMixin {
  _$_Loading() : super._();

  bool _didisLoading = false;
  bool _isLoading;

  @override
  bool get isLoading {
    if (_didisLoading == false) {
      _didisLoading = true;
      _isLoading = this.maybeWhen(loading: () => true, orElse: () => false);
    }
    return _isLoading;
  }

  bool _didisError = false;
  bool _isError;

  @override
  bool get isError {
    if (_didisError == false) {
      _didisError = true;
      _isError = this.maybeWhen(err: (_) => true, orElse: () => false);
    }
    return _isError;
  }

  bool _diderror = false;
  String _error;

  @override
  String get error {
    if (_diderror == false) {
      _diderror = true;
      _error = this.maybeWhen(err: (e) => e, orElse: () => null);
    }
    return _error;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RequestState.loading(isLoading: $isLoading, isError: $isError, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RequestState.loading'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
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
  Result map<Result extends Object>({
    @required Result err(_Err value),
    @required Result loading(_Loading value),
    @required Result none(_None value),
  }) {
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result err(_Err value),
    Result loading(_Loading value),
    Result none(_None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends RequestState {
  _Loading._() : super._();
  factory _Loading() = _$_Loading;
}

abstract class _$NoneCopyWith<$Res> {
  factory _$NoneCopyWith(_None value, $Res Function(_None) then) =
      __$NoneCopyWithImpl<$Res>;
}

class __$NoneCopyWithImpl<$Res> extends _$RequestStateCopyWithImpl<$Res>
    implements _$NoneCopyWith<$Res> {
  __$NoneCopyWithImpl(_None _value, $Res Function(_None) _then)
      : super(_value, (v) => _then(v as _None));

  @override
  _None get _value => super._value as _None;
}

class _$_None extends _None with DiagnosticableTreeMixin {
  _$_None() : super._();

  bool _didisLoading = false;
  bool _isLoading;

  @override
  bool get isLoading {
    if (_didisLoading == false) {
      _didisLoading = true;
      _isLoading = this.maybeWhen(loading: () => true, orElse: () => false);
    }
    return _isLoading;
  }

  bool _didisError = false;
  bool _isError;

  @override
  bool get isError {
    if (_didisError == false) {
      _didisError = true;
      _isError = this.maybeWhen(err: (_) => true, orElse: () => false);
    }
    return _isError;
  }

  bool _diderror = false;
  String _error;

  @override
  String get error {
    if (_diderror == false) {
      _diderror = true;
      _error = this.maybeWhen(err: (e) => e, orElse: () => null);
    }
    return _error;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RequestState.none(isLoading: $isLoading, isError: $isError, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RequestState.none'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result err(String message),
    @required Result loading(),
    @required Result none(),
  }) {
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return none();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
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
  Result map<Result extends Object>({
    @required Result err(_Err value),
    @required Result loading(_Loading value),
    @required Result none(_None value),
  }) {
    assert(err != null);
    assert(loading != null);
    assert(none != null);
    return none(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result err(_Err value),
    Result loading(_Loading value),
    Result none(_None value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None extends RequestState {
  _None._() : super._();
  factory _None() = _$_None;
}
