import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:parks/auth/auth-back.dart';

class BackClient {
  BackClient() {
    _connectivity = Connectivity();
    _connectivity.checkConnectivity().then(_updateConnectivityState);
    _connectivity.onConnectivityChanged.listen(_updateConnectivityState);
    _client = http.Client();
  }

  http.Client _client;
  Connectivity _connectivity;
  ConnectivityResult connState;
  String baseUrl = "http://192.168.1.102:3000";
  String token;

  bool get isConnected {
    return connState != ConnectivityResult.none;
  }

  setToken(String _token) {
    token = _token;
  }

  setBaseUrl(String _baseUrl) {
    baseUrl = _baseUrl;
  }

  Map<String, String> get _headers {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
  }

  Future<Result<http.Response>> post(String url, {Map<String, dynamic> body}) {
    final _body = json.encode(body);
    final request =
        () => _client.post("$baseUrl$url", body: _body, headers: _headers);

    return _requestWrapper(request, true);
  }

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

  Future<void> _updateConnectivityState(ConnectivityResult event) async {
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
