// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:parks/activity/activity-list.dart';
import 'package:parks/activity/activity-detail.dart';
import 'package:parks/activity/store.dart';
import 'package:parks/place/place-detail.dart';
import 'package:parks/auth/auth-page.dart';
import 'package:parks/place/place-list.dart';
import 'package:parks/user-parking/user-detail.dart';
import 'package:parks/transactions/transaction-list.dart';
import 'package:parks/transactions/transaction-detail.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-store.dart';

class Router {
  static const activities = '/';
  static const activityDetail = '/activity-detail';
  static const placeDetail = '/place-detail';
  static const auth = '/auth';
  static const places = '/places';
  static const profile = '/profile';
  static const home = '/home';
  static const transactionDetail = '/transaction-detail';
  static const createPaymentMethod = '/create-payment-method';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.activities:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ActivitiesPage(key: typedArgs),
          settings: settings,
        );
      case Router.activityDetail:
        if (hasInvalidArgs<Activity>(args, isRequired: true)) {
          return misTypedArgsRoute<Activity>(args);
        }
        final typedArgs = args as Activity;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ActivityPage(act: typedArgs),
          settings: settings,
        );
      case Router.placeDetail:
        if (hasInvalidArgs<String>(args, isRequired: true)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String;
        return MaterialPageRoute<dynamic>(
          builder: (_) => PlacePage(address: typedArgs),
          settings: settings,
        );
      case Router.auth:
        if (hasInvalidArgs<AuthPageArguments>(args)) {
          return misTypedArgsRoute<AuthPageArguments>(args);
        }
        final typedArgs = args as AuthPageArguments ?? AuthPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => AuthPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Router.places:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => PlacesPage(key: typedArgs),
          settings: settings,
        );
      case Router.profile:
        return MaterialPageRoute<dynamic>(
          builder: (_) => UserParkingDetail(),
          settings: settings,
        );
      case Router.home:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => TransactionsPage(key: typedArgs),
          settings: settings,
        );
      case Router.transactionDetail:
        if (hasInvalidArgs<TransactionPageArguments>(args)) {
          return misTypedArgsRoute<TransactionPageArguments>(args);
        }
        final typedArgs =
            args as TransactionPageArguments ?? TransactionPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              TransactionPage(typedArgs.transaction, key: typedArgs.key),
          settings: settings,
        );
      case Router.createPaymentMethod:
        if (hasInvalidArgs<UserStore>(args)) {
          return misTypedArgsRoute<UserStore>(args);
        }
        final typedArgs = args as UserStore;
        return MaterialPageRoute<dynamic>(
          builder: (_) => CreatePaymentMethodForm(typedArgs),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AuthPage arguments holder class
class AuthPageArguments {
  final Key key;
  final String title;
  AuthPageArguments({this.key, this.title});
}

//TransactionPage arguments holder class
class TransactionPageArguments {
  final TransactionModel transaction;
  final Key key;
  TransactionPageArguments({this.transaction, this.key});
}
