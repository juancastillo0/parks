import 'package:mobx/mobx.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

var _car = VehicleModel(description: "Toyota", plate: "YWM 394", active: true);
var _car2 =
    VehicleModel(description: "Toyota", plate: "UIS 267", active: false);

var mockTransactions = ObservableList.of([
  TransactionModel(
      id: "1",
      place: TransactionPlaceModel.fromPlace(mockPlaces[0]),
      state: TransactionState.Completed,
      timestamp: DateTime.now().subtract(Duration(days: 2)),
      endTimestamp: DateTime.now().subtract(Duration(days: 1, hours: 23)),
      vehicle: _car,
      cost: 8900),
  TransactionModel(
      id: "2",
      place: TransactionPlaceModel.fromPlace(mockPlaces[2]),
      state: TransactionState.Completed,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      endTimestamp: DateTime.now().subtract(Duration(hours: 22, minutes: 12)),
      vehicle: _car,
      cost: 8900),
  TransactionModel(
      id: "3",
      place: TransactionPlaceModel.fromPlace(mockPlaces[1]),
      state: TransactionState.Waiting,
      timestamp: DateTime.now().subtract(Duration(minutes: 3)),
      endTimestamp: null,
      vehicle: _car,
      cost: 12400),
  TransactionModel(
      id: "4",
      place: TransactionPlaceModel.fromPlace(mockPlaces[2]),
      state: TransactionState.Active,
      timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      endTimestamp: null,
      vehicle: _car2,
      cost: 600)
]);

var mockUser = UserModel()
  ..id = "1"
  ..vehicles = ObservableMap.of({_car.plate: _car, _car2.plate: _car2})
  ..email = "juan@mail.com"
  ..name = "Juan Manuel"
  ..phone = "3104902048"
  ..paymentMethods = ObservableList.of([
    PaymentMethod(
      id: "1",
      lastDigits: "0023",
      description: "Main",
      type: PaymentMethodType.Credit,
      provider: "VISA",
    )
  ]);

var mockPlaces = [
  PlaceModel(
    id: "1",
    name: "National Park",
    description:
        "Sed culpa consequuntur labore in. Quis quia recusandae amet. Consectetur doloribus sit omnis temporibus officia. Earum ipsum tempora occaecati fugit. Deserunt facilis autem occaecati consequatur iure maxime ut.",
    address: "Calle 45 # 7 - 12",
    rating: 4.2,
    latitud: 4.669515485820514,
    longitud: -74.05895933919157,
  ),
  PlaceModel(
    id: "2",
    name: "Local Park",
    description:
        "Qui ratione officiis repellat. Et maiores facilis optio excepturi animi. Ut consequatur consequatur non omnis. Omnis ut ad enim quia in sit. Facere temporibus ipsam nesciunt recusandae ex qui dolores eos.",
    rating: 3.5,
    address: "Calle 80 # 11 - 38",
    latitud: 4.610515485820514,
    longitud: -74.07895933919157,
  ),
  PlaceModel(
    id: "3",
    name: "Virrey Park",
    description:
        "Voluptas placeat quia itaque consequatur reprehenderit sunt ipsa eligendi. Sed est pariatur consequatur voluptas sunt omnis non numquam veritatis. Praesentium est molestiae aut et. Quos nobis dolor enim est.",
    rating: 4.0,
    address: "Carrera 15 # 87 - 67",
    latitud: 4.607683967477323,
    longitud: -73.8008203466492,
  )
];
