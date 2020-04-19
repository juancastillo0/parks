import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/user-parking/user-model.dart';

class UserBack {
  final _client = GetIt.instance.get<BackClient>();

  Future<Result<UserModel>> userInfo() async {
    final resp = await _client.get("/users/most-data");
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            final _body = json.decode(resp.body);
            return Result(UserModel.fromJson(_body));
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }

  Future<Result<UserModel>> deleteVehicle(String plate) async {
    final resp = await _client.get("/users/most-data");
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return Result(JsonMapper.deserialize<UserModel>(resp.body));
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }
}
