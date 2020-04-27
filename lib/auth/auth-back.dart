import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';

class AuthBack {
  final _client = GetIt.instance.get<BackClient>();

  Future<BackResult<String>> signIn(
    String email,
    String password,
    String fcmToken,
  ) async {
    final body = {
      "email": email,
      "password": password,
      "fcmToken": fcmToken,
      "isFlutter": true
    };
    final resp = await _client.post("/users/login", body: body);

    return resp.mapOk<String>(
      (resp) {
        if (resp.statusCode == 200) {
          final token = json.decode(resp.body)["token"] as String;
          return BackResult(token);
        } else if (resp.statusCode == 404) {
          return BackResult.error("Email not found");
        } else if (resp.statusCode == 400) {
          return BackResult.error("Wrong email or password");
        } else {
          return BackResult.error("Server error");
        }
      },
    );
  }

  Future<BackResult<String>> signUp(
    String name,
    String email,
    String password,
    String phone,
    String fcmToken,
  ) async {
    final body = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "fcmToken": fcmToken,
      "isFlutter": true
    };
    final resp = await _client.post("/users", body: body);

    return resp.mapOk<String>(
      (resp) {
        if (resp.statusCode == 201) {
          final token = json.decode(resp.body)["token"] as String;
          return BackResult(token);
        } else if (resp.statusCode == 409) {
          return BackResult.error("A user with the email already exists");
        } else if (resp.statusCode == 400) {
          return BackResult.error("Missing required fields");
        } else {
          return BackResult.error("Server error");
        }
      },
    );
  }
}
