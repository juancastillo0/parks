import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/user-parking/user-back.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'user-store.g.dart';

class UserStore extends _UserStore with _$UserStore {
  UserStore(RootStore root) : super(root);
}

enum PersistenceState { Persisted, Waiting }

abstract class _UserStore with Store {
  _UserStore(this.root) {
    _box = getUserBox();
    user = _box.get("user");
    //ignore: argument_type_not_assignable
    _back = UserBack(this as UserStore);
    reaction((_reaction) => user, _persistUser);
  }
  RootStore root;
  UserBack _back;
  Box<UserModel> _box;

  @observable
  PersistenceState persistenceState = PersistenceState.Persisted;
  @observable
  UserModel user;
  @observable
  bool loading = false;

  @action
  Future fetchUser() async {
    if (requests.isNotEmpty) {
      return;
    }
    loading = true;
    final res = await _back.userInfo();
    final _user = res.okOrNull();
    if (_user != null) {
      user = _user;
    }
    loading = false;
  }

  @computed
  ObservableList<UserRequest> get requests => _back.requests;

  @computed
  bool get safeToPersist => user.vehicles.values.every((e) => e.saved);

  @action
  void processCachedResponse(UserRequest req) {
    switch (req.variant) {
      case RequestVariant.createVehicle:
        final vehicle = VehicleModel.fromJson(req.jsonBody);
        user.vehicles[vehicle.plate].saved = true;
        break;
      case RequestVariant.updateVehicle:
        final vehicle = VehicleModel.fromJson(req.jsonBody);
        user.vehicles[vehicle.plate].saved = true;
        break;
      default:
        break;
    }
  }

  @action
  Future deleteAllRequests() async {
    await _back.deleteAllRequests();
  }

  @action
  void revertCachedResponse(UserRequest req) {
    switch (req.variant) {
      case RequestVariant.createVehicle:
        _deleteVehicle(VehicleModel.fromJson(req.jsonBody).plate);
        break;
      case RequestVariant.deleteVehicle:
        _createVehicle(VehicleModel.fromJson(req.jsonBody));
        break;
      case RequestVariant.updateVehicle:
        final vehicle = VehicleModel.fromJson(req.jsonBody);
        _toggleVehicleState(vehicle..active = !vehicle.active, true);
        break;
      case RequestVariant.deletePaymentMethod:
        _createPaymentMethod(PaymentMethod.fromJson(req.jsonBody));
        break;
    }
  }

  @action
  Future<String> createVehicle(VehicleModel vehicle) async {
    vehicle.plate = vehicle.plate.replaceAll(RegExp(" "), "").toUpperCase();
    if (user.vehicles.containsKey(vehicle.plate)) {
      return "Vehicle with the plate ${vehicle.plate} already created";
    }
    final res = await _back.createVehicle(vehicle);
    return res.okOrOffline(
      _createVehicle,
      offline: () {
        vehicle.saved = false;
        _createVehicle(vehicle);
        root.showInfo(const SnackBar(
          content: Text(
            "The vehicle will be created when you recover your connection.",
          ),
        ));
        return null;
      },
    );
  }

  @action
  void _createVehicle(VehicleModel vehicle) =>
      user.vehicles.putIfAbsent(vehicle.plate, () => vehicle);

  @action
  Future toggleVehicleState(VehicleModel vehicle) async {
    final toggled = vehicle.toggled();
    final res = await _back.updateVehicle(toggled);
    return res.okOrOffline(
      (_) => _toggleVehicleState(toggled, true),
      offline: () {
        _toggleVehicleState(toggled, false);
        root.showInfo(const SnackBar(
          content: Text(
            "The vehicle will be updated when you recover your connection.",
          ),
        ));
        return null;
      },
    );
  }

  @action
  void _toggleVehicleState(VehicleModel toggled, bool saved) {
    root.showInfo(SnackBar(
      content: Text(
        "You will ${toggled.active ? '' : 'not '}receive notifications"
        " from the vehicle with plates ${toggled.plate}.",
      ),
    ));
    user.vehicles.update(toggled.plate, (value) {
      value.saved = saved;
      value.active = toggled.active;
      return value;
    });
  }

  @action
  Future deleteVehicle(String plate) async {
    final res = await _back.deleteVehicle(user.vehicles[plate]);
    return res.okOrOffline(
      (_) => _deleteVehicle(plate),
      offline: () {
        // final vehicle = user.vehicles[plate];
        root.showInfo(SnackBar(
          content: Text(
            "The vehicle with plate $plate will be deleted when you recover your connection.",
          ),
          // action: SnackBarAction(
          //     label: "UNDO",
          //     onPressed: () {
          //       _createVehicle(vehicle);
          //     }),
        ));
        _deleteVehicle(plate);
        return null;
      },
    );
  }

  @action
  void _deleteVehicle(String plate) => user.vehicles.remove(plate);

  @action
  Future<String> createPaymentMethod(PaymentMethod method) async {
    final res = await _back.createPaymentMethod(method);
    return res.okOrError(_createPaymentMethod);
  }

  // PAYMENT METHOD

  @action
  void _createPaymentMethod(PaymentMethod method) =>
      user.paymentMethods.add(method);

  @action
  Future deletePaymentMethod(PaymentMethod method) async {
    final res = await _back.deletePaymentMethod(method);
    return res.okOrOffline(
      (_) => _deletePaymentMethod(method.id),
      offline: () {
        _deletePaymentMethod(method.id);
        root.showInfo(const SnackBar(
          content: Text(
            "The payment method will be removed when you recover your connection.",
          ),
          // action: SnackBarAction(
          //     label: "UNDO",
          //     onPressed: () {
          //       _createPaymentMethod(method);
          //     }),
        ));
        return null;
      },
    );
  }

  @action
  void _deletePaymentMethod(String id) =>
      user.paymentMethods.removeWhere((m) => m.id == id);

  @action
  Future _persistUser(UserModel _user) async {
    await _box.put("user", _user);
  }
}
