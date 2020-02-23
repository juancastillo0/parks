import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/activities/store.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/routes.gr.dart';
import 'package:provider/provider.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 7.0,
                horizontal: 25,
              ),
              child: searchRow(),
            ),
            Observer(
              builder: (_) => Expanded(
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    final act = activityStore.activities[index];
                    return Observer(
                      builder: (_) => activityListTile(act),
                    );
                  },
                  itemCount: activityStore.activities.length,
                  itemExtent: 150.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
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
          obscureText: true,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Icon(Icons.tune),
      )
    ],
  );
}

Widget activityListTile(Activity act) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        onTap: () =>
            Router.navigator.pushNamed(Router.activityDetail, arguments: act),
        contentPadding: EdgeInsets.only(bottom: 20),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text(act.name), act.fullnessWidget],
        ),
        leading: Text(act.type),
        subtitle: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(act.description),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(act.address),
                  Text(timeago.format(act.date)),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
