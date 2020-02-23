import 'package:flutter/material.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/routes.gr.dart';

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
