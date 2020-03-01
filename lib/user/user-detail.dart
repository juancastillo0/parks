import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/activity/activity-list.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/place/place-list.dart';
import 'package:parks/user/model.dart';
import 'package:styled_widget/styled_widget.dart';

class _Item<T> {
  bool isExpanded;
  Widget contractedWidget;
  T value;
  Widget Function(T) expandedWidgetFn;

  _Item(
      {this.isExpanded: false,
      this.value,
      this.contractedWidget,
      this.expandedWidgetFn});
}

class UserDetail extends HookWidget {
  final User user;
  UserDetail({@required this.user});

  @override
  Widget build(BuildContext context) {
    final activities = user.activities.map((e) {
      return _Item(
          contractedWidget: ListTile(
            title: Text("Activities (${user.places.length})"),
          ),
          expandedWidgetFn: (v) => ActivityListTile(v),
          value: e);
    }).toList();
    final places = user.places.map((e) {
      return _Item(
          contractedWidget: ListTile(
            title: Text("Places (${user.places.length})"),
          ),
          expandedWidgetFn: (v) => PlaceListTile(v),
          value: e);
    }).toList();
    // final authStore = Provider.of<AuthStore>(context, listen: false);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.person,
              size: 32,
            ).padding(horizontal: 20),
            Text(
              user.name,
              style: useTextTheme().headline4,
            )
          ],
        ).padding(all: 12),
        // RaisedButton(
        //   onPressed: () => authStore.signOut(),
        //   child: Text("Log out"),
        // ),
        Card(
          margin: EdgeInsets.all(12),
          elevation: 12,
          child: Column(
            children: [
              Text("Created Activities", style: useTextTheme().headline6)
                  .padding(bottom: 12, top: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: user.publishedActivities.map((v) {
                  return ActivityListTile(v);
                }).toList(),
              ).scrollable().constraints(maxHeight: 250)
            ],
          ).padding(all: 6),
        ),
        ExpandibleList(activities),
        ExpandibleList(places).padding(bottom: 50),
        // RaisedButton(
        //   onPressed: () {},
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       Icon(Icons.chat).padding(all: 6),
        //       Text("Chat"),
        //     ],
        //   ),
        // )
      ],
    ).scrollable();
  }
}

class ExpandibleList<T> extends HookWidget {
  final List<_Item<T>> items;
  ExpandibleList(this.items);

  @override
  Widget build(BuildContext context) {
    final _data = useState(items);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        _data.value[index].isExpanded = !isExpanded;
        _data.value = [..._data.value];
      },
      children: _data.value.map<ExpansionPanel>((_Item<T> item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return item.contractedWidget;
          },
          body: item.expandedWidgetFn(item.value),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
