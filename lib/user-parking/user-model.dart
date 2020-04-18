import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/vehicle.dart';

part "user-model.g.dart";

@jsonSerializable
class UserModel extends _UserModel with _$UserModel {
  ObservableMap<String, VehicleModel> vehicles =
      ObservableMap<String, VehicleModel>();

  ObservableList<PaymentMethod> paymentMethods =
      ObservableList<PaymentMethod>();
}

abstract class _UserModel with Store {
  String id;
  String name;
  String email;
  int phone;

  @observable
  ObservableMap<String, VehicleModel> vehicles;

  @observable
  ObservableList<PaymentMethod> paymentMethods;

  // _UserModel(
  //     {this.name,
  //     this.id,
  //     this.email,
  //     this.phone,
  //     this.paymentMethods,
  //     this.vehicles});
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
      ..phone = fields[3] as int
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
