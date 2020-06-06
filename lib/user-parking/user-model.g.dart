// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    name: json['name'] as String,
    id: json['id'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    paymentMethods:
        _ObservableListConverter.fromJson(json['paymentMethods'] as List),
    vehicles: _ObservableMapConverter.fromJson(
        json['vehicles'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'vehicles': _ObservableMapConverter.toJson(instance.vehicles),
      'paymentMethods':
          _ObservableListConverter.toJson(instance.paymentMethods),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserModel on _UserModel, Store {
  Computed<ObservableList<VehicleModel>> _$vehiclesListComputed;

  @override
  ObservableList<VehicleModel> get vehiclesList => (_$vehiclesListComputed ??=
          Computed<ObservableList<VehicleModel>>(() => super.vehiclesList))
      .value;

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
        'vehicles: ${vehicles.toString()},paymentMethods: ${paymentMethods.toString()},vehiclesList: ${vehiclesList.toString()}';
    return '{$string}';
  }
}
