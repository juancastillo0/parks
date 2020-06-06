import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'location-service.g.dart';

class LocationService = _LocationService with _$LocationService;

abstract class _LocationService with Store {
  final _location = Location();

  @observable
  bool serviceEnabled = false;
  @observable
  PermissionStatus permissionGranted = PermissionStatus.DENIED;

  @action
  Future<bool> hasPermission() async {
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.DENIED) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.GRANTED) {
        return false;
      }
    } else if (permissionGranted == PermissionStatus.DENIED_FOREVER) {
      return false;
    }
    return true;
  }

  Future<LocationData> get location async {
    if (await hasPermission()) {
      return await _location.getLocation();
    } else {
      return null;
    }
  }

  Future<Stream<LocationData>> get locationStream async {
    if (await hasPermission()) {
      return _location.onLocationChanged();
    } else {
      return null;
    }
  }
}
