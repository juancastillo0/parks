// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionStateAdapter extends TypeAdapter<TransactionState> {
  @override
  final typeId = 1;

  @override
  TransactionState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionState.Completed;
      case 1:
        return TransactionState.Active;
      case 2:
        return TransactionState.Waiting;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionState obj) {
    switch (obj) {
      case TransactionState.Completed:
        writer.writeByte(0);
        break;
      case TransactionState.Active:
        writer.writeByte(1);
        break;
      case TransactionState.Waiting:
        writer.writeByte(2);
        break;
    }
  }
}

class TransactionPlaceModelAdapter extends TypeAdapter<TransactionPlaceModel> {
  @override
  final typeId = 6;

  @override
  TransactionPlaceModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionPlaceModel(
      name: fields[0] as String,
      address: fields[1] as String,
    )..id = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, TransactionPlaceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.id);
  }
}

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final typeId = 0;

  @override
  TransactionModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      endTimestamp: fields[2] as DateTime,
      place: fields[3] as TransactionPlaceModel,
      state: fields[4] as TransactionState,
      vehicle: fields[6] as VehicleModel,
      cost: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.endTimestamp)
      ..writeByte(3)
      ..write(obj.place)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.vehicle);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionPlaceModel _$TransactionPlaceModelFromJson(
    Map<String, dynamic> json) {
  return TransactionPlaceModel(
    name: json['name'] as String,
    address: json['address'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$TransactionPlaceModelToJson(
        TransactionPlaceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'id': instance.id,
    };

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel(
    id: json['id'] as String,
    timestamp: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    endTimestamp: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    place:
        _TransactionPlaceConverter.fromJSON(json['parking_lot_id'] as String),
    state: _TransactionStateConverter.fromJson(json['state'] as String),
    vehicle:
        _TransactionVehicleConverter.fromJson(json['vehicle_plate'] as String),
    cost: json['cost'] as int ?? 0,
  );
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.timestamp?.toIso8601String(),
      'endTime': instance.endTimestamp?.toIso8601String(),
      'parking_lot_id': _TransactionPlaceConverter.toJSON(instance.place),
      'state': _TransactionStateConverter.toJson(instance.state),
      'cost': instance.cost,
      'vehicle_plate': _TransactionVehicleConverter.toJson(instance.vehicle),
    };
