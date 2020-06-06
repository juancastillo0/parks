import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/routes.dart';
import 'package:styled_widget/styled_widget.dart';

Future Function() deleteDialog(
  BuildContext context,
  void Function() onPressed,
  Widget title,
  Widget content,
) {
  return () async {
    await showDialog(
      context: context,
      builder: (ctx) {
        final navigator = useNavigator(ctx);
        return AlertDialog(
          title: title,
          content: content,
          actions: [
            FlatButton(
              child: const Text("CANCEL"),
              onPressed: () => navigator.pop(),
            ),
            FlatButton(
              child: const Text("DELETE").textColor(Colors.white),
              color: Colors.red[800],
              onPressed: onPressed,
            )
          ],
        );
      },
    );
  };
}

class MaterialResponsiveWrapper extends HookWidget {
  const MaterialResponsiveWrapper(
      {this.breakpoint, @required this.child, Key key})
      : super(key: key);

  final double breakpoint;
  final Widget child;
  @override
  Widget build(ctx) {
    final mq = MediaQuery.of(ctx);
    final _breakpoint = breakpoint ?? 600;
    if (mq.size.width > _breakpoint) {
      return Card(
        elevation: 2,
        child: child,
      ).alignment(Alignment.center);
    } else {
      return Container(
        child: child.alignment(Alignment.center),
      ).backgroundColor(Theme.of(ctx).colorScheme.surface);
    }
  }
}

Widget textWithIcon(IconData icon, Text text, {bool right = false}) {
  if (right) {
    return [text, Icon(icon).padding(left: 10)]
        .toRow(mainAxisSize: MainAxisSize.min);
  } else {
    return [Icon(icon).padding(right: 6), text]
        .toRow(mainAxisSize: MainAxisSize.min);
  }
}
