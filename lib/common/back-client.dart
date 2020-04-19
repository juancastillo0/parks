import 'dart:convert';
import 'dart:io';

import 'package:cross_connectivity/cross_connectivity.dart';
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
  String baseUrl = "http://192.168.1.102:3000";
  @observable
  String token;

  @computed
  bool get isAuthorized {
    return token != null;
  }

  @observable
  bool isConnected;
  @action
  _updateIsConnected(bool connected) => isConnected = connected;

  @action
  Future setToken(String _token) async {
    await SettingsBox.setToken(_token);
    token = _token;
    if (token == null) {
      _client = http.Client();
    }
  }

  @action
  setBaseUrl(String _baseUrl) {
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
  Future<Result<http.Response>> post(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _body = json.encode(body);
    final _headers = _defaultHeaders(headers);

    final request =
        () => _client.post("$baseUrl$url", body: _body, headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> put(String url,
      {Map<String, dynamic> body, Map<String, String> headers}) {
    final _body = json.encode(body);
    final _headers = _defaultHeaders(headers);

    final request =
        () => _client.put("$baseUrl$url", body: _body, headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> delete(String url,
      {Map<String, String> headers}) {
    final _headers = _defaultHeaders(headers);

    final request = () => _client.delete("$baseUrl$url", headers: _headers);
    return _requestWrapper(request, true);
  }

  @action
  Future<Result<http.Response>> get(String url, {Map<String, String> headers}) {
    final _headers = _defaultHeaders(headers);

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
        final _state = await _connectivity.checkConnectivity();
        await _updateConnectivityState(_state);

        if (isConnected) _requestWrapper(request, false);
      }
      return Result.err("No internet connection");
    }
  }

  @action
  _updateConnectivityState(ConnectivityStatus event) async {
    isConnected = await _connectivity.checkConnection();
    connState = event;
  }
}
