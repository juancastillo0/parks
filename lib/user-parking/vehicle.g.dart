// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleModelAdapter extends TypeAdapter<VehicleModel> {
  @override
  final typeId = 2;

  @override
  VehicleModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleModel()
      ..plate = fields[0] as String
      ..description = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, VehicleModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.plate)
      ..writeByte(1)
      ..write(obj.description);
  }
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VehicleModel on _VehicleModel, Store {
  final _$activeAtom = Atom(name: '_VehicleModel.active');

  @override
  bool get active {
    _$activeAtom.context.enforceReadPolicy(_$activeAtom);
    _$activeAtom.reportObserved();
    return super.active;
  }

  @override
  set active(bool value) {
    _$activeAtom.context.conditionallyRunInAction(() {
      super.active = value;
      _$activeAtom.reportChanged();
    }, _$activeAtom, name: '${_$activeAtom.name}_set');
  }

  final _$savedAtom = Atom(name: '_VehicleModel.saved');

  @override
  bool get saved {
    _$savedAtom.context.enforceReadPolicy(_$savedAtom);
    _$savedAtom.reportObserved();
    return super.saved;
  }

  @override
  set saved(bool value) {
    _$savedAtom.context.conditionallyRunInAction(() {
      super.saved = value;
      _$savedAtom.reportChanged();
    }, _$savedAtom, name: '${_$savedAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'active: ${active.toString()},saved: ${saved.toString()}';
    return '{$string}';
  }
}
