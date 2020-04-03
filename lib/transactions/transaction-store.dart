import 'package:flutter/material.dart' as material;
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'transaction-store.g.dart';

class TransactionFilterStore extends _TransactionFilterStore
    with _$TransactionFilterStore {}

abstract class _TransactionFilterStore with Store {
  bool valid(TransactionModel t) {
    return ((minCost == null || t.cost >= minCost) &&
        (maxCost == null || t.cost <= maxCost) &&
        (places.isEmpty || places.contains(t.place)) &&
        (vehicles.isEmpty || vehicles.contains(t.vehicle)));
  }

  @observable
  double minCost;
  @observable
  double maxCost;

  @action
  setCostInteval(material.RangeValues range) {
    minCost = range.start;
    maxCost = range.end;
  }

  @action
  setMinCost(double cost) {
    if (cost == null || cost.compareTo(maxCost) <= 0) {
      minCost = cost;
    } else {
      final temp = maxCost;
      maxCost = cost;
      minCost = temp;
    }
  }

  @action
  setMaxCost(double cost) {
    if (cost == null || cost.compareTo(minCost) >= 0) {
      maxCost = cost;
    } else {
      final temp = minCost;
      minCost = cost;
      maxCost = temp;
    }
  }

  @observable
  DateTime minTime;
  @observable
  DateTime maxTime;
  @action
  setMinTime(DateTime time) {
    if (time == null || time.compareTo(maxTime) <= 0) {
      minTime = time;
    } else {
      final temp = maxTime;
      maxTime = time;
      minTime = temp;
    }
  }

  @action
  setMaxTime(DateTime time) {
    if (time == null || time.compareTo(minTime) >= 0) {
      maxTime = time;
    } else {
      final temp = minTime;
      minTime = time;
      maxTime = temp;
    }
  }

  @observable
  ObservableSet<TransactionPlaceModel> places = ObservableSet();

  @observable
  ObservableSet<VehicleModel> vehicles = ObservableSet();

  @action
  reset() {
    places.clear();
    vehicles.clear();
    minCost = null;
    maxCost = null;
    minTime = null;
    maxTime = null;
  }
}

class TransactionStore extends _TransactionStore with _$TransactionStore {
  TransactionStore({List<TransactionModel> transactions}) : super();
}

abstract class _TransactionStore with Store {
  _TransactionStore() {
    final box = getTransactionsBox();
    transactions = ObservableList.of(box.values.toList());
    selectedTransaction = transactions.first;

    filter = TransactionFilterStore();
  }

  @observable
  ObservableList<TransactionModel> transactions;
  @observable
  TransactionFilterStore filter;
  @observable
  TransactionModel selectedTransaction;

  @action
  setSelectedTransaction(TransactionModel transaction) {
    selectedTransaction = transaction;
  }

  @action
  resetFilter() {
    filter = TransactionFilterStore();
  }

  @computed
  Iterable<TransactionModel> get filteredTransactions {
    return transactions.where(filter.valid);
  }

  @computed
  Set<VehicleModel> get vehiclesInTransactions {
    return transactions.fold(
      Set(),
      (Set<VehicleModel> p, e) {
        p.add(e.vehicle);
        return p;
      },
    );
  }

  @computed
  Set<TransactionPlaceModel> get placesInTransactions {
    return transactions.fold(
      Set(),
      (Set p, e) {
        p.add(e.place);
        return p;
      },
    );
  }

  @computed
  Interval<double> get costInterval {
    final interval = Interval(double.infinity, double.negativeInfinity);
    return interval.fromIter(transactions.map((t) => t.cost));
  }

  @computed
  Interval<DateTime> get timeInterval {
    final interval =
        Interval(DateTime.now(), DateTime.fromMillisecondsSinceEpoch(0));
    return interval.fromIter(transactions.map((t) => t.timestamp));
  }
}
