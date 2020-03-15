import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/text-with-icon.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'transaction-list.g.dart';

class TransactionsPage extends HookWidget {
  TransactionsPage({Key key}) : super(key: key) {
    transactions.sort(TransactionModel.compareTo);
  }

  final ObservableList<TransactionModel> transactions = allUsers[0].transactions;

  @override
  Widget build(BuildContext _context) => TransactionList(transactions);
}

@hwidget
Widget transactionList(
    BuildContext context, ObservableList<TransactionModel> transactions) {
  final authStore = useAuthStore();
  return Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    appBar: AppBar(
      title: Text("Transactions"),
      actions: getActions(authStore),
    ),
    bottomNavigationBar: getBottomNavigationBar(),
    body: Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ListView.builder(
        itemBuilder: (_, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: TransactionListTile(transaction),
          );
        },
        itemCount: transactions.length,
      ),
    ),
  );
}

Color getTransactionBackgroundColor(TransactionState state) {
  switch (state) {
    case TransactionState.Completed:
      return Colors.white;
    case TransactionState.Active:
      return Colors.green[50];
    case TransactionState.Waiting:
      return Colors.orange[50];
  }
  return null;
}

@hwidget
Widget transactionListTile(TransactionModel transaction) {
  return ListTile(
    onTap: () {
      Router.navigator.pushNamed(Router.transactionDetail,
          arguments: TransactionPageArguments(transaction: transaction));
    },
    contentPadding: EdgeInsets.all(8),
    title: textWithIcon(Icons.location_on, Text(transaction.place.name)),
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.attach_money).padding(bottom: 6),
        Text(transaction.cost.toString()),
      ],
    ),
    subtitle: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        [
          textWithIcon(Icons.directions_car, Text(transaction.car.plate)),
        ].toRow(mainAxisAlignment: MainAxisAlignment.start),
        [
          Text(timeago.format(transaction.timestamp)),
        ].toRow(mainAxisAlignment: MainAxisAlignment.end),
      ],
    ).padding(top: 8),
  ).backgroundColor(getTransactionBackgroundColor(transaction.state));
}
