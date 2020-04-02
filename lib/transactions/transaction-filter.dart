import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/user-parking/vehicle.dart';
import 'package:styled_widget/styled_widget.dart';

Future Function() multiSelectDialog<T>(
  BuildContext ctx, {
  Set<T> items,
  ObservableSet<T> selected,
  Widget Function(T) title,
  Widget Function(T) subtitle,
}) {
  return () async {
    await showDialog(
      context: ctx,
      builder: (ctx) => SimpleDialog(
        title: Text("Select Items", style: Theme.of(ctx).textTheme.headline5)
            .textAlignment(TextAlign.center)
            .padding(bottom: 12)
            .border(bottom: 1, color: Colors.black26),
        contentPadding: EdgeInsets.all(25),
        children: items
            .map(
              (e) => Observer(
                builder: (_) {
                  final isSelected = selected.contains(e);
                  return ListTile(
                    onTap: () =>
                        isSelected ? selected.remove(e) : selected.add(e),
                    title: title(e),
                    selected: isSelected,
                    subtitle: subtitle(e),
                    leading: Checkbox(
                      value: isSelected,
                      onChanged: null,
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  };
}

class MultiSelect<T> extends HookWidget {
  const MultiSelect(
      {this.openDialog,
      this.items,
      this.title,
      this.idFn,
      this.selected,
      Key key})
      : super(key: key);
  final Future Function() openDialog;
  final Set<T> items;
  final ObservableSet<T> selected;
  final String Function(T) idFn;
  final Widget title;

  @override
  Widget build(ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: openDialog,
              child: title,
            ),
            IconButton(
              icon: Icon(Icons.settings_backup_restore),
              onPressed: selected.isNotEmpty ? selected.clear : null,
            )
          ],
        ),
        LayoutBuilder(
          builder: (ctx, box) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (selected.isEmpty)
                Text("No items selected").fontSize(16).padding(vertical: 8),
              Wrap(
                spacing: 4,
                children: selected
                    .map((e) => Chip(
                          label: Text(idFn(e)),
                          onDeleted: () => selected.remove(e),
                        ))
                    .toList(),
              )
                  .scrollable(scrollDirection: Axis.horizontal)
                  .constraints(maxWidth: box.maxWidth - 50, maxHeight: 50),
              IconButton(
                constraints: BoxConstraints.expand(width: 50, height: 50),
                onPressed: openDialog,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 26,
                ),
              )
            ],
          ).border(bottom: 1, color: Colors.black12),
        ),
      ],
    );
  }
}

class TransactionFilter extends HookWidget {
  const TransactionFilter({Key key}) : super(key: key);
  @override
  Widget build(ctx) {
    final transactionStore = useTransactionStore(ctx);
    final open = useState(false);
    final openPlacesDialog = useMemoized(
        () => multiSelectDialog<Place>(
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
              subtitle: (e) => Text(e.model),
              title: (e) => Text(e.plate),
            ),
        [transactionStore, transactionStore.filter]);
    final toggleOpen =
        useMemoized(() => () => open.value = !open.value, [open.value]);

    final titleStyle = Theme.of(ctx).textTheme.subtitle1;

    if (!open.value) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          FlatButton.icon(
            onPressed: toggleOpen,
            icon: Icon(Icons.tune),
            label: Text("Filters"),
          ),
          Flexible(
            child: Wrap(
              spacing: 4,
              children: transactionStore.filter.places
                  .map((e) => Chip(
                        label: Text(e.name),
                        onDeleted: () =>
                            transactionStore.filter.places.remove(e),
                      ))
                  .followedBy(transactionStore.filter.vehicles.map((e) => Chip(
                        label: Text(e.plate),
                        onDeleted: () =>
                            transactionStore.filter.vehicles.remove(e),
                      )))
                  .toList(),
            )
                .scrollable(scrollDirection: Axis.horizontal)
                .constraints(maxHeight: 50),
          ),
        ],
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 35),
      children: [
        SizedBox(height: 10),
        Observer(
          builder: (ctx) => MultiSelect<Place>(
            idFn: (e) => e.name,
            items: transactionStore.placesInTransactions,
            openDialog: openPlacesDialog,
            selected: transactionStore.filter.places,
            title: Row(children: [
              Icon(Icons.place, size: 24),
              Text("Places", style: titleStyle).padding(horizontal: 8),
            ]),
          ),
        ),
        SizedBox(height: 10),
        Observer(
          builder: (_) => MultiSelect<VehicleModel>(
            idFn: (e) => e.plate,
            items: transactionStore.vehiclesInTransactions,
            openDialog: openVehiclesDialog,
            selected: transactionStore.filter.vehicles,
            title: Row(children: [
              Icon(Icons.directions_car, size: 24),
              Text("Vehicles", style: titleStyle).padding(horizontal: 8),
            ]),
          ),
        ),
        SizedBox(height: 15),
        Observer(
          builder: (_) {
            final interval = transactionStore.costInterval;
            final minCost = transactionStore.filter.minCost ?? interval.min;
            final maxCost = transactionStore.filter.maxCost ?? interval.max;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Icon(Icons.attach_money, size: 24),
                  Text("Cost", style: titleStyle).padding(horizontal: 8),
                ]),
                RangeSlider(
                  values: RangeValues(minCost, maxCost),
                  min: interval.min,
                  max: interval.max,
                  onChanged: transactionStore.filter.setCostInteval,
                  labels: RangeLabels(
                    currencyString(minCost),
                    currencyString(maxCost),
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
              icon: Icon(Icons.settings_backup_restore),
              label: Text("Reset"),
            ),
            FlatButton.icon(
              onPressed: toggleOpen,
              icon: Icon(Icons.close),
              label: Text("Close"),
            ),
          ],
        ).padding(top: 8, bottom: 20),
      ],
    ).backgroundColor(Colors.white).padding(bottom: 15);
  }
}
