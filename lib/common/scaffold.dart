import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/main.dart';
import 'package:parks/routes.gr.dart';
import 'package:styled_widget/styled_widget.dart';

List<Widget> getActions(AuthStore authStore) {
  return <Widget>[
    IconButton(
      onPressed: () => Router.navigator
          .pushNamed(authStore.user != null ? Router.home : Router.auth),
      icon: Icon(
        Icons.person,
      ),
    ),
    Container(
      width: 16,
    )
  ];
}

String getCurrentRoute() {
  var name;
  Router.navigator.popUntil(
    (route) {
      name = route.settings.name;
      return true;
    },
  );
  return name;
}

const mainRoutes = [
  {"name": Router.home, "text": "Activities"},
  {"name": Router.places, "text": "Places"},
  {"name": Router.auth, "text": "Chats"}
];
Widget getBottomNavigationBar() {
  final route = getCurrentRoute();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    mainAxisSize: MainAxisSize.max,
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
          onPressed: () => Router.navigator.pushNamedAndRemoveUntil(
            name,
            (route) => false,
          ),
          child: Text(text),
        ).expanded();
      }
    }).toList(),
  )
      .backgroundColor(colorScheme.background)
      .elevation(10, shadowColor: Colors.grey[800], opacity: 0.7, angle: 20);
}

TextTheme useTextTheme() {
  final context = useContext();
  return Theme.of(context).textTheme;
}
