import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:mobx/mobx.dart';
import 'package:parks/auth/auth-store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/notification-service.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/transactions/transaction-store.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:provider/provider.dart';

part 'root-store.g.dart';

class RootStore extends _RootStore with _$RootStore {
  RootStore(UserModel user, List<TransactionModel> transactions)
      : super(user, transactions);
}

abstract class _RootStore with Store {
  _RootStore(UserModel user, List<TransactionModel> transactions) {
    userStore = UserStore(user);
    transactionStore = TransactionStore(transactions: transactions);
    notificationService = NotificationService(user.vehicles.values.first.plate);
  }

  @observable
  AuthStore authStore = AuthStore();
  @observable
  PlaceStore placeStore = PlaceStore();
  @observable
  UserStore userStore;
  @observable
  TransactionStore transactionStore;
  @observable
  LocationService locationService = LocationService();
  @observable
  NotificationService notificationService;
}

RootStore useStore([BuildContext context]) {
  if (context == null) {
    context = hooks.useContext();
  }
  return Provider.of<RootStore>(context, listen: false);
}

AuthStore useAuthStore([BuildContext context]) {
  return useStore(context).authStore;
}

LocationService useLocationService([BuildContext context]) {
  return useStore(context).locationService;
}

UserStore useUserStore([BuildContext context]) {
  return useStore(context).userStore;
}

TransactionStore useTransactionStore([BuildContext context]) {
  return useStore(context).transactionStore;
}
