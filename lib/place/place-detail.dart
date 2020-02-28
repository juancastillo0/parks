import 'package:flutter/material.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatelessWidget {
  final String address;

  PlacePage({@required this.address});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("$address"),
          actions: getActions(authStore),
        ),
        bottomNavigationBar: getBottomNavigationBar(),
        body: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/place-image.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text("0.9 km near you", style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star_border)
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("7 Activities", style: TextStyle(fontSize: 18)),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("8 Reviews", style: TextStyle(fontSize: 18)),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Expanded(child: Container()),
            RaisedButton(
              onPressed: () {},
              child: Text("Subscribe"),
            )
          ],
        ));
  }
}
