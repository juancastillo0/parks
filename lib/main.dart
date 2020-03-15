import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:flutter/material.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:provider/provider.dart';

import 'main.reflectable.dart' show initializeReflectable;

void main() {
  initializeReflectable();
  JsonMapper().useAdapter(mobXAdapter);
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
          // ProxyProvider<AuthStore, CallStore>(
          //   // Dependency injection
          //   update: (context, authStore, initCallStore) => CallStore(authStore),
          //   dispose: (_, callStore) => callStore.dispose(),
          // )
        ],
        child: WillPopScope(
          onWillPop: () async {
            if (Router.home == getCurrentRoute()) {
              return true;
            } else {
              Router.navigator
                  .pushNamedAndRemoveUntil(Router.home, (route) => false);
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
            onGenerateRoute: Router.onGenerateRoute,
            navigatorKey: Router.navigator.key,
            initialRoute: Router.home,
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
