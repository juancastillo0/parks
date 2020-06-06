// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place-store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final typeId = 8;

  @override
  PlaceModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      latitud: fields[2] as double,
      longitud: fields[3] as double,
      description: fields[4] as String,
      rating: fields[6] as double,
      address: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.latitud)
      ..writeByte(3)
      ..write(obj.longitud)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.rating);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) {
  return PlaceModel(
    id: json['id'] as String,
    name: json['name'] as String,
    latitud: (json['latitud'] as num)?.toDouble(),
    longitud: (json['longitud'] as num)?.toDouble(),
    description: json['description'] as String,
    rating: (json['rating'] as num)?.toDouble() ?? 3.5,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'description': instance.description,
      'address': instance.address,
      'rating': instance.rating,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceStore on _PlaceStore, Store {
  Computed<ObservableList<PlaceModel>> _$placesListComputed;

  @override
  ObservableList<PlaceModel> get placesList => (_$placesListComputed ??=
          Computed<ObservableList<PlaceModel>>(() => super.placesList))
      .value;

  final _$placesAtom = Atom(name: '_PlaceStore.places');

  @override
  ObservableMap<String, PlaceModel> get places {
    _$placesAtom.context.enforceReadPolicy(_$placesAtom);
    _$placesAtom.reportObserved();
    return super.places;
  }

  @override
  set places(ObservableMap<String, PlaceModel> value) {
    _$placesAtom.context.conditionallyRunInAction(() {
      super.places = value;
      _$placesAtom.reportChanged();
    }, _$placesAtom, name: '${_$placesAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_PlaceStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$showListAtom = Atom(name: '_PlaceStore.showList');

  @override
  bool get showList {
    _$showListAtom.context.enforceReadPolicy(_$showListAtom);
    _$showListAtom.reportObserved();
    return super.showList;
  }

  @override
  set showList(bool value) {
    _$showListAtom.context.conditionallyRunInAction(() {
      super.showList = value;
      _$showListAtom.reportChanged();
    }, _$showListAtom, name: '${_$showListAtom.name}_set');
  }

  final _$fetchPlacesAsyncAction = AsyncAction('fetchPlaces');

  @override
  Future<dynamic> fetchPlaces() {
    return _$fetchPlacesAsyncAction.run(() => super.fetchPlaces());
  }

  @override
  String toString() {
    final string =
        'places: ${places.toString()},loading: ${loading.toString()},showList: ${showList.toString()},placesList: ${placesList.toString()}';
    return '{$string}';
  }
}
