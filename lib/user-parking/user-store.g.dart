// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  UserModel get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$createCarAsyncAction = AsyncAction('createCar');

  @override
  Future<dynamic> createCar(CarModel car) {
    return _$createCarAsyncAction.run(() => super.createCar(car));
  }

  final _$deleteCarAsyncAction = AsyncAction('deleteCar');

  @override
  Future<dynamic> deleteCar(String plate) {
    return _$deleteCarAsyncAction.run(() => super.deleteCar(plate));
  }

  final _$createPaymentMethodAsyncAction = AsyncAction('createPaymentMethod');

  @override
  Future<dynamic> createPaymentMethod(PaymentMethod method) {
    return _$createPaymentMethodAsyncAction
        .run(() => super.createPaymentMethod(method));
  }

  final _$deletePaymentMethodAsyncAction = AsyncAction('deletePaymentMethod');

  @override
  Future<dynamic> deletePaymentMethod(PaymentMethod method) {
    return _$deletePaymentMethodAsyncAction
        .run(() => super.deletePaymentMethod(method));
  }

  @override
  String toString() {
    final string = 'user: ${user.toString()}';
    return '{$string}';
  }
}
