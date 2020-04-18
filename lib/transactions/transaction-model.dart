import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'transaction-model.g.dart';

@HiveType(typeId: 1)
@jsonSerializable
@Json(enumValues: TransactionState.values)
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
@jsonSerializable
class TransactionModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  @JsonProperty(name: "startTime")
  DateTime timestamp;

  @HiveField(2)
  @JsonProperty(name: "endTime")
  DateTime endTimestamp;

  @HiveField(3)
  @JsonProperty(name: "parking_lot_id", converter: TransactionPlaceConverter())
  TransactionPlaceModel place;

  @HiveField(4)
  @JsonProperty(converter: TransactionStateConverter())
  TransactionState state;

  @HiveField(5)
  @JsonProperty(defaultValue: 0)
  int cost = 0;

  @HiveField(6)
  @JsonProperty(name: "vehicle_plate", converter: TransactionVehicleConverter())
  VehicleModel vehicle;

  TransactionModel(
      {this.id,
      this.timestamp,
      this.endTimestamp,
      this.place,
      this.state,
      this.vehicle,
      this.cost = 0});

  String costString() {
    return currencyString(cost);
  }

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
    }
    // Never happens
    return 0;
  }
}

class TransactionPlaceConverter
    implements ICustomConverter<TransactionPlaceModel> {
  const TransactionPlaceConverter();

  @override
  TransactionPlaceModel fromJSON(jsonValue, [JsonProperty jsonProperty]) {
    if (jsonValue is TransactionPlaceModel) return jsonValue;
    final rootStore = GetIt.instance.get<RootStore>();
    final place = rootStore.placeStore.places[jsonValue];
    if (place != null) {
      return TransactionPlaceModel.fromPlace(place);
    } else {
      return null;
    }
  }

  @override
  toJSON(TransactionPlaceModel object, [JsonProperty jsonProperty]) {
    return object.id;
  }
}

class TransactionVehicleConverter implements ICustomConverter<VehicleModel> {
  const TransactionVehicleConverter();

  @override
  VehicleModel fromJSON(jsonValue, [JsonProperty jsonProperty]) {
    if (jsonValue is String) {
      final rootStore = GetIt.instance.get<RootStore>();
      final vehicle = rootStore.userStore.user.vehicles[jsonValue];
      if (vehicle != null) {
        return vehicle;
      } else {
        return VehicleModel()..plate = jsonValue;
      }
    } else if (jsonValue is VehicleModel) {
      return jsonValue;
    } else {
      return null;
    }
  }

  @override
  toJSON(VehicleModel object, [JsonProperty jsonProperty]) {
    return object.plate;
  }
}

class TransactionStateConverter implements ICustomConverter<TransactionState> {
  const TransactionStateConverter();

  @override
  TransactionState fromJSON(jsonValue, [JsonProperty jsonProperty]) {
    if (jsonValue is TransactionState) return jsonValue;
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

  @override
  toJSON(TransactionState object, [JsonProperty jsonProperty]) {
    return object.toString().split(".")[0];
  }
}
