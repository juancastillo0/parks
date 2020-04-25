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
    _back = UserBack(this);
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

  @observable
  ObservableList requestCache;

  @action
  Future fetchUser() async {
    loading = true;
    final res = await _back.userInfo();
    final _user = res.okOrNull();
    if (_user != null) user = _user;
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
        _createVehicle(VehicleModel.fromJson(req.jsonBody));
        break;
      case RequestVariant.deleteVehicle:
        _deleteVehicle(req.path.split("/")[2]);
        break;
      case RequestVariant.updateVehicle:
        _toggleVehicleState(VehicleModel.fromJson(req.jsonBody), true);
        break;
      case RequestVariant.deletePaymentMethod:
        return _deletePaymentMethod(req.path.split("/")[2]);
        break;
    }
    root.showInfo(SnackBar(
      content: Text(req.successInfo),
    ));
  }

  @action
  Future<String> createVehicle(VehicleModel vehicle) async {
    final res = await _back.createVehicle(vehicle);
    return res.okOrOffline(
      _createVehicle,
      offline: () {
        vehicle.saved = false;
        _createVehicle(vehicle);
        root.showInfo(SnackBar(
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
        root.showInfo(SnackBar(
          content: Text(
            "The vehicle will be updated when you recover your connection.",
          ),
        ));
        return null;
      },
    );
  }

  @action
  void _toggleVehicleState(VehicleModel toggled, bool saved) =>
      user.vehicles.update(toggled.plate, (value) {
        value.saved = saved;
        value.active = toggled.active;
        return value;
      });

  @action
  Future deleteVehicle(String plate) async {
    final res = await _back.deleteVehicle(plate);
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
        root.showInfo(SnackBar(
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
    if (safeToPersist) {
      await _box.put("user", _user);
      persistenceState = PersistenceState.Persisted;
    }
  }
}
