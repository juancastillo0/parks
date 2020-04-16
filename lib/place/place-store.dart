import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:hive/hive.dart';

part 'place-store.g.dart';

@jsonSerializable 
@HiveType(typeId: 8)
class PlaceModel {
  @HiveField(0)
  int key;
  @HiveField(1)
  String name;
  @HiveField(2)
  double latitud;
  @HiveField(3)
  double longitud;
  @HiveField(4)
  String description;
  @HiveField(5)
  String address;
  @HiveField(6)
  double rating;

  PlaceModel({
    this.key,
    this.name,
    this.latitud,
    this.longitud,
    this.description,
    this.rating,
    this.address,
  });
}
