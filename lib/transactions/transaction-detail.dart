import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionPage extends HookWidget {
  const TransactionPage(this.transaction, {Key key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(ctx) => Scaffold(
        appBar: DefaultAppBar(
          title: Text("Transaction"),
        ),
        bottomNavigationBar: DefaultBottomNavigationBar(),
        body: TransactionDetail(transaction),
      );
}

class TransactionDetail extends HookWidget {
  const TransactionDetail(transaction, {Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final transactionStore = useTransactionStore();
    final textTheme = Theme.of(ctx).textTheme;
    return Observer(
      builder: (ctx) {
        final transaction = transactionStore.selectedTransaction;
        final isCompleted = transaction.state == TransactionState.Completed;
        final stateStr = transaction.state != null
            ? transaction.state.toString().split(".")[1]
            : "null";

        final duration = isCompleted
            ? timeago.format(transaction.timestamp,
                clock: transaction.endTimestamp, locale: 'en_short')
            : "$stateStr: ${timeago.format(transaction.timestamp, locale: 'en_short')}";

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
                  Text(transaction.place.name, style: textTheme.headline5),
                  SizedBox(height: 8),
                  Text(transaction.place.address, style: textTheme.subtitle1)
                ],
              ),
            ),
            Divider(height: 20, thickness: 1).padding(top: 8),
            TransactionDetailColumn(
              "Cost",
              Icons.attach_money,
              Text("${transaction.costString()} COP",
                  style: textTheme.headline5),
            ),
            Divider(height: 20, thickness: 1).padding(top: 8),
            TransactionDetailColumn(
              "Vehicle",
              Icons.directions_car,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(transaction.vehicle.plate, style: textTheme.headline5),
                  SizedBox(height: 8),
                  Text(
                    transaction.vehicle.description ?? "No description",
                    style: textTheme.subtitle1,
                  )
                ],
              ),
            ),
            Divider(height: 20, thickness: 1).padding(top: 8),
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
            SizedBox(height: 40),
            if (transaction.state == TransactionState.Waiting)
              acceptCancelPaymentButtons(ctx).padding(bottom: 20)
            // else if (transaction.state == TransactionState.Active)
            //   Padding(
            //     padding: EdgeInsets.symmetric(vertical: 20),
            //     child: RaisedButton(
            //       child: Text("I'll be there in 5 min!",
            //           style: textTheme.subtitle1),
            //       color: Theme.of(ctx).colorScheme.secondary,
            //       onPressed: () {},
            //     ),
            //   )
          ],
        )
            .scrollable(scrollDirection: Axis.vertical)
            .backgroundColor(Colors.white)
            .constrained(maxWidth: 400)
            .alignment(Alignment.center);
      },
    );
  }
}

Widget acceptCancelPaymentButtons(BuildContext ctx) {
  final userStore = useUserStore(ctx);
  final transactionStore = useTransactionStore(ctx);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RaisedButton(
        onPressed: deleteDialog(
          ctx,
          () async {
            await transactionStore.updateTransactionState(
                transactionStore.selectedTransaction.id, false);
            Navigator.of(ctx).pushNamed(Routes.transactions);
          },
          Text("Reject Transaction"),
          Text("Are you sure you want to reject the transaction?"),
        ),
        child: Text("REJECT", style: TextStyle(color: Colors.white)),
        color: Colors.red[700],
      ),
      SizedBox(width: 40),
      RaisedButton(
        onPressed: userStore.user.paymentMethods.isEmpty
            ? () => Navigator.of(ctx).pushNamed(Routes.createPaymentMethod)
            : () => showDialog(
                  context: ctx,
                  child: Dialog(child: SingleSelect()),
                ),
        child: Text("ACCEPT", style: TextStyle(color: Colors.white)),
        color: Colors.green[700],
      )
    ],
  );
}

class SingleSelect extends HookWidget {
  const SingleSelect({Key key}) : super(key: key);
  @override
  Widget build(ctx) {
    final transactionStore = useTransactionStore(ctx);
    final userStore = useUserStore(ctx);
    final groupValue = useState(userStore.user.paymentMethods.first.id);
    final state = useState(RequestState.none());
    final mq = MediaQuery.of(ctx);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select the Payment Method",
              style: Theme.of(ctx).textTheme.headline6,
            ).padding(bottom: 20, top: 25).alignment(Alignment.topLeft),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                final e = userStore.user.paymentMethods[index];
                return ListTile(
                  key: Key(e.id),
                  leading: Text(e.type.toString().split(".")[1])
                      .textAlignment(TextAlign.center),
                  title: Text(e.description).padding(bottom: 3),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(e.provider), Text("**** ${e.lastDigits}")],
                  ),
                  trailing: Radio(
                    value: e.id,
                    groupValue: groupValue.value,
                    onChanged: (id) => groupValue.value = id,
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: userStore.user.paymentMethods.length,
            ).flexible(),
          ],
        )
            .padding(horizontal: 20)
            .constrained(maxHeight: min(mq.size.height * 0.7, 600)),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            state.value
                .asWidget()
                .constrained(height: 24, width: 24)
                .padding(horizontal: 20),
            ButtonBar(
              children: [
                FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
                FlatButton(
                  child: Text("ACCEPT"),
                  onPressed: () async {
                    state.value = RequestState.loading();
                    final error = await transactionStore.updateTransactionState(
                      transactionStore.selectedTransaction.id,
                      true,
                    );
                    if (error == null)
                      Navigator.of(ctx).pop();
                    else
                      state.value = RequestState.err(error);
                  },
                  color: Colors.green[800],
                ),
              ],
            )
          ],
        )
      ],
    ).constrained(maxWidth: 400).backgroundColor(Colors.white);
  }
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
          Icon(icon, size: 26).padding(right: 6, left: 25),
          Text(name, style: Theme.of(ctx).textTheme.subtitle1)
        ]).padding(bottom: 12, top: 12),
        info,
      ],
    );
  }
}
