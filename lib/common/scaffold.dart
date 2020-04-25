import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/main.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:styled_widget/styled_widget.dart';

import 'back-client.dart';

class DefaultAppBar extends HookWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key key, this.title}) : super(key: key);

  final Widget title;
  final Size _preferredSize = const Size.fromHeight(kToolbarHeight + 0.0);

  @override
  Widget build(ctx) {
    final authStore = useAuthStore(ctx);
    final navigator = useNavigator(ctx);
    final backClient = GetIt.I.get<BackClient>();
    final isProfile = Routes.profile == getCurrentRoute(navigator);
    final colorScheme = Theme.of(ctx).colorScheme;

    return AppBar(
      title: title,
      actions: [
        Observer(
          builder: (_) => backClient.isConnected
              ? IconButton(
                  onPressed: () => showDialog(
                    context: ctx,
                    builder: (_) => EndpointForm(backClient),
                  ),
                  icon: Icon(Icons.http),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.signal_cellular_connected_no_internet_4_bar,
                      color: Colors.yellowAccent,
                    ).padding(right: 6),
                    Text("Offline")
                        .textColor(colorScheme.onPrimary)
                        .padding(right: 6),
                  ],
                ),
        ),
        IconButton(
          onPressed: isProfile
              ? () => authStore.signOut()
              : () => navigator.pushNamed(
                  authStore.isAuthenticated ? Routes.profile : Routes.auth),
          icon: Icon(isProfile ? Icons.exit_to_app : Icons.person),
        ),
        Container(width: 16)
      ],
    );
  }

  @override
  Size get preferredSize => _preferredSize;
}

class EndpointForm extends HookWidget {
  const EndpointForm(this.backClient, {Key key}) : super(key: key);
  final BackClient backClient;

  @override
  Widget build(ctx) {
    final c = useTextEditingController(text: backClient.baseUrl);
    return AlertDialog(
      title: Text('Server Endpoint'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: c,
              decoration: InputDecoration(labelText: "URL"),
            ).padding(top: 20),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
        FlatButton(
          child: Text('Accept'),
          onPressed: () {
            backClient.setBaseUrl(c.text);
          },
        ),
      ],
    );
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
    final rootStore = useStore(ctx);
    final authStore = useAuthStore(ctx);

    if (!authStore.isAuthenticated &&
        route != Routes.home &&
        route != Routes.auth) {
      Future.delayed(
        Duration.zero,
        () => navigator.pushNamed(Routes.auth),
      );
    }

    return Observer(builder: (ctx) {
      if (rootStore.snackbar != null) {
        final scaffold = Scaffold.of(ctx);
        Future.delayed(
          Duration.zero,
          () => rootStore.setSnackbarController(
            scaffold.showSnackBar(rootStore.snackbar),
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
                ))
                .expanded();
          } else {
            return FlatButton(
              onPressed: !authStore.isAuthenticated && name != Routes.home
                  ? null
                  : () =>
                      navigator.pushNamedAndRemoveUntil(name, (route) => false),
              child: Text(text),
              padding: EdgeInsets.all(0),
            ).expanded();
          }
        }).toList(),
      )
          .constrained(maxHeight: 50)
          .backgroundColor(colorScheme.surface)
          .elevation(10, shadowColor: Colors.grey[800]);
    });
  }
}
