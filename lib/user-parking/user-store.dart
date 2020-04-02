import 'package:mobx/mobx.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'user-store.g.dart';

class UserStore extends _UserStore with _$UserStore {
  UserStore(UserModel user) : super(user);
}

abstract class _UserStore with Store {
  _UserStore(this.user);

  @observable
  UserModel user;

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
}
