import 'package:auto_route/auto_route_annotations.dart';
import 'package:parks/auth/auth-page.dart';
import 'package:parks/place/place-detail.dart';
import 'package:parks/place/place-list.dart';
import 'package:parks/transactions/transaction-detail.dart';
import 'package:parks/transactions/transaction-list.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-detail.dart';

@MaterialAutoRouter()
class $Router {
  // Auth
  AuthPage auth;

  // Places
  PlacePage placeDetail;
  PlacesPage places;

  // User
  UserParkingDetail profile;

  // Transactions
  @initial
  TransactionsPage home;
  TransactionPage transactionDetail;

  // Payment
  @MaterialRoute(fullscreenDialog: true)
  CreatePaymentMethodForm createPaymentMethod;
}
