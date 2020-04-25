// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<ObservableList<UserRequest>> _$requestsComputed;

  @override
  ObservableList<UserRequest> get requests => (_$requestsComputed ??=
          Computed<ObservableList<UserRequest>>(() => super.requests))
      .value;
  Computed<bool> _$safeToPersistComputed;

  @override
  bool get safeToPersist =>
      (_$safeToPersistComputed ??= Computed<bool>(() => super.safeToPersist))
          .value;

  final _$persistenceStateAtom = Atom(name: '_UserStore.persistenceState');

  @override
  PersistenceState get persistenceState {
    _$persistenceStateAtom.context.enforceReadPolicy(_$persistenceStateAtom);
    _$persistenceStateAtom.reportObserved();
    return super.persistenceState;
  }

  @override
  set persistenceState(PersistenceState value) {
    _$persistenceStateAtom.context.conditionallyRunInAction(() {
      super.persistenceState = value;
      _$persistenceStateAtom.reportChanged();
    }, _$persistenceStateAtom, name: '${_$persistenceStateAtom.name}_set');
  }

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

  final _$loadingAtom = Atom(name: '_UserStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$requestCacheAtom = Atom(name: '_UserStore.requestCache');

  @override
  ObservableList<dynamic> get requestCache {
    _$requestCacheAtom.context.enforceReadPolicy(_$requestCacheAtom);
    _$requestCacheAtom.reportObserved();
    return super.requestCache;
  }

  @override
  set requestCache(ObservableList<dynamic> value) {
    _$requestCacheAtom.context.conditionallyRunInAction(() {
      super.requestCache = value;
      _$requestCacheAtom.reportChanged();
    }, _$requestCacheAtom, name: '${_$requestCacheAtom.name}_set');
  }

  final _$fetchUserAsyncAction = AsyncAction('fetchUser');

  @override
  Future<dynamic> fetchUser() {
    return _$fetchUserAsyncAction.run(() => super.fetchUser());
  }

  final _$createVehicleAsyncAction = AsyncAction('createVehicle');

  @override
  Future<String> createVehicle(VehicleModel vehicle) {
    return _$createVehicleAsyncAction.run(() => super.createVehicle(vehicle));
  }

  final _$toggleVehicleStateAsyncAction = AsyncAction('toggleVehicleState');

  @override
  Future<dynamic> toggleVehicleState(VehicleModel vehicle) {
    return _$toggleVehicleStateAsyncAction
        .run(() => super.toggleVehicleState(vehicle));
  }

  final _$deleteVehicleAsyncAction = AsyncAction('deleteVehicle');

  @override
  Future<dynamic> deleteVehicle(String plate) {
    return _$deleteVehicleAsyncAction.run(() => super.deleteVehicle(plate));
  }

  final _$createPaymentMethodAsyncAction = AsyncAction('createPaymentMethod');

  @override
  Future<String> createPaymentMethod(PaymentMethod method) {
    return _$createPaymentMethodAsyncAction
        .run(() => super.createPaymentMethod(method));
  }

  final _$deletePaymentMethodAsyncAction = AsyncAction('deletePaymentMethod');

  @override
  Future<dynamic> deletePaymentMethod(PaymentMethod method) {
    return _$deletePaymentMethodAsyncAction
        .run(() => super.deletePaymentMethod(method));
  }

  final _$_persistUserAsyncAction = AsyncAction('_persistUser');

  @override
  Future<dynamic> _persistUser(UserModel _user) {
    return _$_persistUserAsyncAction.run(() => super._persistUser(_user));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void processCachedResponse(UserRequest req) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.processCachedResponse(req);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _createVehicle(VehicleModel vehicle) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super._createVehicle(vehicle);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _toggleVehicleState(VehicleModel toggled, bool saved) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super._toggleVehicleState(toggled, saved);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _deleteVehicle(String plate) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super._deleteVehicle(plate);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _createPaymentMethod(PaymentMethod method) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super._createPaymentMethod(method);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _deletePaymentMethod(String id) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super._deletePaymentMethod(id);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'persistenceState: ${persistenceState.toString()},user: ${user.toString()},loading: ${loading.toString()},requestCache: ${requestCache.toString()},requests: ${requests.toString()},safeToPersist: ${safeToPersist.toString()}';
    return '{$string}';
  }
}
