import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:styled_widget/styled_widget.dart';

Future Function() multiSelectDialog<T>(
  BuildContext ctx, {
  Set<T> items,
  ObservableSet<T> selected,
  Widget Function(T) title,
  Widget Function(T) subtitle,
}) {
  return () async {
    await showDialog(
      context: ctx,
      builder: (ctx) => SimpleDialog(
        title: Text("Select Items", style: Theme.of(ctx).textTheme.headline5)
            .textAlignment(TextAlign.center)
            .padding(bottom: 12)
            .border(bottom: 1, color: Colors.black26),
        contentPadding: EdgeInsets.all(25),
        children: items
            .map(
              (e) => Observer(
                builder: (_) {
                  final isSelected = selected.contains(e);
                  return ListTile(
                    onTap: () =>
                        isSelected ? selected.remove(e) : selected.add(e),
                    title: title(e),
                    selected: isSelected,
                    subtitle: subtitle(e),
                    leading: Checkbox(
                      value: isSelected,
                      onChanged: null,
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  };
}

class MultiSelect<T> extends HookWidget {
  const MultiSelect(
      {this.openDialog,
      this.items,
      this.title,
      this.idFn,
      this.selected,
      Key key})
      : super(key: key);
  final Future Function() openDialog;
  final Set<T> items;
  final ObservableSet<T> selected;
  final String Function(T) idFn;
  final Widget title;

  @override
  Widget build(ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(onTap: openDialog, child: title),
            IconButton(
              icon: Icon(Icons.settings_backup_restore),
              onPressed: selected.isNotEmpty ? selected.clear : null,
            )
          ],
        ),
        LayoutBuilder(
          builder: (ctx, box) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (selected.isEmpty)
                Text("No items selected").fontSize(16).padding(vertical: 8),
              Wrap(
                spacing: 4,
                children: selected
                    .map((e) => Chip(
                          label: Text(idFn(e)),
                          onDeleted: () => selected.remove(e),
                        ))
                    .toList(),
              )
                  .scrollable(scrollDirection: Axis.horizontal)
                  .constrained(maxWidth: box.maxWidth - 50, maxHeight: 50),
              IconButton(
                constraints: BoxConstraints.expand(width: 50, height: 50),
                onPressed: openDialog,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 26,
                ),
              )
            ],
          ).border(bottom: 1, color: Colors.black12),
        ),
      ],
    );
  }
}
