import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/user-parking/user-back.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'user-store.g.dart';

class UserStore extends _UserStore with _$UserStore {}

enum PersistenceState { Persisted, Waiting }

abstract class _UserStore with Store {
  _UserStore() {
    _box = getUserBox();
    user = _box.get("user");

    reaction((_reaction) => user, _persistUser);
  }
  BackClient _backClient = GetIt.I.get<BackClient>();
  UserBack _back = UserBack();
  Box<UserModel> _box;

  @observable
  PersistenceState persistenceState = PersistenceState.Persisted;
  @observable
  UserModel user;
  @observable
  bool loading = false;

  @action
  Future fetchUser() async {
    loading = true;
    final res = await _back.userInfo();
    final _user = res.okOrNull();
    if (_user != null) user = _user;
    loading = false;
  }

  @action
  Future createVehicle(VehicleModel vehicle) async {
    final res = await _back.createVehicle(vehicle);
    return res.when(_createVehicle, err: (e) => e);
  }

  @action
  void _createVehicle(VehicleModel vehicle) =>
      user.vehicles.putIfAbsent(vehicle.plate, () => vehicle);

  @action
  Future toggleVehicleState(VehicleModel vehicle) async {
    final res = await _back.updateVehicle(vehicle.toggled());
    return res.when((_) => _toggleVehicleState(vehicle), err: (e) => e);
  }

  @action
  void _toggleVehicleState(VehicleModel vehicle) =>
      user.vehicles.update(vehicle.plate, (value) {
        value.active = !value.active;
        return value;
      });

  @action
  Future deleteVehicle(String plate) async {
    final res = await _back.deleteVehicle(plate);
    return res.when((_) => _deleteVehicle(plate), err: (e) => e);
  }

  @action
  void _deleteVehicle(String plate) => user.vehicles.remove(plate);

  @action
  Future createPaymentMethod(PaymentMethod method) async {
    final res = await _back.createPaymentMethod(method);
    return res.when(_createPaymentMethod, err: (e) => e);
  }

  @action
  void _createPaymentMethod(PaymentMethod method) =>
      user.paymentMethods.add(method);

  @action
  Future deletePaymentMethod(PaymentMethod method) async {
    final res = await _back.deletePaymentMethod(method.id);
    return res.when((_) => _deletePaymentMethod(method), err: (e) => e);
  }

  @action
  void _deletePaymentMethod(PaymentMethod method) =>
      user.paymentMethods.removeWhere((m) => m.id == method.id);

  @action
  Future _persistUser(UserModel _user) async {
    await _box.put("user", _user);
    persistenceState = PersistenceState.Persisted;
  }
}
