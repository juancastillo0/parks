// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RootStore on _RootStore, Store {
  final _$authStoreAtom = Atom(name: '_RootStore.authStore');

  @override
  AuthStore get authStore {
    _$authStoreAtom.context.enforceReadPolicy(_$authStoreAtom);
    _$authStoreAtom.reportObserved();
    return super.authStore;
  }

  @override
  set authStore(AuthStore value) {
    _$authStoreAtom.context.conditionallyRunInAction(() {
      super.authStore = value;
      _$authStoreAtom.reportChanged();
    }, _$authStoreAtom, name: '${_$authStoreAtom.name}_set');
  }

  final _$userStoreAtom = Atom(name: '_RootStore.userStore');

  @override
  UserStore get userStore {
    _$userStoreAtom.context.enforceReadPolicy(_$userStoreAtom);
    _$userStoreAtom.reportObserved();
    return super.userStore;
  }

  @override
  set userStore(UserStore value) {
    _$userStoreAtom.context.conditionallyRunInAction(() {
      super.userStore = value;
      _$userStoreAtom.reportChanged();
    }, _$userStoreAtom, name: '${_$userStoreAtom.name}_set');
  }

  final _$locationServiceAtom = Atom(name: '_RootStore.locationService');

  @override
  LocationService get locationService {
    _$locationServiceAtom.context.enforceReadPolicy(_$locationServiceAtom);
    _$locationServiceAtom.reportObserved();
    return super.locationService;
  }

  @override
  set locationService(LocationService value) {
    _$locationServiceAtom.context.conditionallyRunInAction(() {
      super.locationService = value;
      _$locationServiceAtom.reportChanged();
    }, _$locationServiceAtom, name: '${_$locationServiceAtom.name}_set');
  }

  final _$notificationServiceAtom =
      Atom(name: '_RootStore.notificationService');

  @override
  NotificationService get notificationService {
    _$notificationServiceAtom.context
        .enforceReadPolicy(_$notificationServiceAtom);
    _$notificationServiceAtom.reportObserved();
    return super.notificationService;
  }

  @override
  set notificationService(NotificationService value) {
    _$notificationServiceAtom.context.conditionallyRunInAction(() {
      super.notificationService = value;
      _$notificationServiceAtom.reportChanged();
    }, _$notificationServiceAtom,
        name: '${_$notificationServiceAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'authStore: ${authStore.toString()},userStore: ${userStore.toString()},locationService: ${locationService.toString()},notificationService: ${notificationService.toString()}';
    return '{$string}';
  }
}