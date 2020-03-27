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
  Widget build(BuildContext _context) => TransactionDetail(transaction);
}

class TransactionDetail extends HookWidget {
  const TransactionDetail(this.transaction, {Key key}) : super(key: key);
  final TransactionModel transaction;

  @override
  Widget build(BuildContext ctx) {
    final authStore = useAuthStore(ctx);
    final textTheme = Theme.of(ctx).textTheme;
    final isCompleted = transaction.state == TransactionState.Completed;
    final duration = isCompleted
        ? timeago.format(transaction.endTimestamp,
            clock: transaction.timestamp, locale: 'en_short')
        : "${transaction.state.toString().split(".")[1]} ${timeago.format(transaction.timestamp, locale: 'en_short')}";

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
        actions: getActions(authStore),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(),
      body: ListView(
        children: [
          SizedBox(height: 20),
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
          TransactionDetailColumn(
            "Cost",
            Icons.attach_money,
            Text(
              "${transaction.cost.toString()} COP",
              style: textTheme.headline5,
            ),
          ),
          TransactionDetailColumn(
            "Vehicle",
            Icons.directions_car,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  transaction.car.plate,
                  style: textTheme.headline5,
                ),
                SizedBox(height: 8),
                Text(
                  transaction.car.model,
                  style: textTheme.subtitle1,
                )
              ],
            ),
          ),
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
          if (transaction.state == TransactionState.Waiting)
            acceptCancelPaymentButtons()
        ],
      ).constraints(maxWidth: 400).alignment(Alignment.center),
    );
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
  ).padding(vertical: 20);
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
            size: 28,
          ).padding(right: 8, left: 25),
          Text(
            name,
            style: Theme.of(ctx).textTheme.headline5,
          )
        ]).padding(bottom: 12, top: 12),
        info,
        Divider(
          height: 25,
          thickness: 2,
        ).padding(top: 8)
      ],
    );
  }
}
