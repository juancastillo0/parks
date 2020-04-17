import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-back.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'user-store.g.dart';

class UserStore extends _UserStore with _$UserStore {
  UserStore(UserModel user) : super();
}

enum PersistenceState { Persisted, Waiting }

abstract class _UserStore with Store {
  _UserStore() {
    _box = getUserBox();
    user = _box.getAt(0);

    reaction((_reaction) => user, _persistUser);
  }

  UserBack _back = UserBack();
  Box<UserModel> _box;
  @observable
  PersistenceState persistenceState = PersistenceState.Persisted;
  @observable
  UserModel user;

  @action
  Future fetchUser() async {
    final res = await _back.userInfo();
    final _user = res.okOrNull();
    if (_user != null) user = _user;
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
  _persistUser(UserModel _user) async {
    await _box.putAt(0, _user);
    persistenceState = PersistenceState.Persisted;
  }
}
