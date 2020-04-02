import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/auth/store.dart';
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
        onPressed: () =>
            ExtendedNavigator.rootNavigator.pushNamed(Routes.profile),
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

String getCurrentRoute() {
  var name;
  ExtendedNavigator.rootNavigator.popUntil(
    (route) {
      name = route.settings.name;
      return true;
    },
  );
  return name;
}

const mainRoutes = [
  {"name": Routes.home, "text": "Transactions"},
  {"name": Routes.places, "text": "Parkings"},
  {"name": Routes.profile, "text": "Settings"}
];

class DefaultBottomNavigationBar extends HookWidget {
  const DefaultBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final route = getCurrentRoute();
    final navigator = useNavigator(context: context);

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
              .decoration(
                border: Border(
                  top: BorderSide(color: colorScheme.secondary, width: 3),
                ),
              )
              .expanded();
        } else {
          return FlatButton(
            onPressed: () => navigator.pushNamedAndRemoveUntil(
              name,
              (route) => false,
            ),
            child: Text(text),
            padding: EdgeInsets.all(0),
            
          ).expanded();
        }
      }).toList(),
    ).constraints(maxHeight: 50)
        .backgroundColor(colorScheme.surface)
        .elevation(10, shadowColor: Colors.grey[800], opacity: 0.7, angle: 20);
  }
}

TextTheme useTextTheme() {
  final context = useContext();
  return Theme.of(context).textTheme;
}
