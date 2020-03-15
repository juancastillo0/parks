import 'package:flutter/cupertino.dart';
import 'package:styled_widget/styled_widget.dart';

Widget textWithIcon(IconData icon, Text text, {bool right: false}) {
  if (right) {
    return [text, Icon(icon).padding(left: 10)]
        .toRow(mainAxisSize: MainAxisSize.min);
  } else {
    return [Icon(icon).padding(right: 6), text]
        .toRow(mainAxisSize: MainAxisSize.min);
  }
}
