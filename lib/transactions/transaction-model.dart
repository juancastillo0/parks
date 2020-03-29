import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/user-parking/vehicle.dart';

enum TransactionState { Completed, Active, Waiting }

@jsonSerializable
class TransactionModel {
  int id;
  DateTime timestamp;
  DateTime endTimestamp;
  Place place;
  @JsonProperty(enumValues: TransactionState.values)
  TransactionState state;
  VehicleModel vehicle;
  double cost;

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
