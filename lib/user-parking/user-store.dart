import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'user-store.g.dart';

class UserStore extends _UserStore with _$UserStore {
  UserStore(UserModel user) : super();
}

abstract class _UserStore with Store {
  _UserStore() {
    box = getUserBox();
    user = box.getAt(0);
  }

  Box<UserModel> box;

  @observable
  UserModel user;

  @action
  Future createVehicle(VehicleModel vehicle) async {
    user.vehicles.putIfAbsent(vehicle.plate, () => vehicle);
    await box.putAt(0, user);
  }

  @action
  Future toggleVehicleState(VehicleModel vehicle) async {
    user.vehicles.update(vehicle.plate, (value) {
      value.active = !value.active;
      return value;
    });
    await box.putAt(0, user);
  }

  @action
  Future deleteVehicle(String plate) async {
    user.vehicles.remove(plate);
    await box.putAt(0, user);
  }

  @action
  Future createPaymentMethod(PaymentMethod method) async {
    user.paymentMethods.add(method);
    await box.putAt(0, user);
  }

  @action
  Future deletePaymentMethod(PaymentMethod method) async {
    user.paymentMethods.removeWhere((m) => m.name == method.name);
    await box.putAt(0, user);
  }
}
