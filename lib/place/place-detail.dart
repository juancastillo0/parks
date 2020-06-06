import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/place/place-store.dart';
import 'package:styled_widget/styled_widget.dart';

class PlacePage extends HookWidget {
  final PlaceModel place;

  const PlacePage({Key key, this.place}) : super(key: key);

  @override
  Widget build(ctx) {
    final textTheme = Theme.of(ctx).textTheme;
    final mq = MediaQuery.of(ctx);
    return Scaffold(
      appBar: const DefaultAppBar(title: Text("Place")),
      bottomNavigationBar: const DefaultBottomNavigationBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/place-image.png',
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/parking-hypermarket.jpg",
                fit: BoxFit.cover,
              ),
            ],
          )
              .constrained(maxHeight: mq.size.height * 0.4)
              .scrollable(scrollDirection: Axis.horizontal),
          MaterialResponsiveWrapper(
            breakpoint: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(place.name, style: textTheme.headline5)
                    .alignment(Alignment.bottomLeft)
                    .padding(top: 16),
                Text(place.address, style: textTheme.subtitle1)
                    .alignment(Alignment.topLeft)
                    .padding(top: 8),
                Text("0.9 km near you", style: textTheme.subtitle1)
                    .padding(top: 8)
                    .alignment(Alignment.bottomRight),
                Text(place.description, style: textTheme.bodyText1)
                    .padding(top: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star_border)
                  ],
                ).padding(all: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text("8 Reviews", style: TextStyle(fontSize: 18)),
                    Icon(Icons.arrow_drop_down)
                  ],
                )
                    .constrained(maxWidth: 400)
                    .padding(top: 8.0, horizontal: 40, bottom: 20),
              ],
            )
                .padding(horizontal: 20)
                .constrained(maxWidth: 550)
                .scrollable(),
          ).flexible()
        ],
      ),
    );
  }
}
