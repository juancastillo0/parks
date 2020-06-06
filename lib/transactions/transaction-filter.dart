import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/fields.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/vehicle.dart';
import 'package:styled_widget/styled_widget.dart';

class TransactionFilter extends HookWidget {
  const TransactionFilter({Key key}) : super(key: key);
  @override
  Widget build(ctx) {
    final transactionStore = useTransactionStore(ctx);
    final open = useState(false);
    final openPlacesDialog = useMemoized(
        () => multiSelectDialog<TransactionPlaceModel>(
              ctx,
              items: transactionStore.placesInTransactions,
              selected: transactionStore.filter.places,
              subtitle: (e) => Text(e.address),
              title: (e) => Text(e.name),
            ),
        [transactionStore, transactionStore.filter]);
    final openVehiclesDialog = useMemoized(
        () => multiSelectDialog<VehicleModel>(
              ctx,
              items: transactionStore.vehiclesInTransactions,
              selected: transactionStore.filter.vehicles,
              subtitle: (e) => Text(e.description),
              title: (e) => Text(e.plate),
            ),
        [transactionStore, transactionStore.filter]);
    final toggleOpen =
        useMemoized(() => () => open.value = !open.value, [open.value]);

    final titleStyle = Theme.of(ctx).textTheme.subtitle1;

    if (!open.value) {
      return Row(
        children: [
          FlatButton.icon(
            onPressed: toggleOpen,
            icon: const Icon(Icons.tune),
            label: const Text("Filter"),
          ),
          const SizedBox(width: 3),
          Wrap(
            spacing: 4,
            children: transactionStore.filter.places
                .map((e) => Chip(
                      label: Text(e.name),
                      onDeleted: () => transactionStore.filter.places.remove(e),
                    ))
                .followedBy(transactionStore.filter.vehicles.map((e) => Chip(
                      label: Text(e.plate),
                      onDeleted: () =>
                          transactionStore.filter.vehicles.remove(e),
                    )))
                .toList(),
          ).scrollable(scrollDirection: Axis.horizontal).flexible(),
        ],
      ).constrained(height: 50);
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 35),
      children: [
        const SizedBox(height: 10),
        Observer(
          builder: (ctx) => MultiSelect<TransactionPlaceModel>(
            idFn: (e) => e.name,
            items: transactionStore.placesInTransactions,
            openDialog: openPlacesDialog,
            selected: transactionStore.filter.places,
            title: Row(children: [
              const Icon(Icons.place, size: 24),
              Text("Places", style: titleStyle).padding(horizontal: 8),
            ]),
          ),
        ),
        const SizedBox(height: 10),
        Observer(
          builder: (_) => MultiSelect<VehicleModel>(
            idFn: (e) => e.plate,
            items: transactionStore.vehiclesInTransactions,
            openDialog: openVehiclesDialog,
            selected: transactionStore.filter.vehicles,
            title: Row(children: [
              const Icon(Icons.directions_car, size: 24),
              Text("Vehicles", style: titleStyle).padding(horizontal: 8),
            ]),
          ),
        ),
        const SizedBox(height: 15),
        Observer(
          builder: (_) {
            final interval = transactionStore.costInterval;
            final minCost = transactionStore.filter.minCost ?? interval.min;
            final maxCost = transactionStore.filter.maxCost ?? interval.max;
            if (transactionStore.transactions.isEmpty || maxCost <= minCost) {
              return Container(width: 0, height: 0);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  const Icon(Icons.attach_money, size: 24),
                  Text("Cost", style: titleStyle).padding(horizontal: 8),
                ]),
                RangeSlider(
                  values: RangeValues(minCost, maxCost),
                  min: interval.min,
                  max: interval.max,
                  onChanged: transactionStore.filter.setCostInteval,
                  labels: RangeLabels(
                    currencyString(minCost.toInt()),
                    currencyString(maxCost.toInt()),
                  ),
                  divisions: 100,
                ).padding(horizontal: 10, top: 5),
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton.icon(
              onPressed: transactionStore.resetFilter,
              icon: const Icon(Icons.settings_backup_restore),
              label: const Text("Reset"),
            ),
            FlatButton.icon(
              onPressed: toggleOpen,
              icon: const Icon(Icons.close),
              label: const Text("Close"),
            ),
          ],
        ).padding(top: 8, bottom: 20),
      ],
    ).backgroundColor(Colors.white).elevation(3).padding(bottom: 15);
  }
}
