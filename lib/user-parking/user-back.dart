import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

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

  Future<Result<String>> deleteVehicle(String plate) async {
    final resp = await _client.delete("/vehicles/$plate");
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return Result("deleted successfully");
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }

  Future<Result<String>> updateVehicle(VehicleModel vehicle) async {
    final resp =
        await _client.put("/vehicles/${vehicle.plate}", body: vehicle.toJson());
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return Result("Update sucessfull");
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }

  Future<Result<VehicleModel>> createVehicle(VehicleModel vehicle) async {
    final resp = await _client.post("/vehicles", body: vehicle.toJson());
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 201:
            return Result(VehicleModel.fromJson(json.decode(resp.body)));
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }

  Future<Result<PaymentMethod>> createPaymentMethod(
      PaymentMethod method) async {
    final resp = await _client.post("/payment-methods", body: method.toJson());
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 201:
            return Result(PaymentMethod.fromJson(json.decode(resp.body)));
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }

  Future<Result<String>> deletePaymentMethod(String id) async {
    final resp = await _client.delete("/payment-methods/$id");
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return Result("deleted successfully");
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
