import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/auth/auth-store.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/main.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:styled_widget/styled_widget.dart';

List<Widget> getActions(AuthStore authStore) {
  if (Routes.profile == getCurrentRoute()) {
    return <Widget>[
      IconButton(
        onPressed: () => authStore.signOut(),
        icon: Icon(
          Icons.exit_to_app,
        ),
      ),
      Container(
        width: 16,
      )
    ];
  } else {
    return <Widget>[
      IconButton(
        // onPressed: () => Router.navigator
        //     .pushNamed(authStore.user != null ? Router.profile : Router.auth),
        onPressed: () => useNavigator().pushNamed(Routes.profile),
        icon: Icon(
          Icons.person,
        ),
      ),
      Container(
        width: 16,
      )
    ];
  }
}

String getCurrentRoute([NavigatorState navigator]) {
  if (navigator == null) navigator = useNavigator();
  var name;
  navigator.popUntil(
    (route) {
      name = route.settings.name;
      return true;
    },
  );
  return name;
}

const mainRoutes = [
  {"name": Routes.transactions, "text": "Transactions"},
  {"name": Routes.home, "text": "Parkings"},
  {"name": Routes.profile, "text": "Settings"}
];

class DefaultBottomNavigationBar extends HookWidget {
  const DefaultBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final navigator = useNavigator(ctx);
    final route = getCurrentRoute(navigator);
    final authStore = useAuthStore(ctx);

    if (!authStore.isAuthenticated &&
        route != Routes.home &&
        route != Routes.auth) {
      Future.delayed(
        Duration.zero,
        () => navigator.pushNamed(
          Routes.auth,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: mainRoutes.map((routeMap) {
        final text = routeMap['text'];
        final name = routeMap['name'];

        if (route == name) {
          return FlatButton(
            onPressed: null,
            child: Text(text).fontWeight(FontWeight.bold),
            disabledTextColor: Colors.black,
          )
              .decorated(
                border: Border(
                  top: BorderSide(color: colorScheme.secondary, width: 3),
                ),
              )
              .expanded();
        } else {
          return FlatButton(
            onPressed: !authStore.isAuthenticated && name != Routes.home
                ? null
                : () => navigator.pushNamedAndRemoveUntil(
                      name,
                      (route) => false,
                    ),
            child: Text(text),
            padding: EdgeInsets.all(0),
          ).expanded();
        }
      }).toList(),
    ).constrained(maxHeight: 50).backgroundColor(colorScheme.surface).elevation(
          10,
          shadowColor: Colors.grey[800],
        );
  }
}

TextTheme useTextTheme() {
  final context = useContext();
  return Theme.of(context).textTheme;
}
