import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:hive/hive.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'transaction-model.g.dart';

@HiveType(typeId: 1)
enum TransactionState {
  @HiveField(0)
  Completed,
  @HiveField(1)
  Active,
  @HiveField(2)
  Waiting
}

@HiveType(typeId: 6)
@jsonSerializable
class TransactionPlaceModel {
  TransactionPlaceModel({this.name, this.address});

  @HiveField(0)
  String name;
  @HiveField(1)
  String address;

  TransactionPlaceModel.fromPlace(Place place) {
    name = place.name;
    address = place.address;
  }
}

@HiveType(typeId: 0)
@jsonSerializable
class TransactionModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime timestamp;

  @HiveField(2)
  DateTime endTimestamp;

  @HiveField(3)
  TransactionPlaceModel place;

  @HiveField(4)
  @JsonProperty(enumValues: TransactionState.values)
  TransactionState state;

  @HiveField(5)
  double cost;

  @HiveField(6)
  VehicleModel vehicle;

  TransactionModel(
      {this.id,
      this.timestamp,
      this.endTimestamp,
      this.place,
      this.state,
      this.vehicle,
      this.cost});

  String costString() {
    return currencyString(cost);
  }

  static int compareTo(TransactionModel a, TransactionModel b) {
    if (a.state == b.state) {
      return a.id.compareTo(b.id);
    }
    switch (a.state) {
      case TransactionState.Waiting:
        return -1;
      case TransactionState.Active:
        if (b.state == TransactionState.Waiting) {
          return 1;
        }
        return -1;
      case TransactionState.Completed:
        return 1;
    }

    // Never happens
    return 0;
  }
}
