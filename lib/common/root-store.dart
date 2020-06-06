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

class RootStore extends _RootStore with _$RootStore {
  RootStore(BackClient client) : super(client);
}

abstract class _RootStore with Store {
  _RootStore(this.client) {
    userStore = UserStore(this as RootStore);
    transactionStore = TransactionStore(this as RootStore);
    if (!kIsWeb) notificationService = NotificationService(this as RootStore);
    authStore = AuthStore(this as RootStore);
  }

  BackClient client;

  Future clearData() async {
    await getUserBox().clear();
    await getTransactionsBox().clear();
    await getUserRequestsBox().clear();
    await getSettingsBox().clear();

    userStore = UserStore(this as RootStore);
    transactionStore = TransactionStore(this as RootStore);
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

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  NavigatorState get navigator => navigatorKey.currentState;

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
  void setSnackbarController(
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason> c,
  ) {
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
  void showInfo(SnackBar info) {
    if (snackbar == null) {
      snackbar = info;
    } else {
      infoList.add(info);
    }
  }

  @action
  void showError(String error) {
    showInfo(
      SnackBar(
        content: Text(error, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}

RootStore useStore([BuildContext context]) {
  context ??= hooks.useContext();
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
