import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.dart';
import 'package:styled_widget/styled_widget.dart';

class DefaultAppBar extends HookWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key key, this.title}) : super(key: key);

  final Widget title;
  static const Size _preferredSize = Size.fromHeight(kToolbarHeight + 0.0);

  @override
  Widget build(ctx) {
    final store = useStore();
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
                  icon: const Icon(Icons.http),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.signal_cellular_connected_no_internet_4_bar,
                      color: Colors.yellowAccent,
                    ).padding(right: 6),
                    const Text("Offline")
                        .textColor(colorScheme.onPrimary)
                        .padding(right: 6),
                  ],
                ).gestures(onTap: () => onTapOffline(ctx, store)),
        ),
        Observer(
          builder: (_) => (backClient.isConnected || backClient.isAuthorized)
              ? IconButton(
                  onPressed: isProfile
                      ? () => authStore.signOut()
                      : () => navigator.pushNamed(authStore.isAuthenticated
                          ? Routes.profile
                          : Routes.auth),
                  icon: Icon(isProfile ? Icons.exit_to_app : Icons.person),
                )
              : Container(height: 0, width: 0),
        ),
        Container(width: 16)
      ],
    );
  }

  @override
  Size get preferredSize => _preferredSize;
}

Future onTapOffline(BuildContext ctx, RootStore store) async {
  final textTheme = Theme.of(ctx).textTheme;
  await showDialog(
    context: ctx,
    child: Dialog(
      child: Observer(
        builder: (_) => store.pendingRequests.isEmpty
            ? Container(
                child: Text(
                  "No pending requests",
                  style: textTheme.headline5,
                ).alignment(Alignment.center).constrained(
                      maxWidth: 250,
                      maxHeight: 100,
                    ),
              ).backgroundColor(Colors.white)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Requests", style: textTheme.headline6),
                      RaisedButton.icon(
                        onPressed: () async {
                          await store.userStore.deleteAllRequests();
                          Navigator.of(ctx).pop();
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text("Delete All"),
                      ),
                    ],
                  ).padding(vertical: 10),
                  ...store.pendingRequests.map((r) {
                    return ListTile(title: r.asWidget());
                  }),
                  const SizedBox(height: 10)
                ],
              )
                .padding(horizontal: 20)
                .constrained(maxWidth: 400)
                .backgroundColor(Colors.white),
      ),
    ),
  );
}

class EndpointForm extends HookWidget {
  const EndpointForm(this.backClient, {Key key}) : super(key: key);
  final BackClient backClient;

  @override
  Widget build(ctx) {
    final c = useTextEditingController(text: backClient.baseUrl);
    final placesBox = getPlacesBox();
    return AlertDialog(
      title: const Text('Server Endpoint'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            RaisedButton(
                child: const Text("Delete Places").textColor(Colors.white),
                onPressed: () => placesBox.clear(),
                color: Colors.red[800]),
            TextField(
              controller: c,
              decoration: const InputDecoration(labelText: "URL"),
            ).padding(top: 20),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
        FlatButton(
          child: const Text('Accept'),
          onPressed: () {
            backClient.setBaseUrl(c.text.trim());
          },
        ),
      ],
    );
  }
}
