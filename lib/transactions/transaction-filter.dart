import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';

class TransactionFilter extends HookWidget {
  const TransactionFilter({Key key}) : super(key: key);
  @override
  Widget build(ctx) {
    final transactionStore = useTransactionStore(ctx);
    final filter = transactionStore.filter;
    return Form(
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Observer(
                builder: (_) => DropdownButton(
                  items: transactionStore.placesInTransactions
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (p) => transactionStore.filter.addPlace(p),
                  icon: Icon(Icons.place),
                ),
              ),
              Observer(
                builder: (_) => DropdownButton(
                  items: transactionStore.vehiclesInTransactions
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.plate),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (p) => transactionStore.filter.addVehicle(p),
                  icon: Icon(Icons.directions_car),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(
                builder: (_) {
                  final interval = transactionStore.costInterval;
                  final minCost = filter.minCost ?? interval.min;
                  final maxCost = filter.maxCost ?? interval.max;
                  return RangeSlider(
                    values: RangeValues(minCost, maxCost),
                    min: interval.min,
                    max: interval.max,
                    divisions: 10,
                    onChanged: (v) => filter.setCostInteval(v),
                    labels: RangeLabels(
                      currencyString(minCost),
                      currencyString(maxCost),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
