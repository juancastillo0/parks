// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction-list.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class TransactionList extends HookWidget {
  const TransactionList(this.transactions, {Key key}) : super(key: key);

  final ObservableList<TransactionModel> transactions;

  @override
  Widget build(BuildContext _context) =>
      transactionList(_context, transactions);
}

class TransactionListTile extends HookWidget {
  const TransactionListTile(this.transaction, {Key key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext _context) => transactionListTile(transaction);
}
