// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'back-client.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BackClient on _BackClient, Store {
  Computed<bool> _$isAuthorizedComputed;

  @override
  bool get isAuthorized =>
      (_$isAuthorizedComputed ??= Computed<bool>(() => super.isAuthorized))
          .value;
  Computed<bool> _$isConnectedComputed;

  @override
  bool get isConnected =>
      (_$isConnectedComputed ??= Computed<bool>(() => super.isConnected)).value;

  final _$connStateAtom = Atom(name: '_BackClient.connState');

  @override
  ConnectivityResult get connState {
    _$connStateAtom.context.enforceReadPolicy(_$connStateAtom);
    _$connStateAtom.reportObserved();
    return super.connState;
  }

  @override
  set connState(ConnectivityResult value) {
    _$connStateAtom.context.conditionallyRunInAction(() {
      super.connState = value;
      _$connStateAtom.reportChanged();
    }, _$connStateAtom, name: '${_$connStateAtom.name}_set');
  }

  final _$baseUrlAtom = Atom(name: '_BackClient.baseUrl');

  @override
  String get baseUrl {
    _$baseUrlAtom.context.enforceReadPolicy(_$baseUrlAtom);
    _$baseUrlAtom.reportObserved();
    return super.baseUrl;
  }

  @override
  set baseUrl(String value) {
    _$baseUrlAtom.context.conditionallyRunInAction(() {
      super.baseUrl = value;
      _$baseUrlAtom.reportChanged();
    }, _$baseUrlAtom, name: '${_$baseUrlAtom.name}_set');
  }

  final _$_tokenAtom = Atom(name: '_BackClient._token');

  @override
  String get _token {
    _$_tokenAtom.context.enforceReadPolicy(_$_tokenAtom);
    _$_tokenAtom.reportObserved();
    return super._token;
  }

  @override
  set _token(String value) {
    _$_tokenAtom.context.conditionallyRunInAction(() {
      super._token = value;
      _$_tokenAtom.reportChanged();
    }, _$_tokenAtom, name: '${_$_tokenAtom.name}_set');
  }

  final _$setTokenAsyncAction = AsyncAction('setToken');

  @override
  Future setToken(String token) {
    return _$setTokenAsyncAction.run(() => super.setToken(token));
  }

  final _$_requestWrapperAsyncAction = AsyncAction('_requestWrapper');

  @override
  Future<Result<http.Response>> _requestWrapper(
      Future<http.Response> Function() request, bool retry) {
    return _$_requestWrapperAsyncAction
        .run(() => super._requestWrapper(request, retry));
  }

  final _$_updateConnectivityStateAsyncAction =
      AsyncAction('_updateConnectivityState');

  @override
  Future _updateConnectivityState(ConnectivityResult event) {
    return _$_updateConnectivityStateAsyncAction
        .run(() => super._updateConnectivityState(event));
  }

  final _$_BackClientActionController = ActionController(name: '_BackClient');

  @override
  dynamic setBaseUrl(String _baseUrl) {
    final _$actionInfo = _$_BackClientActionController.startAction();
    try {
      return super.setBaseUrl(_baseUrl);
    } finally {
      _$_BackClientActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Result<http.Response>> post(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _$actionInfo = _$_BackClientActionController.startAction();
    try {
      return super.post(url, body: body, headers: headers);
    } finally {
      _$_BackClientActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Result<http.Response>> put(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _$actionInfo = _$_BackClientActionController.startAction();
    try {
      return super.put(url, body: body, headers: headers);
    } finally {
      _$_BackClientActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Result<http.Response>> delete(String url,
      {Map<String, String> headers}) {
    final _$actionInfo = _$_BackClientActionController.startAction();
    try {
      return super.delete(url, headers: headers);
    } finally {
      _$_BackClientActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Result<http.Response>> get(String url, {Map<String, String> headers}) {
    final _$actionInfo = _$_BackClientActionController.startAction();
    try {
      return super.get(url, headers: headers);
    } finally {
      _$_BackClientActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'connState: ${connState.toString()},baseUrl: ${baseUrl.toString()},isAuthorized: ${isAuthorized.toString()},isConnected: ${isConnected.toString()}';
    return '{$string}';
  }
}
