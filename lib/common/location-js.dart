@JS('navigator.geolocation') // navigator.geolocation namespace (Geolocation API)
library jslocation; // library name can be whatever you want

import 'dart:async';

import "package:js/js.dart";

@JS('getCurrentPosition') // Accessing method getCurrentPosition from Geolocation API
external void getCurrentPosition(
    Function(GeolocationPosition position) successCallback,
    Function(GeolocationPositionError error) errorCallback,
    PositionOptions options);

@JS('watchPosition') // Accessing method watchPosition from Geolocation API
external num watchPosition(
    Function(GeolocationPosition position) successCallback,
    Function(GeolocationPositionError error) errorCallback,
    PositionOptions options);

@JS('clearWatch') // Accessing method clearWatch from Geolocation API
external void clearWatch(num id);

@JS()
@anonymous
class GeolocationCoordinates {
  external double get latitude;
  external double get longitude;
  external double get altitude;
  external double get accuracy;
  external double get altitudeAccuracy;
  external double get heading;
  external double get speed;

  external factory GeolocationCoordinates(
      {double latitude,
      double longitude,
      double altitude,
      double accuracy,
      double altitudeAccuracy,
      double heading,
      double speed});
}

@JS()
@anonymous
// https://developer.mozilla.org/en-US/docs/Web/API/GeolocationPosition
class GeolocationPosition {
  external GeolocationCoordinates get coords;
  external num get timestamp;

  external factory GeolocationPosition(
      {GeolocationCoordinates coords, num timestamp});
}

@JS()
@anonymous
// https://developer.mozilla.org/en-US/docs/Web/API/GeolocationPositionError
class GeolocationPositionError {
  external num
      get code; // 1 == PERMISSION_DENIED, 2 == POSITION_UNAVAILABLE, 3 == TIMEOUT
  external String get message; // Debugging purposes

  external factory GeolocationPositionError({num code, String message});
}

@JS()
@anonymous
// https://developer.mozilla.org/en-US/docs/Web/API/PositionOptions
class PositionOptions {
  external bool get enableHighAccuracy;

  // Is a positive long value representing the maximum length of time (in milliseconds)
  // the device is allowed to take in order to return a position
  // Default: Infinity.
  external num get timeout;

  // Maximum age in milliseconds of a possible cached position that is acceptable to return.
  // If set to 0, it means that the device cannot use a cached position and must attempt to retrieve the real current position.
  // Default: 0.
  external num get maximumAge;

  external factory PositionOptions(
      {bool enableHighAccuracy, num timeout, num maximumAge});
}

Future<GeolocationPosition> getLocationJs({PositionOptions options}) {
  final completer = Completer<GeolocationPosition>();

  getCurrentPosition(allowInterop((l) {
    completer.complete(l);
    return;
  }), allowInterop((e) {
    completer.completeError(e);
    return;
  }), options);

  return completer.future;
}

Stream<GeolocationPosition> watchLocationJs({PositionOptions options}) {
  StreamController<GeolocationPosition> controller;
  num id;

  void _startWatch() {
    id = watchPosition(allowInterop((l) {
      controller.add(l);
      return;
    }), allowInterop((e) {
      controller.addError(e);
      controller.close();
      return;
    }), options);
  }

  void _clearWatch() {
    clearWatch(id);
  }

  controller = StreamController<GeolocationPosition>(
      onListen: _startWatch,
      onPause: _clearWatch,
      onResume: _startWatch,
      onCancel: _clearWatch);
  return controller.stream;
}
