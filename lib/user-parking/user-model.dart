import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part "user-model.g.dart";

enum PaymentMethodType { Credit }

@jsonSerializable
class PaymentMethod {
  String name;
  @JsonProperty(enumValues: PaymentMethodType.values)
  PaymentMethodType type;
  String lastDigits;
  String provider;

  PaymentMethod({this.name, this.type, this.lastDigits, this.provider});
}

@jsonSerializable
class UserModel extends _UserModel with _$UserModel {
  UserModel(
      {name, userId, email, phone, transactions, paymentMethods, vehicles})
      : super(
            name: name,
            userId: userId,
            email: email,
            phone: phone,
            transactions: transactions,
            paymentMethods: paymentMethods,
            vehicles: vehicles);
}

@jsonSerializable
abstract class _UserModel with Store {
  String userId;
  String name;
  String email;
  int phone;

  // Data
  @observable
  ObservableMap<String, VehicleModel> vehicles;
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
      this.vehicles});
}

var _car = VehicleModel(model: "Toyota", plate: "YWM 394", active: true);
var _car2 = VehicleModel(model: "Toyota", plate: "UIS 267", active: false);
var allUsers = [
  UserModel(
    userId: "1",
    vehicles: ObservableMap.of({_car.plate: _car, _car2.plate: _car2}),
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
          endTimestamp: DateTime.now().subtract(Duration(days: 1, hours: 23)),
          vehicle: _car,
          cost: 8900),
      TransactionModel(
          id: 2,
          place: places[2],
          state: TransactionState.Completed,
          timestamp: DateTime.now().subtract(Duration(days: 1)),
          endTimestamp:
              DateTime.now().subtract(Duration(hours: 22, minutes: 12)),
          vehicle: _car,
          cost: 8900),
      TransactionModel(
          id: 3,
          place: places[1],
          state: TransactionState.Waiting,
          timestamp: DateTime.now().subtract(Duration(minutes: 3)),
          endTimestamp: null,
          vehicle: _car,
          cost: 12400),
      TransactionModel(
          id: 4,
          place: places[2],
          state: TransactionState.Active,
          timestamp: DateTime.now().subtract(Duration(minutes: 20)),
          endTimestamp: null,
          vehicle: _car2,
          cost: 600)
    ]),
  )
];
