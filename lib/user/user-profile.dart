import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/activity/store.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user/model.dart';
import 'package:parks/user/user-detail.dart';

User _getUser(AuthStore authStore) {
  final firebaseUser = authStore.user;
  return User(
      name: firebaseUser.displayName,
      email: firebaseUser.email,
      places: [
        places[0]
      ],
      activities: [
        allActivities[0],
      ],
      publishedActivities: [
        allActivities[1],
        allActivities[2]
      ]);
}

class UserProfilePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authStore = useAuthStore(context);
    final user = _getUser(authStore);
    if (user == null) {
      Router.navigator.popAndPushNamed(Router.auth);
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: getActions(authStore),
        ),
        bottomNavigationBar: getBottomNavigationBar(),
        body: UserDetail(user: user),
      );
    }
  }
}
