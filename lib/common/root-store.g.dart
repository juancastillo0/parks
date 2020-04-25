// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RootStore on _RootStore, Store {
  Computed<ObservableList<UserRequest>> _$pendingRequestsComputed;

  @override
  ObservableList<UserRequest> get pendingRequests =>
      (_$pendingRequestsComputed ??= Computed<ObservableList<UserRequest>>(
              () => super.pendingRequests))
          .value;

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

  final _$placeStoreAtom = Atom(name: '_RootStore.placeStore');

  @override
  PlaceStore get placeStore {
    _$placeStoreAtom.context.enforceReadPolicy(_$placeStoreAtom);
    _$placeStoreAtom.reportObserved();
    return super.placeStore;
  }

  @override
  set placeStore(PlaceStore value) {
    _$placeStoreAtom.context.conditionallyRunInAction(() {
      super.placeStore = value;
      _$placeStoreAtom.reportChanged();
    }, _$placeStoreAtom, name: '${_$placeStoreAtom.name}_set');
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

  final _$transactionStoreAtom = Atom(name: '_RootStore.transactionStore');

  @override
  TransactionStore get transactionStore {
    _$transactionStoreAtom.context.enforceReadPolicy(_$transactionStoreAtom);
    _$transactionStoreAtom.reportObserved();
    return super.transactionStore;
  }

  @override
  set transactionStore(TransactionStore value) {
    _$transactionStoreAtom.context.conditionallyRunInAction(() {
      super.transactionStore = value;
      _$transactionStoreAtom.reportChanged();
    }, _$transactionStoreAtom, name: '${_$transactionStoreAtom.name}_set');
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

  final _$snackbarAtom = Atom(name: '_RootStore.snackbar');

  @override
  SnackBar get snackbar {
    _$snackbarAtom.context.enforceReadPolicy(_$snackbarAtom);
    _$snackbarAtom.reportObserved();
    return super.snackbar;
  }

  @override
  set snackbar(SnackBar value) {
    _$snackbarAtom.context.conditionallyRunInAction(() {
      super.snackbar = value;
      _$snackbarAtom.reportChanged();
    }, _$snackbarAtom, name: '${_$snackbarAtom.name}_set');
  }

  final _$snackbarControllerAtom = Atom(name: '_RootStore.snackbarController');

  @override
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      get snackbarController {
    _$snackbarControllerAtom.context
        .enforceReadPolicy(_$snackbarControllerAtom);
    _$snackbarControllerAtom.reportObserved();
    return super.snackbarController;
  }

  @override
  set snackbarController(
      ScaffoldFeatureController<SnackBar, SnackBarClosedReason> value) {
    _$snackbarControllerAtom.context.conditionallyRunInAction(() {
      super.snackbarController = value;
      _$snackbarControllerAtom.reportChanged();
    }, _$snackbarControllerAtom, name: '${_$snackbarControllerAtom.name}_set');
  }

  final _$errorsAtom = Atom(name: '_RootStore.errors');

  @override
  ObservableList<String> get errors {
    _$errorsAtom.context.enforceReadPolicy(_$errorsAtom);
    _$errorsAtom.reportObserved();
    return super.errors;
  }

  @override
  set errors(ObservableList<String> value) {
    _$errorsAtom.context.conditionallyRunInAction(() {
      super.errors = value;
      _$errorsAtom.reportChanged();
    }, _$errorsAtom, name: '${_$errorsAtom.name}_set');
  }

  final _$infoListAtom = Atom(name: '_RootStore.infoList');

  @override
  ObservableList<SnackBar> get infoList {
    _$infoListAtom.context.enforceReadPolicy(_$infoListAtom);
    _$infoListAtom.reportObserved();
    return super.infoList;
  }

  @override
  set infoList(ObservableList<SnackBar> value) {
    _$infoListAtom.context.conditionallyRunInAction(() {
      super.infoList = value;
      _$infoListAtom.reportChanged();
    }, _$infoListAtom, name: '${_$infoListAtom.name}_set');
  }

  final _$_RootStoreActionController = ActionController(name: '_RootStore');

  @override
  dynamic setSnackbarController(
      ScaffoldFeatureController<SnackBar, SnackBarClosedReason> c) {
    final _$actionInfo = _$_RootStoreActionController.startAction();
    try {
      return super.setSnackbarController(c);
    } finally {
      _$_RootStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showInfo(SnackBar info) {
    final _$actionInfo = _$_RootStoreActionController.startAction();
    try {
      return super.showInfo(info);
    } finally {
      _$_RootStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showError(String error) {
    final _$actionInfo = _$_RootStoreActionController.startAction();
    try {
      return super.showError(error);
    } finally {
      _$_RootStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'authStore: ${authStore.toString()},placeStore: ${placeStore.toString()},userStore: ${userStore.toString()},transactionStore: ${transactionStore.toString()},locationService: ${locationService.toString()},notificationService: ${notificationService.toString()},snackbar: ${snackbar.toString()},snackbarController: ${snackbarController.toString()},errors: ${errors.toString()},infoList: ${infoList.toString()},pendingRequests: ${pendingRequests.toString()}';
    return '{$string}';
  }
}
