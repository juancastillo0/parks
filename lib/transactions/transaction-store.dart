import 'package:flutter/material.dart' as material;
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/transactions/transaction-back.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/vehicle.dart';

part 'transaction-store.g.dart';

class TransactionFilterStore extends _TransactionFilterStore
    with _$TransactionFilterStore {}

abstract class _TransactionFilterStore with Store {
  bool valid(TransactionModel t) {
    return (minCost == null || t.cost >= minCost) &&
        (maxCost == null || t.cost <= maxCost) &&
        (places.isEmpty || places.contains(t.place)) &&
        (vehicles.isEmpty || vehicles.contains(t.vehicle));
  }

  @observable
  double minCost;
  @observable
  double maxCost;

  @action
  void setCostInteval(material.RangeValues range) {
    minCost = range.start;
    maxCost = range.end;
  }

  @action
  void setMinCost(double cost) {
    if (cost == null || cost.compareTo(maxCost) <= 0) {
      minCost = cost;
    } else {
      final temp = maxCost;
      maxCost = cost;
      minCost = temp;
    }
  }

  @action
  void setMaxCost(double cost) {
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
  void setMinTime(DateTime time) {
    if (time == null || time.compareTo(maxTime) <= 0) {
      minTime = time;
    } else {
      final temp = maxTime;
      maxTime = time;
      minTime = temp;
    }
  }

  @action
  void setMaxTime(DateTime time) {
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
  void reset() {
    places.clear();
    vehicles.clear();
    minCost = null;
    maxCost = null;
    minTime = null;
    maxTime = null;
  }
}

class TransactionStore extends _TransactionStore with _$TransactionStore {
  TransactionStore(RootStore root) : super(root);
}

abstract class _TransactionStore with Store {
  _TransactionStore(this._root) {
    _box = getTransactionsBox();
    transactions = ObservableMap.of(
      Map.fromEntries(_box.values.map((e) => MapEntry(e.id, e))),
    );
    selectedTransaction =
        transactions.isNotEmpty ? transactions.values.first : null;
    filter = TransactionFilterStore();
  }

  final RootStore _root;

  final _back = TransactionBack();
  Box<TransactionModel> _box;

  @observable
  bool loading = false;
  @observable
  ObservableMap<String, TransactionModel> transactions;
  @observable
  TransactionFilterStore filter;
  @observable
  TransactionModel selectedTransaction;

  @action
  Future fetchTransactions() async {
    loading = true;
    if (_root.userStore.user == null) await _root.userStore.fetchUser();
    if (_root.placeStore.places == null) await _root.placeStore.fetchPlaces();

    final resp = await _back.transactions();
    final value = resp.okOrNull();
    if (value != null) {
      final map = Map.fromEntries(value.map((e) => MapEntry(e.id, e)));
      // for (final vv in map.values) {
      //   print("map ${vv.state}");
      // }
      transactions.addAll(map);
      transactions = ObservableMap.of(
        Map.fromEntries(transactions.values.map((e) => MapEntry(e.id, e))),
      );
      if (transactions.isNotEmpty && selectedTransaction == null) {
        selectedTransaction = transactions.values.first;
      }

      await _box.putAll(map);
    } else {
      print(value);
    }
    loading = false;
  }

  @action
  Future onTransactionMessage(TransactionModel t) async {
    transactions.remove(t.id);
    transactions.update(t.id, (_) => t, ifAbsent: () => t);
    transactions[t.id] = t;
    await _box.put(t.id, t);
    selectedTransaction = t;
    print(t.state);
  }

  Future<String> updateTransactionState(String id, bool accept) async {
    final resp = await _back.updateTransactionState(id, accept);
    return resp.okOrError(
      (accepted) async {
        if (accepted) {
          final value = transactions.update(
            id,
            (value) => value..state = TransactionState.Active,
          );
          await _box.put(id, value);
          if (selectedTransaction.id == id) selectedTransaction = value;
        } else {
          transactions.remove(id);
          await _box.delete(id);
          if (selectedTransaction.id == id) {
            selectedTransaction =
                transactions.isNotEmpty ? transactions.values.first : null;
          }
        }
        return null;
      },
    );
  }

  @action
  void resetFilter() => filter = TransactionFilterStore();

  @computed
  ObservableList<TransactionModel> get filteredTransactions =>
      ObservableList.of(transactions.values.where(filter.valid));

  @computed
  Set<VehicleModel> get vehiclesInTransactions =>
      transactions.values.map((e) => e.vehicle).toSet();

  @computed
  Set<TransactionPlaceModel> get placesInTransactions =>
      transactions.values.map((e) => e.place).toSet();

  @computed
  Interval<double> get costInterval {
    final interval = Interval(double.infinity, double.negativeInfinity);
    return interval.fromIter(transactions.values.map((t) => t.cost.toDouble()));
  }

  @computed
  Interval<DateTime> get timeInterval {
    final interval = Interval(
      DateTime.now(),
      DateTime.fromMillisecondsSinceEpoch(0),
    );
    return interval.fromIter(transactions.values.map((t) => t.timestamp));
  }
}
