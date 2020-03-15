import 'package:auto_route/auto_route_annotations.dart';
import 'package:parks/activity/activity-detail.dart';
import 'package:parks/activity/activity-list.dart';
import 'package:parks/auth/auth-page.dart';
import 'package:parks/place/place-detail.dart';
import 'package:parks/place/place-list.dart';
import 'package:parks/transactions/transaction-detail.dart';
import 'package:parks/transactions/transaction-list.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-detail.dart';
// import 'package:parks/user/user-profile.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  ActivitiesPage activities;
  ActivityPage activityDetail;
  PlacePage placeDetail;
  AuthPage auth;
  PlacesPage places;
  // UserProfilePage profile;
  UserParkingDetail profile;
  TransactionsPage home;
  TransactionPage transactionDetail;
  @MaterialRoute(fullscreenDialog: true)
  CreatePaymentMethodForm createPaymentMethod;
}
