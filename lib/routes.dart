import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/auth/auth-page.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/place/place-detail.dart';
import 'package:parks/place/place-list.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-detail.dart';
import 'package:parks/transactions/transaction-list.dart';
import 'package:parks/user-parking/paymentMethod/form.dart';
import 'package:parks/user-parking/user-detail.dart';

class Path {
  Path(String _pattern, this.builder, {this.fullscreenDialog = false})
      : pattern = RegExp("^$_pattern\$");

  final RegExp pattern;
  final Widget Function(BuildContext context, RegExpMatch match) builder;
  final bool fullscreenDialog;
}

class Routes {
  // Auth
  static const auth = "/auth";
  static final Path authPath = Path(auth, (context, match) => const AuthPage());

  // Places
  static String placeDetail(PlaceModel place) => "/places/${place.id}";
  static final Path placeDetailPath =
      Path(r"/places/(?<id>[\w|-]+)", (context, match) {
    final placeId = match.namedGroup("id");
    final place = GetIt.I.get<RootStore>().placeStore.places[placeId];
    return PlacePage(place: place);
  });

  static const home = "/";
  static final Path homePath =
      Path(home, (context, match) => const PlacesPage());

  // User
  static const profile = "/profile";
  static final Path profilePath =
      Path(profile, (context, match) => UserParkingDetail());

  // Transactions
  static const transactions = "/transactions";
  static final Path transactionsPath =
      Path(transactions, (context, match) => const TransactionsPage());

  // TODO: <id> in path
  static const transactionDetail = "/transaction-detail";
  static final Path transactionDetailPath =
      Path(transactionDetail, (context, match) => const TransactionPage(null));

  // Payment
  static const createPaymentMethod = "/create-payment-method";
  static final Path createPaymentMethodPath = Path(
    createPaymentMethod,
    (context, match) => const CreatePaymentMethodForm(),
    fullscreenDialog: true,
  );

  static final List<Path> all = [
    createPaymentMethodPath,
    transactionDetailPath,
    transactionsPath,
    profilePath,
    placeDetailPath,
    authPath,
    homePath,
  ];
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  for (Path path in Routes.all) {
    final firstMatch = path.pattern.firstMatch(settings.name);
    if (firstMatch != null) {
      // final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;

      return MaterialPageRoute(
        builder: (context) => path.builder(context, firstMatch),
        settings: settings,
        fullscreenDialog: path.fullscreenDialog,
      );
    }
  }
  // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
  return null;
}

NavigatorState getNavigator() {
  try {
    return GetIt.I.get<RootStore>().navigator;
  } catch (e) {
    return null;
  }
}

NavigatorState useNavigator([BuildContext context]) {
  context ??= useContext();
  return Navigator.of(context);
}
