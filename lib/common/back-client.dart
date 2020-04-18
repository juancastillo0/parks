import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/utils.dart';

part 'back-client.g.dart';

class BackClient extends _BackClient with _$BackClient {}

abstract class _BackClient with Store {
  _BackClient() {
    _connectivity = Connectivity();
    _connectivity.checkConnectivity().then(_updateConnectivityState);
    _connectivity.onConnectivityChanged.listen(_updateConnectivityState);
    _client = http.Client();
    _token = SettingsBox.getToken();
    print("token: $_token");
  }

  http.Client _client;
  Connectivity _connectivity;

  @observable
  ConnectivityResult connState;
  @observable
  String baseUrl = "http://192.168.1.102:3000";
  @observable
  String _token;

  @computed
  bool get isAuthorized {
    return _token != null;
  }

  @computed
  bool get isConnected {
    return connState != ConnectivityResult.none;
  }

  @action
  setToken(String token) async {
    await SettingsBox.setToken(token);
    _token = token;
  }

  @action
  setBaseUrl(String _baseUrl) {
    baseUrl = _baseUrl;
  }

  Map<String, String> get _defaultHeaders {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': _token
    };
  }

  @action
  Future<Result<http.Response>> post(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _body = json.encode(body);
    final _headers = _defaultHeaders;
    if (headers != null) _headers.addAll(headers);

    final request =
        () => _client.post("$baseUrl$url", body: _body, headers: _headers);

    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> put(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _body = json.encode(body);
    final _headers = _defaultHeaders;
    if (headers != null) _headers.addAll(headers);

    final request =
        () => _client.put("$baseUrl$url", body: _body, headers: _headers);

    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> delete(String url,
      {Map<String, String> headers}) {
    final _headers = _defaultHeaders;
    if (headers != null) _headers.addAll(headers);

    final request = () => _client.delete("$baseUrl$url", headers: _headers);

    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> get(String url, {Map<String, String> headers}) {
    final _headers = _defaultHeaders;
    if (headers != null) _headers.addAll(headers);

    final request =
        () async => await _client.get("$baseUrl$url", headers: _headers);

    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> _requestWrapper(
      Future<http.Response> Function() request, bool retry) async {
    try {
      final resp = await request();
      return Result(resp);
    } on SocketException catch (_) {
      if (isConnected && retry) {
        await _updateConnectivityState(connState);
        if (isConnected) {
          _requestWrapper(request, false);
        }
      }
      return Result.err("No internet connection");
    }
  }

  @action
  _updateConnectivityState(ConnectivityResult event) async {
    if (event != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          connState = event;
        } else {
          connState = ConnectivityResult.none;
        }
      } on SocketException catch (_) {
        connState = ConnectivityResult.none;
      }
    } else {
      connState = ConnectivityResult.none;
    }
  }
}
