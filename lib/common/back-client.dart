import 'dart:convert';
import 'dart:io';

import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';

part 'back-client.freezed.dart';
part 'back-client.g.dart';

class BackClient extends _BackClient with _$BackClient {}

BackResult<K> handle<K>(
  BackResult<http.Response> result,
  Map<int, K Function(http.Response)> handlers,
) {
  return result.maybeWhen<BackResult<K>>((resp) {
    if (handlers.containsKey(resp.statusCode)) {
      final ans = handlers[resp.statusCode](resp);
      return BackResult(ans);
    } else {
      return BackResult.unknown();
    }
  }, orElse: () => result as BackResult<K>);
}

@freezed
abstract class BackResult<T> implements _$BackResult<T> {
  factory BackResult(T value) = _Ok<T>;
  factory BackResult.timeout() = _TimeOut<T>;
  factory BackResult.offline() = _Offline<T>;
  factory BackResult.unauthorized() = _Unauthorized<T>;
  factory BackResult.unknown() = _Unknown<T>;
  factory BackResult.error(String error) = _Error<T>;
  BackResult._();

  T okOrNull() {
    return maybeWhen(
      (value) => value,
      orElse: () => null,
    );
  }

  String okOrError(
    Function(T) f, {
    String timeout,
    String offline,
    String unauthorized,
    String unknown,
  }) {
    return this.when<String>(
      (value) {
        f(value);
        return null;
      },
      error: (error) => error,
      offline: () => offline ?? "No internet connection",
      timeout: () => timeout ?? "Connection timeout, please try again later",
      unknown: () => unknown ?? "Connection error, please try again later",
      unauthorized: () => unauthorized ?? "You are not authorized",
    );
  }

  String okOrOffline(Function(T) f,
      {String timeout,
      String Function() offline,
      String unauthorized,
      String unknown}) {
    return this.when<String>(
      (value) {
        f(value);
        return null;
      },
      error: (error) => error,
      offline: () => offline != null ? offline() : "No internet connection",
      timeout: () => timeout ?? "Connection timeout, please try again later",
      unknown: () => unknown ?? "Connection error, please try again later",
      unauthorized: () => unauthorized ?? "You are not authorized",
    );
  }

  bool get isOffline =>
      maybeWhen((value) => false, offline: () => true, orElse: () => false);

  bool get isOk => maybeWhen((value) => true, orElse: () => false);

  bool get isTimeout =>
      maybeWhen((value) => false, timeout: () => true, orElse: () => false);

  BackResult<K> mapOk<K>(BackResult<K> Function(T) f) {
    return this.when<BackResult<K>>(
      f,
      error: (e) => BackResult<K>.error(e),
      offline: () => BackResult<K>.offline(),
      timeout: () => BackResult<K>.timeout(),
      unauthorized: () => BackResult<K>.unauthorized(),
      unknown: () => BackResult<K>.unknown(),
    );
  }
}

abstract class _BackClient with Store {
  _BackClient() {
    _connectivity = Connectivity();
    _connectivity.checkConnectivity().then(_updateConnectivityState);
    _connectivity.onConnectivityChanged.listen(_updateConnectivityState);
    _connectivity.checkConnection().then(_updateIsConnected);
    _connectivity.isConnected.listen(_updateIsConnected);

    _client = http.Client();
    token = SettingsBox.getToken();
  }

  http.Client _client;
  Connectivity _connectivity;

  @observable
  ConnectivityStatus connState;
  @observable
  String baseUrl = "http://192.168.1.101:8080";
  @observable
  String token;

  @computed
  bool get isAuthorized {
    return token != null;
  }

  @observable
  bool isConnected = true;
  @action
  void _updateIsConnected(bool connected) => isConnected = connected;

  @action
  Future setToken(String _token) async {
    await SettingsBox.setToken(_token);
    token = _token;
    if (token == null) {
      _client = http.Client();
    }
  }

  @action
  void setBaseUrl(String _baseUrl) {
    baseUrl = _baseUrl;
  }

  Map<String, String> _defaultHeaders(Map<String, String> headers) {
    final _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    if (headers != null) _headers.addAll(headers);
    return _headers;
  }

  @action
  Future<BackResult<http.Response>> post(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _body = json.encode(body);
    final _headers = _defaultHeaders(headers);

    Future<http.Response> request() =>
        _client.post("$baseUrl$url", body: _body, headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<BackResult<http.Response>> put(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _body = json.encode(body);
    final _headers = _defaultHeaders(headers);

    Future<http.Response> request() =>
        _client.put("$baseUrl$url", body: _body, headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<BackResult<http.Response>> delete(String url,
      {Map<String, String> headers}) {
    final _headers = _defaultHeaders(headers);

    Future<http.Response> request() =>
        _client.delete("$baseUrl$url", headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<BackResult<http.Response>> get(String url,
      {Map<String, String> headers}) {
    final _headers = _defaultHeaders(headers);

    Future<http.Response> request() =>
        _client.get("$baseUrl$url", headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<BackResult<http.Response>> _requestWrapper(
      Future<http.Response> Function() request, bool retry) async {
    if (!isConnected) return BackResult.offline();
    try {
      final respFuture = request().then((value) => BackResult(value));
      final resp = await Future.any<BackResult<http.Response>>(
          [Future.delayed(const Duration(seconds: 8)), respFuture]);
      if (resp != null) {
        if (resp.okOrNull().statusCode == 401) {
          token = null;
          return BackResult.unauthorized();
        } else {
          return resp;
        }
      } else if (retry) {
        return Future.any<BackResult<http.Response>>(
            [_requestWrapper(request, false), respFuture]);
      } else {
        return BackResult.timeout();
      }
    } on SocketException catch (_) {
      if (isConnected && retry) {
        final _state = await _connectivity.checkConnectivity();
        await _updateConnectivityState(_state);

        if (isConnected) return _requestWrapper(request, false);
      }
      return BackResult.offline();
    } catch (e) {
      print("Request ERROR: $e");
      return BackResult.unknown();
    }
  }

  @action
  Future _updateConnectivityState(ConnectivityStatus event) async {
    connState = event;
    isConnected = event != ConnectivityStatus.none
        ? await _connectivity.checkConnection()
        : false;
  }
}
