import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/user-parking/user-model.dart';

enum TransactionState { Completed, Active, Waiting }

@jsonSerializable
class TransactionModel {
  int id;
  DateTime timestamp;
  Place place;
  @JsonProperty(enumValues: TransactionState.values)
  TransactionState state;
  CarModel car;
  double cost;

  TransactionModel(
      {this.id, this.timestamp, this.place, this.state, this.car, this.cost});

  // factory TransactionModel.fromJson(Map<String, dynamic> json) =>
  //     _$TransactionModelFromJson(json);
  // Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

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
  }
}

