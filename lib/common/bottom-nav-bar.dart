import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/main.dart';
import 'package:parks/routes.dart';
import 'package:styled_widget/styled_widget.dart';

String getCurrentRoute([NavigatorState navigator]) {
  navigator ??= useNavigator();

  String name;
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
  const DefaultBottomNavigationBar({Key key, this.show = true})
      : super(key: key);
  final bool show;

  @override
  Widget build(ctx) {
    final navigator = useNavigator(ctx);
    final route = getCurrentRoute(navigator);
    final rootStore = useStore(ctx);
    final authStore = rootStore.authStore;
    final lastSnackBar = usePrevious(rootStore.snackbar);

    return Observer(
      builder: (ctx) {
        final scaffold = Scaffold.of(ctx);
        if (rootStore.snackbar != null && lastSnackBar != rootStore.snackbar) {
          Future.delayed(
            Duration.zero,
            () => rootStore.setSnackbarController(
              scaffold.showSnackBar(rootStore.snackbar),
            ),
          );
        } else if (rootStore.snackbar == null) {
          Future.delayed(Duration.zero, () => scaffold.removeCurrentSnackBar());
        }

        if (!rootStore.client.isAuthorized &&
            route != Routes.home &&
            !route.startsWith("/places/")) {
          if (route != Routes.auth || !rootStore.client.isConnected) {
            if (!rootStore.client.isConnected) {
              rootStore.showInfo(const SnackBar(
                content: Text(
                    "You can't authenticate without an internet connection. "
                    "We will redirect you to the home page."),
                duration: Duration(seconds: 10),
              ));
            }

            Future.delayed(
              Duration.zero,
              () => navigator.pushNamedAndRemoveUntil(
                Routes.home,
                (route) => false,
              ),
            );
            return Container(width: 0, height: 0);
          }
        }

        if (!show) return Container(width: 0, height: 0);
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
              return Observer(
                builder: (_) {
                  return FlatButton(
                    onPressed: !authStore.isAuthenticated && name != Routes.home
                        ? null
                        : () => navigator.pushNamedAndRemoveUntil(
                              name,
                              (route) => false,
                            ),
                    child: Text(text),
                    padding: const EdgeInsets.all(0),
                  ).expanded();
                },
              );
            }
          }).toList(),
        )
            .constrained(maxHeight: 50)
            .backgroundColor(colorScheme.surface)
            .elevation(10, shadowColor: Colors.grey[800]);
      },
    );
  }
}
