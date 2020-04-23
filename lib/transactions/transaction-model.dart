import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:parks/common/root-store.dart';
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
@JsonSerializable()
class TransactionPlaceModel {
  TransactionPlaceModel({this.name, this.address});

  @HiveField(0)
  String name;
  @HiveField(1)
  String address;
  @HiveField(2)
  String id;

  TransactionPlaceModel.fromPlace(PlaceModel place) {
    name = place.name;
    address = place.address;
    id = place.id;
  }

  bool operator ==(other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

@HiveType(typeId: 0)
@JsonSerializable()
class TransactionModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  @JsonKey(name: "startTime")
  DateTime timestamp;

  @HiveField(2)
  @JsonKey(name: "endTime")
  DateTime endTimestamp;

  @HiveField(3)
  @JsonKey(
      name: "parking_lot_id",
      fromJson: _TransactionPlaceConverter.fromJSON,
      toJson: _TransactionPlaceConverter.toJSON)
  TransactionPlaceModel place;

  @HiveField(4)
  @JsonKey(
      fromJson: _TransactionStateConverter.fromJson,
      toJson: _TransactionStateConverter.toJson)
  TransactionState state;

  @HiveField(5)
  @JsonKey(defaultValue: 0)
  int cost = 0;

  @HiveField(6)
  @JsonKey(
      name: "vehicle_plate",
      fromJson: _TransactionVehicleConverter.fromJson,
      toJson: _TransactionVehicleConverter.toJson)
  VehicleModel vehicle;

  TransactionModel(
      {this.id,
      this.timestamp,
      this.endTimestamp,
      this.place,
      this.state,
      this.vehicle,
      this.cost = 0});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  String costString() {
    return currencyString(cost);
  }

  bool operator ==(other) {
    return id == other.id;
  }

  int get hashCode => id.hashCode;

  static int compareTo(TransactionModel a, TransactionModel b) {
    if (a.state == b.state) return a.id.compareTo(b.id);

    switch (a.state) {
      case TransactionState.Waiting:
        return -1;
      case TransactionState.Active:
        if (b.state == TransactionState.Waiting) return 1;
        return -1;
      case TransactionState.Completed:
        return 1;
      default:
        return 0;
    }
  }
}

//////////////////              CONVERTERS
//////////////////////////////////////////

class _TransactionPlaceConverter {
  static TransactionPlaceModel fromJSON(jsonValue) {
    final rootStore = GetIt.instance.get<RootStore>();
    final place = rootStore.placeStore.places[jsonValue];
    if (place != null) {
      return TransactionPlaceModel.fromPlace(place);
    } else {
      return null;
    }
  }

  static String toJSON(TransactionPlaceModel object) {
    return object.id;
  }
}

class _TransactionVehicleConverter {
  static VehicleModel fromJson(String jsonValue) {
    final rootStore = GetIt.instance.get<RootStore>();
    final vehicle = rootStore.userStore.user.vehicles[jsonValue];
    if (vehicle != null)
      return vehicle;
    else
      return VehicleModel()..plate = jsonValue;
  }

  static String toJson(VehicleModel object) {
    return object.plate;
  }
}

class _TransactionStateConverter {
  static TransactionState fromJson(jsonValue) {
    switch (jsonValue) {
      case "WAITING":
        return TransactionState.Waiting;
      case "COMPLETED":
        return TransactionState.Completed;
      case "ACTIVE":
        return TransactionState.Active;
      default:
        return null;
    }
  }

  static String toJson(TransactionState object) {
    return object.toString().split(".")[0];
  }
}
