import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/transactions/transaction-list.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:styled_widget/styled_widget.dart';

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
  Widget build(BuildContext _context) {
    final authStore = useAuthStore();
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
        actions: getActions(authStore),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TransactionListTile(transaction),
          if (transaction.state == TransactionState.Waiting)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {},
                  child: Text("CANCEL"),
                ),
                SizedBox(width: 20),
                RaisedButton(
                  onPressed: () {},
                  child: Text("ACCEPT"),
                )
              ],
            ).padding(bottom: 10),
        ],
      ),
    );
  }
}
