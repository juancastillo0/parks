import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' show Response;
import 'package:mobx/mobx.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'user-back.g.dart';

@HiveType(typeId: 9)
enum RequestVariant {
  @HiveField(0)
  deleteVehicle,
  @HiveField(1)
  updateVehicle,
  @HiveField(2)
  createVehicle,
  @HiveField(3)
  deletePaymentMethod
}

@HiveType(typeId: 10)
class UserRequest {
  @HiveField(0)
  final RequestVariant variant;
  @HiveField(1)
  final String path;
  @HiveField(2)
  final Map<String, dynamic> jsonBody;
  @HiveField(3)
  final String successInfo;
  @HiveField(4)
  int id;

  Widget asWidget() {
    final splitPath = path.split("/");
    final objectId = splitPath.length >= 3 ? splitPath[2] : null;
    switch (variant) {
      case RequestVariant.createVehicle:
        final vehicle = VehicleModel.fromJson(jsonBody);
        return Text("Create vehicle with plate ${vehicle.plate}");
      case RequestVariant.deleteVehicle:
        return Text("Delete vehicle with plate $objectId");
      case RequestVariant.updateVehicle:
        return Text("Update vehicle with plate $objectId");
      case RequestVariant.deletePaymentMethod:
        final p = PaymentMethod.fromJson(jsonBody);
        return Text("Delete payment method ${p.description}");
      default:
        return null;
    }
  }

  UserRequest(this.variant, this.path, this.jsonBody, this.successInfo);
}

typedef ResponseHandler<T> = T Function(UserRequest request, Response response);

class UserBack = _UserBack with _$UserBack;

abstract class _UserBack with Store {
  _UserBack(this._store) {
    _box = getUserRequestsBox();
    requests = ObservableList<UserRequest>.of(
      _box.toMap().entries.map((e) => e.value..id = e.key as int),
    );
    reaction((r) => _client.isConnected, handleConnectionChange);
  }

  final BackClient _client = GetIt.instance.get<BackClient>();

  final UserStore _store;

  Box<UserRequest> _box;

  @observable
  ObservableList<UserRequest> requests;

  @observable
  bool handlingConnectionChange = false;

  @action
  Future handleConnectionChange(bool isConnected) async {
    print(isConnected);
    print(handlingConnectionChange);
    if (isConnected && !handlingConnectionChange) {
      handlingConnectionChange = true;

      while (requests.isNotEmpty) {
        final request = requests.removeAt(0);
        print(requests);
        final resp = await _makeRequest(request);
        print(resp);
        if (resp.isOffline || resp.isTimeout) {
          requests.insert(0, request);
          break;
        }

        final error = resp.okOrError((value) async {
          await _box.delete(request.id);
          _store.processCachedResponse(request);
          _store.root.showInfo(SnackBar(
            content: Text(request.successInfo),
          ));
        });
        if (error != null) {
          requests.insert(0, request);
          _store.root.showError("Couldn't execute pending requests: $error");

          await deleteAllRequests();
          break;
        }
      }
      handlingConnectionChange = false;
      if (_client.isConnected) {
        if (requests.isNotEmpty) {
          handleConnectionChange(true);
        } else {
          _store.fetchUser();
        }
      }
    }
  }

  @action
  Future deleteAllRequests() async {
    await _box.deleteAll(requests.map((e) => e.id));
    for (final req in requests.reversed) {
      _store.revertCachedResponse(req);
    }
    requests.clear();
  }

  @action
  Future _addRequests(UserRequest request) async {
    request.id = await _box.add(request);
    requests.add(request);
    await _box.put(request.id, request);
  }

  Future<BackResult<dynamic>> _makeRequest(UserRequest req) async {
    switch (req.variant) {
      case RequestVariant.createVehicle:
        return _createVehicle(req, false);
      case RequestVariant.deleteVehicle:
        return _deleteVehicle(req, false);
      case RequestVariant.updateVehicle:
        return _updateVehicle(req, false);
      case RequestVariant.deletePaymentMethod:
        return _deletePaymentMethod(req, false);
      default:
        return null;
    }
  }

  Future<BackResult<UserModel>> userInfo() async {
    final resp = await _client.get("/users/most-data");
    return resp.mapOk<UserModel>(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            final _body = json.decode(resp.body);
            return BackResult(UserModel.fromJson(
              _body as Map<String, dynamic>,
            ));
          default:
            return BackResult.unknown();
        }
      },
    );
  }

  Future<BackResult<String>> deleteVehicle(VehicleModel vehicle) async {
    final plate = vehicle.plate;
    final path = "/vehicles/$plate";
    final cached = UserRequest(
      RequestVariant.deleteVehicle,
      path,
      vehicle.toJson(),
      "Vehicle with plate $plate deleted successfully.",
    );
    return _deleteVehicle(cached, true);
  }

  @action
  Future<BackResult<String>> _deleteVehicle(
    UserRequest request,
    bool cache,
  ) async {
    final resp = await _client.delete(request.path);
    final res = resp.mapOk<String>(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return BackResult(request.successInfo);
          default:
            return BackResult.unknown();
        }
      },
    );
    if (cache && res.isOffline) await _addRequests(request);
    return res;
  }

  Future<BackResult<String>> updateVehicle(VehicleModel vehicle) async {
    final request = UserRequest(
        RequestVariant.updateVehicle,
        "/vehicles/${vehicle.plate}",
        vehicle.toJson(),
        "Vehicle with plate ${vehicle.plate} has been ${vehicle.active ? 'activated' : 'deactivated'}");
    return _updateVehicle(request, true);
  }

  @action
  Future<BackResult<String>> _updateVehicle(
    UserRequest request,
    bool cache,
  ) async {
    final resp = await _client.put(request.path, body: request.jsonBody);
    final res = resp.mapOk<String>(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return BackResult(request.successInfo);
          default:
            return BackResult.unknown();
        }
      },
    );
    if (cache && res.isOffline) await _addRequests(request);
    return res;
  }

  Future<BackResult<VehicleModel>> createVehicle(VehicleModel vehicle) async {
    final request = UserRequest(
        RequestVariant.createVehicle,
        "/vehicles",
        vehicle.toJson(),
        "Vehicle with plate ${vehicle.plate} has been created");
    return _createVehicle(request, true);
  }

  @action
  Future<BackResult<VehicleModel>> _createVehicle(
      UserRequest request, bool cache) async {
    final resp = await _client.post(request.path, body: request.jsonBody);
    final res = resp.mapOk<VehicleModel>(
      (resp) {
        switch (resp.statusCode) {
          case 201:
            return BackResult(VehicleModel.fromJson(
              json.decode(resp.body) as Map<String, dynamic>,
            ));
          default:
            return BackResult.unknown();
        }
      },
    );
    if (cache && res.isOffline) await _addRequests(request);
    return res;
  }

  // PAYMENT METHODS

  Future<BackResult<PaymentMethod>> createPaymentMethod(
    PaymentMethod method,
  ) async {
    final resp = await _client.post("/payment-methods", body: method.toJson());
    return resp.mapOk<PaymentMethod>(
      (resp) {
        switch (resp.statusCode) {
          case 201:
            return BackResult(PaymentMethod.fromJson(
              json.decode(resp.body) as Map<String, dynamic>,
            ));
          default:
            return BackResult.unknown();
        }
      },
    );
  }

  Future<BackResult<String>> deletePaymentMethod(PaymentMethod method) async {
    final description = method.description;
    final name =
        description == null || description == "" ? "" : " $description";
    final request = UserRequest(
        RequestVariant.deletePaymentMethod,
        "/payment-methods/${method.id}",
        method.toJson(),
        "The payment method$name from ${method.provider} with last digits ${method.lastDigits} has been deleted");
    return _deletePaymentMethod(request, true);
  }

  @action
  Future<BackResult<String>> _deletePaymentMethod(
      UserRequest request, bool cache) async {
    final resp = await _client.delete(request.path);
    final res = resp.mapOk<String>(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return BackResult(request.successInfo);
          default:
            return BackResult.unknown();
        }
      },
    );
    if (cache && res.isOffline) await _addRequests(request);
    return res;
  }
}
