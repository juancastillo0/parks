import 'package:flutter/material.dart';
import 'package:parks/routes.dart';
import 'package:styled_widget/styled_widget.dart';

Future Function() deleteDialog(BuildContext context, void Function() onPressed,
    Widget title, Widget content) {
  return () async {
    await showDialog(
      context: context,
      builder: (context) {
        final navigator = useNavigator(context: context);
        return AlertDialog(
          title: title,
          content: content,
          actions: [
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () => navigator.pop(),
            ),
            FlatButton(
              child: Text("DELETE").textColor(Colors.white),
              color: Colors.red[800],
              onPressed: onPressed,
            )
          ],
        );
      },
    );
  };
}
