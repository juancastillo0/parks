import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/user-parking/paymentMethod.dart';
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
    user.vehicles.putIfAbsent(vehicle.plate, () => vehicle);
  }

  @action
  Future toggleVehicleState(VehicleModel vehicle) async {
    user.vehicles.update(vehicle.plate, (value) {
      value.active = !value.active;
      return value;
    });
  }

  @action
  Future deleteVehicle(String plate) async {
    user.vehicles.remove(plate);
  }

  @action
  Future createPaymentMethod(PaymentMethod method) async {
    user.paymentMethods.add(method);
  }

  @action
  Future deletePaymentMethod(PaymentMethod method) async {
    user.paymentMethods.removeWhere((m) => m.name == method.name);
  }

  @action
  Future _persistUser(UserModel _user) async {
    await _box.put("user", _user);
    persistenceState = PersistenceState.Persisted;
  }
}
