import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:mobx/mobx.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/notification-service.dart';
import 'package:parks/transactions/transaction-store.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:provider/provider.dart';

part 'root-store.g.dart';

class RootStore extends _RootStore with _$RootStore {
  RootStore(UserModel user) : super(user);
}

abstract class _RootStore with Store {
  _RootStore(UserModel user) {
    userStore = UserStore(user);
    transactionStore = TransactionStore(user: user);
    notificationService = NotificationService(user.vehicles[0].plate);
  }

  @observable
  AuthStore authStore = AuthStore();
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
