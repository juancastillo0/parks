import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/scaffold.dart';
import 'package:provider/provider.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PlacesPage();
  }
}

class _PlacesPage extends HookWidget {
  const _PlacesPage({Key key}) : super(key: key);
  static const _initialPosition =
      CameraPosition(target: LatLng(4.6617833, -74.0507351), zoom: 16);

  @override
  Widget build(BuildContext context) {
    LocationService locationService = Provider.of<LocationService>(context);
    AuthStore authStore = Provider.of<AuthStore>(context);
    Completer<GoogleMapController> controller = useMemoized(() => Completer());

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
          IconButton(onPressed: null, icon: Icon(Icons.map)),
          IconButton(onPressed: () {}, icon: Icon(Icons.list)),
          IconButton(onPressed: null, icon: Icon(Icons.tune)),
          ...getActions(authStore)
        ],
        bottom: TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.white,
          tabs: <Widget>[
            FlatButton(onPressed: () {}, child: Text("Map")),
            FlatButton(onPressed: null, child: Text("List")),
            FlatButton(onPressed: null, child: Text("Filter")),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController _controller) {
              controller.complete(_controller);
            },
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToUserLocation,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }
}
