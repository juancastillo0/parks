// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionFilterStore on _TransactionFilterStore, Store {
  final _$minCostAtom = Atom(name: '_TransactionFilterStore.minCost');

  @override
  double get minCost {
    _$minCostAtom.context.enforceReadPolicy(_$minCostAtom);
    _$minCostAtom.reportObserved();
    return super.minCost;
  }

  @override
  set minCost(double value) {
    _$minCostAtom.context.conditionallyRunInAction(() {
      super.minCost = value;
      _$minCostAtom.reportChanged();
    }, _$minCostAtom, name: '${_$minCostAtom.name}_set');
  }

  final _$maxCostAtom = Atom(name: '_TransactionFilterStore.maxCost');

  @override
  double get maxCost {
    _$maxCostAtom.context.enforceReadPolicy(_$maxCostAtom);
    _$maxCostAtom.reportObserved();
    return super.maxCost;
  }

  @override
  set maxCost(double value) {
    _$maxCostAtom.context.conditionallyRunInAction(() {
      super.maxCost = value;
      _$maxCostAtom.reportChanged();
    }, _$maxCostAtom, name: '${_$maxCostAtom.name}_set');
  }

  final _$minTimeAtom = Atom(name: '_TransactionFilterStore.minTime');

  @override
  DateTime get minTime {
    _$minTimeAtom.context.enforceReadPolicy(_$minTimeAtom);
    _$minTimeAtom.reportObserved();
    return super.minTime;
  }

  @override
  set minTime(DateTime value) {
    _$minTimeAtom.context.conditionallyRunInAction(() {
      super.minTime = value;
      _$minTimeAtom.reportChanged();
    }, _$minTimeAtom, name: '${_$minTimeAtom.name}_set');
  }

  final _$maxTimeAtom = Atom(name: '_TransactionFilterStore.maxTime');

  @override
  DateTime get maxTime {
    _$maxTimeAtom.context.enforceReadPolicy(_$maxTimeAtom);
    _$maxTimeAtom.reportObserved();
    return super.maxTime;
  }

  @override
  set maxTime(DateTime value) {
    _$maxTimeAtom.context.conditionallyRunInAction(() {
      super.maxTime = value;
      _$maxTimeAtom.reportChanged();
    }, _$maxTimeAtom, name: '${_$maxTimeAtom.name}_set');
  }

  final _$placesAtom = Atom(name: '_TransactionFilterStore.places');

  @override
  ObservableSet<TransactionPlaceModel> get places {
    _$placesAtom.context.enforceReadPolicy(_$placesAtom);
    _$placesAtom.reportObserved();
    return super.places;
  }

  @override
  set places(ObservableSet<TransactionPlaceModel> value) {
    _$placesAtom.context.conditionallyRunInAction(() {
      super.places = value;
      _$placesAtom.reportChanged();
    }, _$placesAtom, name: '${_$placesAtom.name}_set');
  }

  final _$vehiclesAtom = Atom(name: '_TransactionFilterStore.vehicles');

  @override
  ObservableSet<VehicleModel> get vehicles {
    _$vehiclesAtom.context.enforceReadPolicy(_$vehiclesAtom);
    _$vehiclesAtom.reportObserved();
    return super.vehicles;
  }

  @override
  set vehicles(ObservableSet<VehicleModel> value) {
    _$vehiclesAtom.context.conditionallyRunInAction(() {
      super.vehicles = value;
      _$vehiclesAtom.reportChanged();
    }, _$vehiclesAtom, name: '${_$vehiclesAtom.name}_set');
  }

  final _$_TransactionFilterStoreActionController =
      ActionController(name: '_TransactionFilterStore');

  @override
  dynamic setCostInteval(material.RangeValues range) {
    final _$actionInfo =
        _$_TransactionFilterStoreActionController.startAction();
    try {
      return super.setCostInteval(range);
    } finally {
      _$_TransactionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMinCost(double cost) {
    final _$actionInfo =
        _$_TransactionFilterStoreActionController.startAction();
    try {
      return super.setMinCost(cost);
    } finally {
      _$_TransactionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMaxCost(double cost) {
    final _$actionInfo =
        _$_TransactionFilterStoreActionController.startAction();
    try {
      return super.setMaxCost(cost);
    } finally {
      _$_TransactionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMinTime(DateTime time) {
    final _$actionInfo =
        _$_TransactionFilterStoreActionController.startAction();
    try {
      return super.setMinTime(time);
    } finally {
      _$_TransactionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMaxTime(DateTime time) {
    final _$actionInfo =
        _$_TransactionFilterStoreActionController.startAction();
    try {
      return super.setMaxTime(time);
    } finally {
      _$_TransactionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo =
        _$_TransactionFilterStoreActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$_TransactionFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'minCost: ${minCost.toString()},maxCost: ${maxCost.toString()},minTime: ${minTime.toString()},maxTime: ${maxTime.toString()},places: ${places.toString()},vehicles: ${vehicles.toString()}';
    return '{$string}';
  }
}

mixin _$TransactionStore on _TransactionStore, Store {
  Computed<Iterable<TransactionModel>> _$filteredTransactionsComputed;

  @override
  Iterable<TransactionModel> get filteredTransactions =>
      (_$filteredTransactionsComputed ??= Computed<Iterable<TransactionModel>>(
              () => super.filteredTransactions))
          .value;
  Computed<Set<VehicleModel>> _$vehiclesInTransactionsComputed;

  @override
  Set<VehicleModel> get vehiclesInTransactions =>
      (_$vehiclesInTransactionsComputed ??=
              Computed<Set<VehicleModel>>(() => super.vehiclesInTransactions))
          .value;
  Computed<Set<TransactionPlaceModel>> _$placesInTransactionsComputed;

  @override
  Set<TransactionPlaceModel> get placesInTransactions =>
      (_$placesInTransactionsComputed ??= Computed<Set<TransactionPlaceModel>>(
              () => super.placesInTransactions))
          .value;
  Computed<Interval<double>> _$costIntervalComputed;

  @override
  Interval<double> get costInterval => (_$costIntervalComputed ??=
          Computed<Interval<double>>(() => super.costInterval))
      .value;
  Computed<Interval<DateTime>> _$timeIntervalComputed;

  @override
  Interval<DateTime> get timeInterval => (_$timeIntervalComputed ??=
          Computed<Interval<DateTime>>(() => super.timeInterval))
      .value;

  final _$loadingAtom = Atom(name: '_TransactionStore.loading');

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

  final _$transactionsAtom = Atom(name: '_TransactionStore.transactions');

  @override
  ObservableMap<String, TransactionModel> get transactions {
    _$transactionsAtom.context.enforceReadPolicy(_$transactionsAtom);
    _$transactionsAtom.reportObserved();
    return super.transactions;
  }

  @override
  set transactions(ObservableMap<String, TransactionModel> value) {
    _$transactionsAtom.context.conditionallyRunInAction(() {
      super.transactions = value;
      _$transactionsAtom.reportChanged();
    }, _$transactionsAtom, name: '${_$transactionsAtom.name}_set');
  }

  final _$filterAtom = Atom(name: '_TransactionStore.filter');

  @override
  TransactionFilterStore get filter {
    _$filterAtom.context.enforceReadPolicy(_$filterAtom);
    _$filterAtom.reportObserved();
    return super.filter;
  }

  @override
  set filter(TransactionFilterStore value) {
    _$filterAtom.context.conditionallyRunInAction(() {
      super.filter = value;
      _$filterAtom.reportChanged();
    }, _$filterAtom, name: '${_$filterAtom.name}_set');
  }

  final _$selectedTransactionAtom =
      Atom(name: '_TransactionStore.selectedTransaction');

  @override
  TransactionModel get selectedTransaction {
    _$selectedTransactionAtom.context
        .enforceReadPolicy(_$selectedTransactionAtom);
    _$selectedTransactionAtom.reportObserved();
    return super.selectedTransaction;
  }

  @override
  set selectedTransaction(TransactionModel value) {
    _$selectedTransactionAtom.context.conditionallyRunInAction(() {
      super.selectedTransaction = value;
      _$selectedTransactionAtom.reportChanged();
    }, _$selectedTransactionAtom,
        name: '${_$selectedTransactionAtom.name}_set');
  }

  final _$fetchTransactionsAsyncAction = AsyncAction('fetchTransactions');

  @override
  Future fetchTransactions() {
    return _$fetchTransactionsAsyncAction.run(() => super.fetchTransactions());
  }

  final _$_TransactionStoreActionController =
      ActionController(name: '_TransactionStore');

  @override
  dynamic setSelectedTransaction(TransactionModel transaction) {
    final _$actionInfo = _$_TransactionStoreActionController.startAction();
    try {
      return super.setSelectedTransaction(transaction);
    } finally {
      _$_TransactionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetFilter() {
    final _$actionInfo = _$_TransactionStoreActionController.startAction();
    try {
      return super.resetFilter();
    } finally {
      _$_TransactionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loading: ${loading.toString()},transactions: ${transactions.toString()},filter: ${filter.toString()},selectedTransaction: ${selectedTransaction.toString()},filteredTransactions: ${filteredTransactions.toString()},vehiclesInTransactions: ${vehiclesInTransactions.toString()},placesInTransactions: ${placesInTransactions.toString()},costInterval: ${costInterval.toString()},timeInterval: ${timeInterval.toString()}';
    return '{$string}';
  }
}
