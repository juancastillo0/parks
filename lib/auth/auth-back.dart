import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';

part 'auth-back.freezed.dart';

@freezed
abstract class Result<T> implements _$Result<T> {
  const Result._();
  const factory Result(T value) = _Data<T>;
  const factory Result.err(String message) = _Error<T>;

  // Result<K> mapOk<K>(Result<K> Function(T) f) {
  //   return this.map((v) => f(v.value), err: (err) => err as Result<K>);
  // }

  Result<K> mapOk<K>(Result<K> Function(T) f) {
    return this.when(f, err: (err) => Result.err(err));
  }
}

class AuthBack {
  final client = GetIt.instance.get<BackClient>();

  Future<Result<String>> signIn(String email, String password) async {
    final body = {"email": email, "password": password};
    final resp = await client.post("/users/login", body: body);
    return resp.mapOk<String>(
      (resp) {
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
      },
    );
  }

  Future<Result<String>> signUp(
      String name, String email, String password) async {
    final body = {"name": name, "email": email, "password": password};
    final resp = await client.post("/users", body: body);
    return resp.mapOk<String>(
      (resp) {
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
      },
    );
  }
}
