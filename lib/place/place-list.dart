import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/mock-data.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/main.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:styled_widget/styled_widget.dart';

var _markers = (Completer<GoogleMapController> controller) => <Marker>[
      Marker(
        markerId: MarkerId("-1"),
        consumeTapEvents: true,
        onTap: () async {
          (await controller.future).showMarkerInfoWindow(MarkerId("-1"));
        },
        position: LatLng(4.6617833, -74.0507351),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: "Antiquarian",
          snippet: "Sunt quae consectetur voluptatibus maxime facere et culpa.",
        ),
      ),
      ...mockPlaces.map((e) {
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
    ].toSet();

class PlacesPage extends HookWidget {
  const PlacesPage({Key key}) : super(key: key);
  static const _initialPosition =
      CameraPosition(target: LatLng(4.6617833, -74.0507351), zoom: 16);

  @override
  Widget build(ctx) {
    final store = useStore(ctx);
    LocationService locationService = store.locationService;
    AuthStore authStore = store.authStore;
    Completer<GoogleMapController> controller = useMemoized(() => Completer());

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
    );

    final ticker = useSingleTickerProvider();
    final tabController =
        useMemoized(() => TabController(length: 3, vsync: ticker));

    final _map = useMemoized(
      () => GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onCameraMove: (position) {},
        onMapCreated: (_controller) => controller.complete(_controller),
        myLocationButtonEnabled: true,
        mapToolbarEnabled: true,
        myLocationEnabled: true,
        markers: _markers(controller),
      ),
    );

    final showList = useState(false);
    final places = mockPlaces;

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
      body: LayoutBuilder(
        builder: (ctx, box) => Stack(
          children: [
            _map,
            ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (_, index) => PlaceListTile(places[index]),
              separatorBuilder: (_, __) => Divider(height: 16, thickness: 1),
              itemCount: places.length,
            )
                .backgroundColor(Colors.white)
                .elevation(1.5, angle: pi)
                .borderRadius(topLeft: 10, topRight: 10)
                .constraints(
                    maxWidth: min(box.maxWidth - 26, 400),
                    maxHeight: box.maxHeight - 60)
                .opacity(showList.value ? 1 : 0, animate: true)
                .positioned(
                    top: showList.value ? 60 : box.maxHeight,
                    left: (box.maxWidth - min(box.maxWidth - 26, 400)) / 2,
                    animate: true)
                .animate(Duration(milliseconds: 200), Curves.easeInOut),
            FloatingActionButton.extended(
              heroTag: null,
              key: Key("Filter"),
              onPressed: _goToUserLocation,
              label: Text("Filter",
                  style:
                      Theme.of(ctx).textTheme.subtitle2.copyWith(fontSize: 16)),
              icon: Icon(Icons.tune),
            ).positioned(bottom: 20, right: 20),
            FloatingActionButton.extended(
              heroTag: null,
              key: Key("List"),
              onPressed: () => showList.value = !showList.value,
              label: Text("List",
                  style:
                      Theme.of(ctx).textTheme.subtitle2.copyWith(fontSize: 16)),
              icon: Icon(Icons.list),
            ).positioned(bottom: 20, left: 20)
          ],
        ),
      ),
    );
  }
}

class PlaceListTile extends HookWidget {
  final Place place;
  PlaceListTile(this.place);

  @override
  Widget build(ctx) {
    final navigator = useNavigator(context: ctx);
    return ListTile(
      title: Text(place.name, style: useTextTheme().headline6).gestures(
          onTap: () => navigator.pushNamed(
                Routes.placeDetail,
                arguments: PlacePageArguments(place: place),
              )),
      leading: Text(place.rating.toString()),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            place.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ).padding(bottom: 14, top: 7),
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
