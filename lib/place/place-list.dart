import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parks/activity/store.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/main.dart';
import 'package:provider/provider.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PlacesPage();
  }
}

class Location {
  int key;
  String name;
  double latitud;
  double longitud;
  String description;
  double rating;
  List<Activity> activities;

  Location({
    this.key,
    this.name,
    this.latitud,
    this.longitud,
    this.description,
    this.rating,
    this.activities: const [],
  });
}

var locations = [
  Location(
    key: 1,
    name: "National Park",
    description:
        "Sed culpa consequuntur labore in. Quis quia recusandae amet. Consectetur doloribus sit omnis temporibus officia. Earum ipsum tempora occaecati fugit. Deserunt facilis autem occaecati consequatur iure maxime ut.",
    rating: 4.2,
    latitud: 4.669515485820514,
    longitud: -74.05895933919157,
  ),
  Location(
    key: 2,
    name: "Calle 80 # 11 Park",
    description:
        "Qui ratione officiis repellat. Et maiores facilis optio excepturi animi. Ut consequatur consequatur non omnis. Omnis ut ad enim quia in sit. Facere temporibus ipsam nesciunt recusandae ex qui dolores eos.",
    rating: 3.5,
    latitud: 4.610515485820514,
    longitud: -74.07895933919157,
  ),
  Location(
    key: 3,
    name: "Virrey Park",
    description: "Tempore id nostrum alias est voluptatibus et qui enim.",
    rating: 4.0,
    latitud: 4.607683967477323,
    longitud: -73.8008203466492,
  )
];

class _PlacesPage extends HookWidget {
  const _PlacesPage({Key key}) : super(key: key);
  static const _initialPosition =
      CameraPosition(target: LatLng(4.6617833, -74.0507351), zoom: 16);

  @override
  Widget build(BuildContext context) {
    LocationService locationService = Provider.of<LocationService>(context);
    AuthStore authStore = Provider.of<AuthStore>(context);
    Completer<GoogleMapController> controller = useMemoized(() => Completer());
    // final cc = useState<GoogleMapController>();

    final _goToUserLocation = useMemoized(
        () => () async {
              final _controller = await controller.future;
              final location = await locationService.location;
              if (location != null) {
                _controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 16,
                  ),
                ));
              }
            },
        [controller]);

    final ticker = useSingleTickerProvider();
    final tabController =
        useMemoized(() => TabController(length: 3, vsync: ticker));
    return Scaffold(
      appBar: AppBar(
        title: Text("Places"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          IconButton(onPressed: () {}, icon: Icon(Icons.list)),
          IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
          ...getActions(authStore)
        ],
        bottom: TabBar(
          controller: tabController,
          labelColor: colorScheme.onPrimary,
          tabs: <Widget>[
            FlatButton(
                onPressed: null,
                child: Text("Map",
                    style: TextStyle(color: colorScheme.onPrimary))),
            FlatButton(
                onPressed: null,
                child: Text("List",
                    style: TextStyle(color: colorScheme.onPrimary))),
            FlatButton(
                onPressed: null,
                child: Text("Filter",
                    style: TextStyle(color: colorScheme.onPrimary))),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onCameraMove: (position) {},
            onMapCreated: (GoogleMapController _controller) {
              controller.complete(_controller);
            },
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            markers: <Marker>[
              Marker(
                markerId: MarkerId("-1"),
                consumeTapEvents: true,
                onTap: () async {
                  (await controller.future).showMarkerInfoWindow(MarkerId("-1"));
                },
                position: LatLng(4.6617833, -74.0507351),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                infoWindow: InfoWindow(
                  title: "Antiquarian",
                  snippet:
                      "Sunt quae consectetur voluptatibus maxime facere et culpa.",
                ),
              ),
              ...locations.map((e) {
                final markerId = MarkerId(e.key.toString());
                return Marker(
                  markerId: markerId,
                  consumeTapEvents: true,
                  onTap: () async {
                    (await controller.future).showMarkerInfoWindow(markerId);
                  },
                  position: LatLng(e.latitud, e.longitud),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(
                    title: e.name,
                    snippet: e.description,
                  ),
                );
              })
            ].toSet(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToUserLocation,
        label: Text('My Location'),
        icon: Icon(Icons.my_location),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }
}
