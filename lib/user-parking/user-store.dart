import 'package:mobx/mobx.dart';
import 'package:parks/user-parking/user-model.dart';

part 'user-store.g.dart';

class UserStore extends _UserStore with _$UserStore {
  UserStore(UserModel user) : super(user);
}

abstract class _UserStore with Store {
  _UserStore(this.user);

  @observable
  UserModel user;

  @action
  Future createCar(CarModel car) async {
    user.cars.add(car);
  }

  @action
  Future deleteCar(String plate) async {
    user.cars.removeWhere((car) => car.plate == plate);
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
