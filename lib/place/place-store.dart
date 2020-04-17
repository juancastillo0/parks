import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';

part 'place-store.g.dart';

@jsonSerializable
@HiveType(typeId: 8)
class PlaceModel {
  @HiveField(0)
  String id;
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
    this.id,
    this.name,
    this.latitud,
    this.longitud,
    this.description,
    this.rating,
    this.address,
  });
}

class PlaceStore extends _PlaceStore with _$PlaceStore {}

abstract class _PlaceStore with Store {
  _PlaceStore() {
    box = getPlacesBox();
    places = ObservableMap.of(
      Map.fromEntries(box.values.map((e) => MapEntry(e.id, e))),
    );
  }

  Box<PlaceModel> box;

  @observable
  ObservableMap<String, PlaceModel> places;
}
