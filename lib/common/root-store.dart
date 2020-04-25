import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/auth/auth-store.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/notification-service.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-store.dart';
import 'package:parks/user-parking/user-back.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:provider/provider.dart';

part 'root-store.g.dart';

class RootStore extends _RootStore with _$RootStore {}

abstract class _RootStore with Store {
  _RootStore() {
    userStore = UserStore(this);
    transactionStore = TransactionStore(this);
    if (!kIsWeb) notificationService = NotificationService(this);
    authStore = AuthStore(this);
  }

  Future clearData() async {
    await getUserBox().clear();
    await getTransactionsBox().clear();
    userStore = UserStore(this);
    transactionStore = TransactionStore(this);
  }

  @observable
  AuthStore authStore;
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

  // UI

  @observable
  SnackBar snackbar;
  @observable
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbarController;

  @computed
  ObservableList<UserRequest> get pendingRequests {
    return userStore.requests;
  }

  @action
  setSnackbarController(
      ScaffoldFeatureController<SnackBar, SnackBarClosedReason> c) {
    snackbarController = c;
    if (snackbarController != null) {
      snackbarController.closed.then((value) {
        if (infoList.isNotEmpty) {
          snackbar = infoList.removeLast();
        } else {
          snackbar = null;
        }
        snackbarController = null;
      });
    }
  }

  @observable
  ObservableList<String> errors = ObservableList<String>();
  @observable
  ObservableList<SnackBar> infoList = ObservableList<SnackBar>();

  @action
  showInfo(SnackBar info) {
    if (snackbar == null)
      snackbar = info;
    else
      infoList.add(info);
  }

  @action
  showError(String error) {
    errors.add(error);
  }
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

BackClient useBackClient() {
  return GetIt.I.get<BackClient>();
}
