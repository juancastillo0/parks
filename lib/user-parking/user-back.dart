import 'dart:convert';

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
  deleteVehicle,
  updateVehicle,
  createVehicle,
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

  UserRequest(this.variant, this.path, this.jsonBody, this.successInfo);
}

typedef ResponseHandler<T> = T Function(UserRequest request, Response response);

class UserBack = _UserBack with _$UserBack;

abstract class _UserBack with Store {
  _UserBack(this._store) {
    _box = getUserRequestsBox();
    requests = ObservableList<UserRequest>.of(
      _box.toMap().entries.map((e) => e.value..id = e.key),
    );
    reaction((r) => _client.isConnected, _handleConnectionChange);
  }

  final BackClient _client = GetIt.instance.get<BackClient>();

  UserStore _store;

  Box<UserRequest> _box;

  @observable
  ObservableList<UserRequest> requests;

  bool _handlingConnectionChange = false;
  @action
  _handleConnectionChange(bool isConnected) async {
    if (isConnected && !_handlingConnectionChange) {
      _handlingConnectionChange = true;
      while (requests.isNotEmpty) {
        final request = requests.first;
        final resp = await _makeRequest(request);
        if (resp.isOffline) break;

        final error = resp.okOrError((value) async {
          await _box.delete(request.id);
          requests.removeAt(0);
          _store.processCachedResponse(request);
        });
        if (error != null) {
          _store.root.showError(error);
          break;
        }
      }
      _handlingConnectionChange = false;
    }
  }

  Future _addRequests(UserRequest request) async {
    request.id = await _box.add(request);
    requests.add(request);
    await _box.put(request.id, request);
  }

  Future<BackResult<dynamic>> _makeRequest(UserRequest req) async {
    switch (req.variant) {
      case RequestVariant.createVehicle:
        return await _createVehicle(req, false);
      case RequestVariant.deleteVehicle:
        return await _deleteVehicle(req, false);
      case RequestVariant.updateVehicle:
        return await _updateVehicle(req, false);
      case RequestVariant.deletePaymentMethod:
        return await _deletePaymentMethod(req, false);
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
            return BackResult(UserModel.fromJson(_body));
          default:
            return BackResult.unknown();
        }
      },
    );
  }

  Future<BackResult<String>> deleteVehicle(String plate) async {
    final path = "/vehicles/$plate";
    final cached = UserRequest(RequestVariant.deleteVehicle, path, null,
        "Vehicle with plate $plate deleted successfully.");
    return _deleteVehicle(cached, true);
  }

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

  Future<BackResult<VehicleModel>> _createVehicle(
      UserRequest request, bool cache) async {
    final resp = await _client.post(request.path, body: request.jsonBody);
    final res = resp.mapOk<VehicleModel>(
      (resp) {
        switch (resp.statusCode) {
          case 201:
            return BackResult(VehicleModel.fromJson(json.decode(resp.body)));
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
            return BackResult(PaymentMethod.fromJson(json.decode(resp.body)));
          default:
            return BackResult.unknown();
        }
      },
    );
  }

  Future<BackResult<String>> deletePaymentMethod(PaymentMethod method) async {
    final description = method.description;
    final name =
        description == null || description == "" ? "" : " " + description;
    final request = UserRequest(
        RequestVariant.deletePaymentMethod,
        "/payment-methods/${method.id}",
        null,
        "The payment method$name from ${method.provider} with last digits ${method.lastDigits} has been deleted");
    return _deletePaymentMethod(request, true);
  }

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
