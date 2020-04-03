import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/place/place-store.dart';
import 'package:styled_widget/styled_widget.dart';

class PlacePage extends HookWidget {
  final Place place;

  PlacePage({Key key, this.place}) : super(key: key);

  @override
  Widget build(ctx) {
    final authStore = useAuthStore(ctx);
    final textTheme = Theme.of(ctx).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("${place.address}"),
        actions: getActions(authStore),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(),
      body: ListView(
        children: [
          Image(
            image: AssetImage('assets/place-image.png'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(place.name, style: textTheme.headline5)
                  .alignment(Alignment.center)
                  .padding(top: 16),
              Text("0.9 km near you", style: textTheme.subtitle1)
                  .alignment(Alignment.center)
                  .padding(top: 8),
              Text(place.description, style: textTheme.bodyText1)
                  .padding(top: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star_border)
                ],
              ).padding(all: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("8 Reviews", style: TextStyle(fontSize: 18)),
                  Icon(Icons.arrow_drop_down)
                ],
              ).padding(vertical: 8.0, horizontal: 40),
            ],
          ).padding(horizontal: 20)
        ],
      ),
    );
  }
}
