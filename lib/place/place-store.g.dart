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
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceStore on _PlaceStore, Store {
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

  final _$fetchPlacesAsyncAction = AsyncAction('fetchPlaces');

  @override
  Future fetchPlaces() {
    return _$fetchPlacesAsyncAction.run(() => super.fetchPlaces());
  }

  @override
  String toString() {
    final string = 'places: ${places.toString()}';
    return '{$string}';
  }
}
