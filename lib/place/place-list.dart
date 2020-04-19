import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/location-service.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:styled_widget/styled_widget.dart';

var _markers = (
  Completer<GoogleMapController> controller,
  ObservableMap<String, PlaceModel> places,
) =>
    <Marker>[
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
      ...places.values.map((e) {
        final markerId = MarkerId(e.id.toString());
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

Widget animateList(
  Widget list,
  BoxConstraints box,
  ValueNotifier<bool> showList,
) {
  return list
      .opacity(showList.value ? 1 : 0, animate: true)
      .positioned(
          top: showList.value ? 60 : box.maxHeight,
          left: (box.maxWidth - min(box.maxWidth - 26, 400)) / 2,
          animate: true)
      .animate(Duration(milliseconds: 200), Curves.easeInOut);
}

class PlacesPage extends HookWidget {
  const PlacesPage({Key key}) : super(key: key);
  static const _initialPosition =
      CameraPosition(target: LatLng(4.6617833, -74.0507351), zoom: 16);

  @override
  Widget build(ctx) {
    final store = useStore(ctx);
    LocationService locationService = store.locationService;
    Completer<GoogleMapController> controller = useMemoized(() => Completer());

    useEffect(() {
      store.placeStore.fetchPlaces();
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

    final _map = useMemoized(
      () => GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onCameraMove: (position) {},
        onMapCreated: (_controller) => controller.complete(_controller),
        myLocationButtonEnabled: true,
        mapToolbarEnabled: true,
        myLocationEnabled: true,
        markers: _markers(controller, store.placeStore.places),
      ),
    );

    final showList = useState(false);
    final mq = MediaQuery.of(ctx);
    final bigScreen = mq.size.width > 900;

    return Scaffold(
      appBar: DefaultAppBar(title: Text("Places")),
      bottomNavigationBar: DefaultBottomNavigationBar(),
      body: LayoutBuilder(
        builder: (_, box) => Observer(
          builder: (ctx) {
            final places = store.placeStore.places.values.toList();
            final _list = places.length == 0
                ? Center(
                    child: store.placeStore.loading
                        ? CircularProgressIndicator()
                        : Column(children: [
                            Text("There was a problem fetching the places"),
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () => store.placeStore.fetchPlaces(),
                            )
                          ]),
                  )
                : ListView.separated(
                    itemBuilder: (_, index) => index == 0
                        ? PlaceListTile(places[index]).padding(top: 20)
                        : index == places.length - 1
                            ? PlaceListTile(places[index]).padding(bottom: 20)
                            : PlaceListTile(places[index]),
                    separatorBuilder: (_, __) =>
                        Divider(height: 16, thickness: 1),
                    itemCount: places.length,
                  )
                    .backgroundColor(Colors.white)
                    .borderRadius(topLeft: bigScreen ? 0 : 10, topRight: 10)
                    .elevation(1)
                    .constrained(
                      maxWidth: min(box.maxWidth - 26, 400),
                      maxHeight:
                          bigScreen ? double.infinity : box.maxHeight - 60,
                    );

            return bigScreen
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.tune),
                            label: Text("Filter"),
                          ).constrained(height: 50),
                          _list.flexible()
                        ],
                      ),
                      _map.expanded()
                    ],
                  )
                : Stack(children: [_map, animateList(_list, box, showList)]);
          },
        ),
      ),
      floatingActionButton: bigScreen
          ? null
          : _ActionButtons(
              _goToUserLocation,
              showList,
            ),
    );
  }
}

class _ActionButtons extends HookWidget {
  const _ActionButtons(this.goToUserLocation, this.showList, {Key key})
      : super(key: key);
  final Function goToUserLocation;
  final ValueNotifier<bool> showList;

  @override
  Widget build(ctx) {
    final textStyle = Theme.of(ctx).textTheme.subtitle2.copyWith(fontSize: 16);
    return Stack(
      children: [
        FloatingActionButton.extended(
          heroTag: null,
          key: Key("Filter"),
          onPressed: goToUserLocation,
          label: Text("Filter", style: textStyle),
          icon: Icon(Icons.tune),
        ).positioned(bottom: 5, right: 5),
        FloatingActionButton.extended(
          heroTag: null,
          key: Key("List"),
          onPressed: () => showList.value = !showList.value,
          label: Text("List", style: textStyle),
          icon: Icon(Icons.list),
        ).positioned(bottom: 5, left: 36)
      ],
    );
  }
}

class PlaceListTile extends HookWidget {
  final PlaceModel place;
  PlaceListTile(this.place);

  @override
  Widget build(ctx) {
    final navigator = useNavigator(ctx);
    return ListTile(
      title:
          Text(place.name, style: Theme.of(ctx).textTheme.headline6).gestures(
        onTap: () => navigator.pushNamed(
          Routes.placeDetail,
          arguments: PlacePageArguments(place: place),
        ),
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
