import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/main.dart';
import 'package:parks/place/place-store.dart';
import 'package:styled_widget/styled_widget.dart';

class PlacesPage extends HookWidget {
  const PlacesPage({Key key}) : super(key: key);
  static const _initialPosition =
      CameraPosition(target: LatLng(4.6617833, -74.0507351), zoom: 16);

  @override
  Widget build(BuildContext context) {
    final store = useStore(context);
    LocationService locationService = store.locationService;
    AuthStore authStore = store.authStore;
    Completer<GoogleMapController> controller = useMemoized(() => Completer());
    // final cc = useState<GoogleMapController>();

    final _goToUserLocation = useMemoized(
      () => () async {
        final location = await locationService.location;
        if (location != null) {
          (await controller.future).animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(location.latitude, location.longitude),
                zoom: 16,
              ),
            ),
          );
        }
      },
      [controller],
    );

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
          tabs: placesTabs,
        ),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(),
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
                  (await controller.future)
                      .showMarkerInfoWindow(MarkerId("-1"));
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
              ...places.map((e) {
                final markerId = MarkerId(e.key.toString());
                return Marker(
                  markerId: markerId,
                  consumeTapEvents: true,
                  onTap: () async {
                    (await controller.future).showMarkerInfoWindow(markerId);
                  },
                  position: LatLng(e.latitud, e.longitud),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
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
    );
  }
}

class PlaceListTile extends HookWidget {
  final Place place;
  PlaceListTile(this.place);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name, style: useTextTheme().headline6),
      leading: Text(place.rating.toString()),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            place.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ).padding(bottom: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(place.address),
            ],
          ),
        ],
      ),
    ).padding(bottom: 8);
  }
}

var placesTabs = [
  FlatButton(
      onPressed: null,
      child: Text("Map", style: TextStyle(color: colorScheme.onPrimary))),
  FlatButton(
      onPressed: null,
      child: Text("List", style: TextStyle(color: colorScheme.onPrimary))),
  FlatButton(
      onPressed: null,
      child: Text("Filter", style: TextStyle(color: colorScheme.onPrimary))),
];
