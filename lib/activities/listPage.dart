import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/activities/store.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/routes.gr.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivitiesPage extends HookWidget {
  const ActivitiesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final activityStore = useActivityStore(context);
    activityStore.fetchMore();

    return Scaffold(
      appBar: AppBar(
        title: Text("Activities"),
        actions: getActions(authStore),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            searchRow().padding(
              bottom: 9.0,
              horizontal: 25,
            ),
            Observer(
              builder: (_) => Expanded(
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    final act = activityStore.activities[index];
                    return Observer(
                      builder: (_) => ActivityListTile(act),
                    );
                  },
                  itemCount: activityStore.activities.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchRow() {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextFormField(
          key: Key("search_text"),
          onSaved: (_) {},
          decoration: InputDecoration(
            labelText: "Search",
            icon: Icon(Icons.search),
          ),
        ),
      ),
      Icon(Icons.tune).padding(left: 10.0),
    ],
  );
}

class ActivityListTile extends HookWidget {
  final Activity act;
  const ActivityListTile(this.act, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () =>
            Router.navigator.pushNamed(Router.activityDetail, arguments: act),
        contentPadding: EdgeInsets.all(16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              act.name,
            ).fontWeight(FontWeight.w500).padding(bottom: 4),
            act.fullnessWidget
          ],
        ),
        leading: Text(act.type),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              act.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ).padding(bottom: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(act.address),
                Text(timeago.format(act.date)),
              ],
            ),
          ],
        ),
      ),
    ).constraints(maxWidth: 100).padding(horizontal: 12);
  }
}
