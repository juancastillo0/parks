// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentMethodTypeAdapter extends TypeAdapter<PaymentMethodType> {
  @override
  final typeId = 5;

  @override
  PaymentMethodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentMethodType.Credit;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentMethodType obj) {
    switch (obj) {
      case PaymentMethodType.Credit:
        writer.writeByte(0);
        break;
    }
  }
}

class PaymentMethodAdapter extends TypeAdapter<PaymentMethod> {
  @override
  final typeId = 4;

  @override
  PaymentMethod read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentMethod(
      name: fields[0] as String,
      type: fields[1] as PaymentMethodType,
      lastDigits: fields[2] as String,
      provider: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentMethod obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.lastDigits)
      ..writeByte(3)
      ..write(obj.provider);
  }
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserModel on _UserModel, Store {
  final _$vehiclesAtom = Atom(name: '_UserModel.vehicles');

  @override
  ObservableMap<String, VehicleModel> get vehicles {
    _$vehiclesAtom.context.enforceReadPolicy(_$vehiclesAtom);
    _$vehiclesAtom.reportObserved();
    return super.vehicles;
  }

  @override
  set vehicles(ObservableMap<String, VehicleModel> value) {
    _$vehiclesAtom.context.conditionallyRunInAction(() {
      super.vehicles = value;
      _$vehiclesAtom.reportChanged();
    }, _$vehiclesAtom, name: '${_$vehiclesAtom.name}_set');
  }

  final _$paymentMethodsAtom = Atom(name: '_UserModel.paymentMethods');

  @override
  ObservableList<PaymentMethod> get paymentMethods {
    _$paymentMethodsAtom.context.enforceReadPolicy(_$paymentMethodsAtom);
    _$paymentMethodsAtom.reportObserved();
    return super.paymentMethods;
  }

  @override
  set paymentMethods(ObservableList<PaymentMethod> value) {
    _$paymentMethodsAtom.context.conditionallyRunInAction(() {
      super.paymentMethods = value;
      _$paymentMethodsAtom.reportChanged();
    }, _$paymentMethodsAtom, name: '${_$paymentMethodsAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'vehicles: ${vehicles.toString()},paymentMethods: ${paymentMethods.toString()}';
    return '{$string}';
  }
}
