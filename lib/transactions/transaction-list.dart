import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/text-with-icon.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-filter.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionsPage extends HookWidget {
  TransactionsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _) => TransactionList();
}

class TransactionList extends HookWidget {
  const TransactionList({Key key}) : super(key: key);

  @override
  Widget build(
    ctx,
  ) {
    final authStore = useAuthStore();
    final transactionStore = useTransactionStore(ctx);
    return Scaffold(
      backgroundColor: Theme.of(ctx).backgroundColor,
      appBar: AppBar(
        title: Text("Transactions"),
        actions: getActions(authStore),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Observer(
          builder: (_) {
            final transactions = transactionStore.filteredTransactions.toList();
            return ListView.builder(
              itemBuilder: (_, index) {
                if (index == 0) return TransactionFilter();
                final transaction = transactions[index - 1];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: TransactionListTile(transaction),
                );
              },
              itemCount: transactions.length + 1,
            ).constraints(maxWidth: 400).alignment(Alignment.center);
          },
        ),
      ),
    );
  }
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

class TransactionListTile extends HookWidget {
  const TransactionListTile(this.transaction, {Key key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(context) {
    final navigator = useNavigator(context: context);
    return ListTile(
      onTap: () {
        navigator.pushNamed(Routes.transactionDetail,
            arguments: TransactionPageArguments(transaction: transaction));
      },
      contentPadding: EdgeInsets.all(8),
      title: textWithIcon(Icons.location_on, Text(transaction.place.name)),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.attach_money).padding(bottom: 6),
          Text(transaction.costString()),
        ],
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          [
            textWithIcon(Icons.directions_car, Text(transaction.vehicle.plate)),
          ].toRow(mainAxisAlignment: MainAxisAlignment.start),
          [
            Text(timeago.format(transaction.timestamp)),
          ].toRow(mainAxisAlignment: MainAxisAlignment.end),
        ],
      ).padding(top: 8),
    ).backgroundColor(
      getTransactionBackgroundColor(transaction.state),
    );
  }
}
