import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionPage extends HookWidget {
  const TransactionPage(this.transaction, {Key key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(ctx) => Scaffold(
        appBar: AppBar(
          title: Text("Transaction"),
          actions: getActions(useAuthStore(ctx)),
        ),
        bottomNavigationBar: DefaultBottomNavigationBar(),
        body: TransactionDetail(transaction),
      );
}

class TransactionDetail extends HookWidget {
  const TransactionDetail(this.transaction, {Key key}) : super(key: key);
  final TransactionModel transaction;

  @override
  Widget build(ctx) {
    final textTheme = Theme.of(ctx).textTheme;
    final isCompleted = transaction.state == TransactionState.Completed;
    final duration = isCompleted
        ? timeago.format(transaction.timestamp,
            clock: transaction.endTimestamp, locale: 'en_short')
        : "${transaction.state.toString().split(".")[1]}: ${timeago.format(transaction.timestamp, locale: 'en_short')}";
    if (transaction == null) {
      return Center(
        child: Text("Select a transaction", style: textTheme.headline6),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 15),
        TransactionDetailColumn(
          "Place",
          Icons.location_on,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                transaction.place.name,
                style: textTheme.headline5,
              ),
              SizedBox(height: 8),
              Text(
                transaction.place.address,
                style: textTheme.subtitle1,
              )
            ],
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
        ).padding(top: 8),
        TransactionDetailColumn(
          "Cost",
          Icons.attach_money,
          Text(
            "${transaction.costString()} COP",
            style: textTheme.headline5,
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
        ).padding(top: 8),
        TransactionDetailColumn(
          "Vehicle",
          Icons.directions_car,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                transaction.vehicle.plate,
                style: textTheme.headline5,
              ),
              SizedBox(height: 8),
              Text(
                transaction.vehicle.model,
                style: textTheme.subtitle1,
              )
            ],
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
        ).padding(top: 8),
        TransactionDetailColumn(
          "Duration",
          Icons.timer,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(duration, style: textTheme.headline5),
              if (isCompleted)
                Text(
                  "Completed ${timeago.format(transaction.timestamp)}",
                ).padding(vertical: 8)
            ],
          ),
        ),
        SizedBox(height: 20),
        if (transaction.state == TransactionState.Waiting)
          acceptCancelPaymentButtons().padding(vertical: 20)
        else if (transaction.state == TransactionState.Active)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: RaisedButton(
              child:
                  Text("I'll be there in 5 min!", style: textTheme.subtitle1),
              color: Theme.of(ctx).colorScheme.secondary,
              onPressed: () {},
            ),
          )
      ],
    )
        .scrollable(scrollDirection: Axis.vertical)
        .backgroundColor(Colors.white)
        .constraints(maxWidth: 400)
        .alignment(Alignment.center);
  }
}

Widget acceptCancelPaymentButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RaisedButton(
        onPressed: () {},
        child: Text("CANCEL",
            style: TextStyle(
              color: Colors.white,
            )),
        color: Colors.red[700],
      ),
      SizedBox(width: 40),
      RaisedButton(
        onPressed: () {},
        child: Text("ACCEPT",
            style: TextStyle(
              color: Colors.white,
            )),
        color: Colors.green[700],
      )
    ],
  );
}

class TransactionDetailColumn extends HookWidget {
  const TransactionDetailColumn(this.name, this.icon, this.info, {Key key})
      : super(key: key);
  final IconData icon;
  final Widget info;
  final String name;

  @override
  Widget build(ctx) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            icon,
            size: 26,
          ).padding(right: 6, left: 25),
          Text(
            name,
            style: Theme.of(ctx).textTheme.subtitle1,
          )
        ]).padding(bottom: 12, top: 12),
        info,
      ],
    );
  }
}
