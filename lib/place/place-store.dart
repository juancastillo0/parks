import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/hive-utils.dart';
import 'package:parks/place/place-back.dart';

part 'place-store.g.dart';

@JsonSerializable()
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
  @JsonKey(defaultValue: 3.5)
  double rating;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);

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
    _box = getPlacesBox();
    places = ObservableMap.of(
      Map.fromEntries(_box.values.map((e) => MapEntry(e.id, e))),
    );
    fetchPlaces();
  }

  PlaceBack _back = PlaceBack();
  Box<PlaceModel> _box;

  @observable
  ObservableMap<String, PlaceModel> places;
  @observable
  bool loading = false;

  @action
  Future fetchPlaces() async {
    if (loading) return asyncWhen((r) => !loading);
    loading = true;
    final resp = await _back.places();
    final p = resp.okOrNull();
    if (p != null) {
      final map = Map.fromEntries(p.map((e) => MapEntry(e.id, e)));
      places.addAll(map);
      await _box.putAll(map);
    }
    loading = false;
  }
}
