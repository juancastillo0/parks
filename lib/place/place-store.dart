import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Place {
  int key;
  String name;
  double latitud;
  double longitud;
  String description;
  double rating;
  String address;

  Place({
    this.key,
    this.name,
    this.latitud,
    this.longitud,
    this.description,
    this.rating,
    this.address,
  });
}


