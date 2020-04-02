import 'package:auto_route/auto_route.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';
import 'package:provider/provider.dart';

import 'main.reflectable.dart' show initializeReflectable;

void main() async {
  initializeReflectable();
  JsonMapper().useAdapter(mobXAdapter);

  await Hive.initFlutter();
  // Transactions
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionStateAdapter());
  // User
  Hive.registerAdapter(PaymentMethodTypeAdapter());
  Hive.registerAdapter(PaymentMethodAdapter());
  Hive.registerAdapter(VehicleModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  final userBox = await Hive.openBox<UserModel>("user");
  // await userBox.clear();
  print(userBox.values.toList());
  // print(await userBox.add(allUsers[0]));
  // print(userBox.getAt(0));

  runApp(MyApp());
}

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

var colorScheme = ColorScheme.dark(
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
  error: Colors.red[100],
  onError: Colors.black,
  //
  surface: Color(0xffffffff),
  onSurface: Colors.black,
  //
  brightness: Brightness.light,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: RootStore(allUsers[0])),
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
              // textSelectionColor: Colors.black,
              // primaryColor: colorScheme.primary,
              // accentColor: colorScheme.secondary,
              // accentColorBrightness: Brightness.light,
              // backgroundColor: colorScheme.background,
              // primaryColorBrightness: Brightness.light,
              // brightness: colorScheme.brightness,
              // primaryColorDark: Colors.black
            ),
            builder: ExtendedNavigator<Router>(router: Router()),
          ),
        ));
  }
}
