import 'package:flutter/material.dart';
import 'package:parks/activities/store.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user/model.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatelessWidget {
  final Activity act;

  ActivityPage({@required this.act});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("${act.name}"),
        actions: getActions(authStore),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            //
            activityDescription(act),
            //
            FlatButton(
                onPressed: () => Router.navigator.pushNamed(
                      Router.placeDetail,
                      arguments: act.address,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    act.placeWidget,
                  ],
                )),
            //
            creatorInfo(),
            //
            participants(act),
            //
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    key: Key('Chat'),
                    onPressed: () {},
                    child: Icon(Icons.chat),
                  ),
                  RaisedButton(
                    key: Key('Join'),
                    onPressed: () {},
                    child: Icon(Icons.group_add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       FloatingActionButton(
      //         heroTag: null,
      //         key: Key('Chat'),
      //         onPressed: () {},
      //         tooltip: 'Chat',
      //         child: Icon(Icons.chat),
      //       ),
      //       FloatingActionButton(
      //         heroTag: null,
      //         key: Key('Join'),
      //         onPressed: () {},
      //         tooltip: 'Join',
      //         child: Icon(Icons.group_add),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

Widget activityDescription(Activity act) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            act.type,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          act.fullDescription,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}

Widget creatorInfo() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(right: 30),
          color: Colors.amber,
          child: Icon(Icons.person),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "Name",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Divider(
                height: 8,
              ),
              Text(
                "Similique accusantium eaque vel. Porro quasi soluta. Quasi laboriosam voluptatem nam aut enim tempora. Harum quia earum blanditiis explicabo ullam provident.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

List<User> _users = [
  User(name: "Juan Manuel", userId: "u1"),
  User(name: "Andrés Camilo", userId: "u2"),
  User(name: "Jimena", userId: "u3"),
];

Widget participants(Activity act) {
  return Card(
    child: Column(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Participants",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              act.fullnessWidget,
            ],
          ),
        ),
        Scrollbar(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(300, 500)),
            child: ListView(
              shrinkWrap: true,
              children: ListTile.divideTiles(
                color: Colors.black54,
                tiles: _users.map((user) => Row(
                      key: Key(user.userId),
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.only(right: 10, bottom: 5, top: 5),
                          child: Icon(Icons.person),
                        ),
                        Text(user.name)
                      ],
                    )),
              ).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
