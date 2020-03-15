import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-model.dart';

part "user-model.g.dart";

@jsonSerializable
class CarModel {
  String plate;
  String model;
  bool active;

  CarModel({this.plate, this.model, this.active});
  // factory CarModel.fromJson(Map<String, dynamic> json) =>
  //     _$CarModelFromJson(json);
  // Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

enum PaymentMethodType { Credit }

@jsonSerializable
class PaymentMethod {
  String name;
  PaymentMethodType type;
  String lastDigits;
  String provider;

  PaymentMethod({this.name, this.type, this.lastDigits, this.provider});
  // factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
  //     _$PaymentMethodFromJson(json);
  // Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}

@jsonSerializable
class UserModel extends _UserModel with _$UserModel {
  UserModel({name, userId, email, phone, transactions, paymentMethods, cars})
      : super(
            name: name,
            userId: userId,
            email: email,
            phone: phone,
            transactions: transactions,
            paymentMethods: paymentMethods,
            cars: cars);
}

@jsonSerializable
abstract class _UserModel with Store {
  String userId;
  String name;
  String email;
  int phone;

  // Data
  @observable
  ObservableList<CarModel> cars;
  @observable
  ObservableList<TransactionModel> transactions;
  @observable
  ObservableList<PaymentMethod> paymentMethods;

  _UserModel(
      {this.name,
      this.userId,
      this.email,
      this.phone,
      this.transactions,
      this.paymentMethods,
      this.cars});
}

var _car = CarModel(model: "Toyota", plate: "YWM 394", active: true);
var _car2 = CarModel(model: "Toyota", plate: "UIS 267", active: false);
var allUsers = [
  UserModel(
    userId: "1",
    cars: ObservableList.of([_car, _car2]),
    email: "juan@mail.com",
    name: "Juan Manuel",
    phone: 3104902048,
    paymentMethods: ObservableList.of([
      PaymentMethod(
        lastDigits: "0023",
        name: "Main",
        type: PaymentMethodType.Credit,
        provider: "VISA",
      )
    ]),
    transactions: ObservableList.of([
      TransactionModel(
          id: 1,
          place: places[0],
          state: TransactionState.Completed,
          timestamp: DateTime.now().subtract(Duration(days: 2)),
          car: _car,
          cost: 8900),
      TransactionModel(
          id: 2,
          place: places[1],
          state: TransactionState.Waiting,
          timestamp: DateTime.now().subtract(Duration(minutes: 3)),
          car: _car,
          cost: 12400),
      TransactionModel(
          id: 3,
          place: places[2],
          state: TransactionState.Active,
          timestamp: DateTime.now().subtract(Duration(minutes: 20)),
          car: _car2,
          cost: 600)
    ]),
  )
];
