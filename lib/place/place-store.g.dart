// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place-store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final typeId = 8;

  @override
  PlaceModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      latitud: fields[2] as double,
      longitud: fields[3] as double,
      description: fields[4] as String,
      rating: fields[6] as double,
      address: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.latitud)
      ..writeByte(3)
      ..write(obj.longitud)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.rating);
  }
}
