// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:parks/activities/listPage.dart';
import 'package:parks/activities/detailPage.dart';
import 'package:parks/activities/store.dart';
import 'package:parks/place/detailPage.dart';
import 'package:parks/auth/page.dart';

class Router {
  static const home = '/';
  static const activityDetail = '/activity-detail';
  static const placeDetail = '/place-detail';
  static const auth = '/auth';
  static const _guardedRoutes = const {};
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.home:
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
