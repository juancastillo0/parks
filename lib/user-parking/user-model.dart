import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/user-parking/vehicle.dart';

part "user-model.g.dart";

@JsonSerializable()
class UserModel extends _UserModel with _$UserModel {
  UserModel({name, id, email, phone, paymentMethods, vehicles})
      : super(
          name: name,
          id: id,
          email: email,
          phone: phone,
          paymentMethods: paymentMethods,
          vehicles: vehicles,
        );

  // ObservableMap<String, VehicleModel> vehicles =
  //     ObservableMap<String, VehicleModel>();

  // ObservableList<PaymentMethod> paymentMethods =
  //     ObservableList<PaymentMethod>();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

abstract class _UserModel with Store {
  String id;
  String name;
  String email;
  String phone;

  @observable
  @JsonKey(
      fromJson: _ObservableMapConverter.fromJson,
      toJson: _ObservableMapConverter.toJson)
  ObservableMap<String, VehicleModel> vehicles;

  @observable
  @JsonKey(
      fromJson: _ObservableListConverter.fromJson,
      toJson: _ObservableListConverter.toJson)
  ObservableList<PaymentMethod> paymentMethods;

  @computed
  @JsonKey(ignore: true)
  ObservableList<VehicleModel> get vehiclesList {
    return ObservableList.of(vehicles.values);
  }

  _UserModel(
      {this.name,
      this.id,
      this.email,
      this.phone,
      this.paymentMethods,
      this.vehicles});
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..email = fields[2] as String
      ..phone = fields[3] as String
      ..vehicles = ObservableMap.of(Map.from(fields[4]))
      ..paymentMethods =
          ObservableList.of((fields[5] as List)?.cast<PaymentMethod>());
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.vehicles)
      ..writeByte(5)
      ..write(obj.paymentMethods);
  }
}

class _ObservableListConverter {
  static ObservableList<PaymentMethod> fromJson(List<dynamic> json) =>
      ObservableList.of(json.map((e) => PaymentMethod.fromJson(e)));

  static List<Map<String, dynamic>> toJson(
          ObservableList<PaymentMethod> list) =>
      list.map((e) => e.toJson()).toList();
}

class _ObservableMapConverter {
  static ObservableMap<String, VehicleModel> fromJson(
          Map<String, dynamic> json) =>
      ObservableMap.of(
          json.map((k, e) => MapEntry(k, VehicleModel.fromJson(e))));

  static Map<String, Map<String, dynamic>> toJson(
          ObservableMap<String, VehicleModel> map) =>
      map.map((k, e) => MapEntry(k, e.toJson()));
}
