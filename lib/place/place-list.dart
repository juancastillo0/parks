import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/routes.dart';
import 'package:styled_widget/styled_widget.dart';

Widget animateList(
  Widget list,
  BoxConstraints box,
  bool showList,
) {
  return list
      .positioned(
          top: showList ? 60 : box.maxHeight,
          left: (box.maxWidth - min(box.maxWidth - 26, 400)) / 2,
          animate: true)
      .animate(const Duration(milliseconds: 200), Curves.easeInOut);
}

final _markerIcon =
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

class PlacesPage extends HookWidget {
  const PlacesPage({Key key}) : super(key: key);
  static const _initialPosition =
      CameraPosition(target: LatLng(4.6617833, -74.0507351), zoom: 16);

  @override
  Widget build(ctx) {
    final store = useStore(ctx);
    final locationService = store.locationService;
    final Completer<GoogleMapController> controller =
        useMemoized(() => Completer());

    useEffect(() {
      store.placeStore.showList = false;
      store.placeStore.fetchPlaces();
      locationService.location;
      return null;
    }, []);

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
    final _mapKey = useMemoized(() => GlobalKey());
    final bigScreen = MediaQuery.of(ctx).size.width > 900;

    return Scaffold(
      appBar: const DefaultAppBar(title: Text("Places")),
      bottomNavigationBar: const DefaultBottomNavigationBar(),
      body: LayoutBuilder(
        builder: (_, box) {
          return Observer(
            builder: (ctx) {
              final places = store.placeStore.placesList;
              if (places.isEmpty) {
                return Center(
                  child: store.placeStore.loading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            const Text(
                              "There was a problem fetching the places",
                            ).padding(bottom: 10),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => store.placeStore.fetchPlaces(),
                            )
                          ],
                        ),
                );
              }

              final _list = ListView.separated(
                itemBuilder: (_, index) => index == 0
                    ? PlaceListTile(places[index]).padding(top: 20)
                    : index == places.length - 1
                        ? PlaceListTile(places[index]).padding(bottom: 80)
                        : PlaceListTile(places[index]),
                separatorBuilder: (_, __) =>
                    const Divider(height: 16, thickness: 1),
                itemCount: places.length,
              )
                  .backgroundColor(Colors.white)
                  .borderRadius(topLeft: bigScreen ? 0 : 10, topRight: 10)
                  .elevation(1)
                  .constrained(
                    maxWidth: min(box.maxWidth - 26, 400),
                    maxHeight: bigScreen ? double.infinity : box.maxHeight - 60,
                  );
              final navigator = Navigator.of(ctx);
              final markers = Set<Marker>.of(
                places.map((e) {
                  final markerId = MarkerId(e.id);
                  return Marker(
                    markerId: markerId,
                    consumeTapEvents: true,
                    onTap: () async {
                      (await controller.future).showMarkerInfoWindow(markerId);
                    },
                    position: LatLng(e.longitud, e.latitud),
                    icon: _markerIcon,
                    infoWindow: InfoWindow(
                      title: e.name,
                      snippet: e.description,
                      onTap: () => navigator.pushNamed(Routes.placeDetail(e)),
                    ),
                  );
                }),
              );

              print("building map");
              final _map = GoogleMap(
                key: _mapKey,
                mapType: MapType.normal,
                initialCameraPosition: _initialPosition,
                onCameraMove: (position) {},
                onMapCreated: (_controller) => controller.complete(_controller),
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                myLocationButtonEnabled: false,
                markers: markers,
              );

              return bigScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // FlatButton.icon(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.tune),
                            //   label: Text("Filter"),
                            // ).constrained(height: 50),
                            _list.flexible()
                          ],
                        ),
                        _map.expanded()
                      ],
                    )
                  : Stack(
                      children: [
                        _map,
                        RaisedButton(
                          onPressed: _goToUserLocation,
                          child: const Icon(Icons.my_location),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          color: Colors.white,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.all(0),
                        )
                            .opacity(0.8)
                            .constrained(width: 44, height: 44)
                            .positioned(top: 11, right: 11),
                        Observer(
                          builder: (ctx) => animateList(
                            _list,
                            box,
                            store.placeStore.showList,
                          ),
                        ),
                      ],
                    );
            },
          );
        },
      ),
      floatingActionButton: bigScreen
          ? null
          : _ActionButtons(
              _goToUserLocation,
              () => store.placeStore.showList = !store.placeStore.showList,
            ),
    );
  }
}

// class PlaceList extends HookWidget {
//   const PlaceList({Key key}) : super(key: key);
//   @override
//   Widget build(ctx) {
//     final placeStore = useStore(ctx).placeStore;

//     return Observer(builder: (ctx) {});
//   }
// }

class _ActionButtons extends HookWidget {
  const _ActionButtons(this.goToUserLocation, this.showList, {Key key})
      : super(key: key);
  final Function goToUserLocation;
  final void Function() showList;

  @override
  Widget build(ctx) {
    final textStyle = Theme.of(ctx).textTheme.subtitle2.copyWith(fontSize: 16);
    return Stack(
      children: [
        // FloatingActionButton(
        //   heroTag: null,
        //   key: Key("Location"),
        //   onPressed: goToUserLocation,
        //   child: Icon(Icons.my_location, ),
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        //   tooltip: "My Location",
        //   mini: true,
        // ).positioned(top: 130, right: 0),
        FloatingActionButton.extended(
          heroTag: null,
          key: const Key("List"),
          onPressed: showList,
          label: Text("List", style: textStyle),
          icon: const Icon(Icons.list),
        ).positioned(bottom: 5, left: 36)
      ],
    );
  }
}

class PlaceListTile extends HookWidget {
  final PlaceModel place;
  const PlaceListTile(this.place);

  @override
  Widget build(ctx) {
    final navigator = useNavigator(ctx);
    return ListTile(
      key: Key(place.id),
      title:
          Text(place.name, style: Theme.of(ctx).textTheme.headline6).gestures(
        onTap: () => navigator.pushNamed(Routes.placeDetail(place)),
      ),
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

// final _mId = MarkerId("fwff");
// markers.putIfAbsent(
//   _mId,
//   () => Marker(
//     markerId: _mId,
//     consumeTapEvents: true,
//     onTap: () async {
//       (await controller.future).showMarkerInfoWindow(_mId);
//     },
//     position: LatLng(4.6617833, -74.0507351),
//     icon: BitmapDescriptor.defaultMarkerWithHue(
//         BitmapDescriptor.hueRed),
//     infoWindow: InfoWindow(
//       title: "Acuar",
//       snippet:
//           "Et magnam eius impedit quos. Velit debitis sequi et eum. Sint consequatur expedita placeat accusantium.",
//     ),
//   ),
// );

// _markers(
//   Completer<GoogleMapController> controller,
//   ObservableMap<String, PlaceModel> places,
// ) {
//   return places.values.map((e) {
//     final markerId = MarkerId(e.id);
//     return Marker(
//       markerId: markerId,
//       consumeTapEvents: true,
//       onTap: () async {
//         (await controller.future).showMarkerInfoWindow(markerId);
//       },
//       position: LatLng(e.latitud, e.longitud),
//       icon: BitmapDescriptor.defaultMarkerWithHue(
//         BitmapDescriptor.hueRed,
//       ),
//       infoWindow: InfoWindow(
//         title: e.name,
//         snippet: e.description,
//       ),
//     );
//   }).toSet();
// }
