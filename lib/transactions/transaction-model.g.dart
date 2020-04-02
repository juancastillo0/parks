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
      id: fields[0] as int,
      timestamp: fields[1] as DateTime,
      endTimestamp: fields[2] as DateTime,
      state: fields[4] as TransactionState,
      vehicle: fields[6] as VehicleModel,
      cost: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.endTimestamp)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.vehicle);
  }
}
