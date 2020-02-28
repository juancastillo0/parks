import 'package:flutter/material.dart';
import 'package:parks/activity/store.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/routes.gr.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

final colorScheme = ColorScheme.light(
  primary: Colors.lightBlue[50],
  primaryVariant: Color(0xffafc2cb),
  background: Colors.white,
  onPrimary: Colors.black,
  onBackground: Colors.black,
  error: Colors.red[200],
  secondary: Color(0xff00838f),
  onError: Colors.black,
  onSecondary: Colors.white,
  surface: Colors.lightBlue[50],
  onSurface: Colors.black,
  secondaryVariant: Color(0xff005662),
  brightness: Brightness.light,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: AuthStore()),
        Provider.value(value: ActivitiesStore()),
        Provider.value(value: LocationService())
        // ProxyProvider<AuthStore, CallStore>(
        //   // Dependency injection
        //   update: (context, authStore, initCallStore) => CallStore(authStore),
        //   dispose: (_, callStore) => callStore.dispose(),
        // )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: colorScheme.primary,
          accentColor: colorScheme.secondary,
          backgroundColor: colorScheme.background,
          colorScheme: colorScheme,
        ),
        onGenerateRoute: Router.onGenerateRoute,
        navigatorKey: Router.navigator.key,
        initialRoute: Router.home,
      ),
    );
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
