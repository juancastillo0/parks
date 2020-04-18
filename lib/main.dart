import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/mock-data.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:provider/provider.dart';

import 'main.reflectable.dart' show initializeReflectable;

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  _enablePlatformOverrideForDesktop();
  initializeReflectable();
  JsonMapper().useAdapter(JsonMapperAdapter(valueDecorators: {
    typeOf<List<PaymentMethod>>(): (value) => value.cast<PaymentMethod>(),
    typeOf<List<TransactionModel>>(): (value) => value.cast<TransactionModel>(),
    typeOf<List<PlaceModel>>(): (value) => value.cast<PlaceModel>(),
    typeOf<ObservableList<TransactionModel>>(): (value) =>
        value.cast<TransactionModel>(),
  }));
  JsonMapper().useAdapter(mobXAdapter);

  await initHive(mock: false);

  GetIt.instance.registerSingleton<BackClient>(BackClient());
  final rootStore = RootStore(mockUser, mockTransactions);
  GetIt.instance.registerSingleton<RootStore>(rootStore);

  runApp(MyApp(rootStore));
}

class MyApp extends StatelessWidget {
  MyApp(this.rootStore);
  final RootStore rootStore;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: rootStore),
        ],
        child: WillPopScope(
          onWillPop: () async {
            if (Routes.home == getCurrentRoute()) {
              return true;
            } else {
              ExtendedNavigator.rootNavigator
                  .pushNamedAndRemoveUntil(Routes.home, (route) => false);
              return false;
            }
          },
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.from(
              colorScheme: colorScheme,
            ).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
            builder: ExtendedNavigator<Router>(router: Router()),
          ),
        ));
  }
}

var colorScheme = ColorScheme.light(
  primary: Color(0xff263238),
  primaryVariant: Color(0xffafc2cb),
  onPrimary: Colors.white,
  //
  secondary: Color(0xffbedbf4),
  secondaryVariant: Color(0xff8da9c1),
  onSecondary: Colors.black,
  //
  background: Color(0xffeeeeee),
  onBackground: Colors.black,
  //
  error: Colors.red[800],
  onError: Colors.white,
  //
  surface: Color(0xffffffff),
  onSurface: Colors.black,
  //
  brightness: Brightness.light,
);

// var colorScheme = ColorScheme.light(
//   primary: Colors.lightBlue[50],
//   primaryVariant: Color(0xffafc2cb),
//   onPrimary: Colors.black,
//   //
//   secondary: Color(0xff00838f),
//   secondaryVariant: Color(0xff005662),
//   onSecondary: Colors.white,
//   //
//   background: Colors.white,
//   onBackground: Colors.black,
//   //
//   error: Colors.red[200],
//   onError: Colors.black,
//   //
//   surface: Colors.lightBlue[50],
//   onSurface: Colors.black,
//   //
//   brightness: Brightness.light,
// );
