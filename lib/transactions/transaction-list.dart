import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/transactions/transaction-detail.dart';
import 'package:parks/transactions/transaction-filter.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

const WIDTH_BREAKPOINT = 900;

class TransactionsPage extends HookWidget {
  const TransactionsPage({Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final mq = MediaQuery.of(ctx);
    final transactionStore = useTransactionStore(ctx);
    final bigScreen = mq.size.width > WIDTH_BREAKPOINT;

    return Scaffold(
        backgroundColor: Theme.of(ctx).backgroundColor,
        appBar: const DefaultAppBar(title: Text("Transactions")),
        bottomNavigationBar: const DefaultBottomNavigationBar(),
        body: bigScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TransactionList(bigScreen: bigScreen),
                  Observer(
                    builder: (_) {
                      if (transactionStore.transactions.isEmpty) {
                        return Container();
                      } else if (transactionStore.selectedTransaction == null) {
                        return const Center(
                          child: Text("Select a transaction"),
                        );
                      } else {
                        return const TransactionDetail();
                      }
                    },
                  )
                ],
              )
            : TransactionList(bigScreen: bigScreen));
  }
}

class TransactionList extends HookWidget {
  const TransactionList({this.bigScreen, Key key}) : super(key: key);
  final bool bigScreen;
  @override
  Widget build(ctx) {
    final transactionStore = useTransactionStore(ctx);
    useEffect(() {
      transactionStore.fetchTransactions();
      return null;
    }, []);

    return Observer(
      builder: (_) {
        final transactions = transactionStore.filteredTransactions;
        if (transactions.isEmpty) {
          return Center(
            child: transactionStore.loading
                ? const CircularProgressIndicator()
                : const Text("You don't have transactions").fontSize(20),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (_, index) {
            if (index == 0) return const TransactionFilter();

            return Observer(
              builder: (_) {
                final transaction = transactions[index - 1];
                final isSelected =
                    transactionStore.selectedTransaction == transaction;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: TransactionListTile(transaction),
                  elevation: isSelected && bigScreen ? 4 : 1,
                );
              },
            ).padding(bottom: index == transactions.length ? 20 : 0);
          },
          itemCount: transactions.length + 1,
        ).constrained(maxWidth: 400).alignment(Alignment.center);
      },
    );
  }
}

Color getTransactionBackgroundColor(TransactionState state) {
  switch (state) {
    case TransactionState.Active:
      return Colors.green[50];
    case TransactionState.Waiting:
      return Colors.orange[50];
    default:
      return Colors.white;
  }
}

class TransactionListTile extends HookWidget {
  const TransactionListTile(this.transaction, {Key key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(ctx) {
    final mq = MediaQuery.of(ctx);
    final navigator = useNavigator(ctx);
    final transactionStore = useTransactionStore(ctx);
    final isLargeScreen = mq.size.width > WIDTH_BREAKPOINT;
    return ListTile(
      onTap: () {
        transactionStore.selectedTransaction = transaction;
        // TODO: <id> in path
        if (!isLargeScreen) navigator.pushNamed(Routes.transactionDetail);
      },
      contentPadding: const EdgeInsets.all(8),
      title: textWithIcon(Icons.location_on, Text(transaction.place.name)),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.attach_money,
            color: Colors.green[700],
          ).padding(bottom: 6),
          Text(transaction.costString()),
        ],
      ).constrained(minWidth: 60),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          [
            textWithIcon(
              Icons.directions_car,
              Text(transaction.vehicle.plate),
            ),
            Text(transaction.state.toString().split(".")[1]),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
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
