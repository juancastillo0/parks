// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserModel on _UserModel, Store {
  final _$carsAtom = Atom(name: '_UserModel.cars');

  @override
  ObservableList<CarModel> get cars {
    _$carsAtom.context.enforceReadPolicy(_$carsAtom);
    _$carsAtom.reportObserved();
    return super.cars;
  }

  @override
  set cars(ObservableList<CarModel> value) {
    _$carsAtom.context.conditionallyRunInAction(() {
      super.cars = value;
      _$carsAtom.reportChanged();
    }, _$carsAtom, name: '${_$carsAtom.name}_set');
  }

  final _$transactionsAtom = Atom(name: '_UserModel.transactions');

  @override
  ObservableList<TransactionModel> get transactions {
    _$transactionsAtom.context.enforceReadPolicy(_$transactionsAtom);
    _$transactionsAtom.reportObserved();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<TransactionModel> value) {
    _$transactionsAtom.context.conditionallyRunInAction(() {
      super.transactions = value;
      _$transactionsAtom.reportChanged();
    }, _$transactionsAtom, name: '${_$transactionsAtom.name}_set');
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
        'cars: ${cars.toString()},transactions: ${transactions.toString()},paymentMethods: ${paymentMethods.toString()}';
    return '{$string}';
  }
}
