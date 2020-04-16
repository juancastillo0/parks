import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'auth-back.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result(T value) = _Data<T>;
  const factory Result.err(String message) = _Error<T>;
}

class AuthBack {
  String baseUrl = "http://192.168.1.102:3000";
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Result<String>> signIn(String email, String password) async {
    final body = json.encode({"email": email, "password": password});
    final resp =
        await post("$baseUrl/users/login", body: body, headers: headers);
    if (resp.statusCode == 200) {
      final token = json.decode(resp.body)["token"] as String;
      return Result(token);
    } else if (resp.statusCode == 404) {
      return Result.err("Email not found");
    } else if (resp.statusCode == 400) {
      return Result.err("Wrong email or password");
    } else {
      return Result.err("Server error");
    }
  }

  Future<Result<String>> signUp(
      String name, String email, String password) async {
    final body =
        json.encode({"name": name, "email": email, "password": password});
    final resp = await post("$baseUrl/users", body: body, headers: headers);
    if (resp.statusCode == 201) {
      final token = json.decode(resp.body)["token"] as String;
      return Result(token);
    } else if (resp.statusCode == 409) {
      return Result.err("A user with the email already exists");
    } else if (resp.statusCode == 400) {
      return Result.err("Missing required fields");
    } else {
      return Result.err("Server error");
    }
  }
}
