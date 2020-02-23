// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    name: json['name'] as String,
    description: json['description'] as String,
    type: json['type'] as String,
    participants: json['participants'] as int,
    maxParticipants: json['maxParticipants'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    city: json['city'] as String,
    address: json['address'] as String,
    fullDescription: json['fullDescription'] as String,
  )..key = json['key'] as int;
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'participants': instance.participants,
      'maxParticipants': instance.maxParticipants,
      'date': instance.date?.toIso8601String(),
      'city': instance.city,
      'address': instance.address,
      'fullDescription': instance.fullDescription,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActivitiesStore on _ActivitiesStore, Store {
  final _$activitiesAtom = Atom(name: '_ActivitiesStore.activities');

  @override
  ObservableList<Activity> get activities {
    _$activitiesAtom.context.enforceReadPolicy(_$activitiesAtom);
    _$activitiesAtom.reportObserved();
    return super.activities;
  }

  @override
  set activities(ObservableList<Activity> value) {
    _$activitiesAtom.context.conditionallyRunInAction(() {
      super.activities = value;
      _$activitiesAtom.reportChanged();
    }, _$activitiesAtom, name: '${_$activitiesAtom.name}_set');
  }

  final _$fetchingAtom = Atom(name: '_ActivitiesStore.fetching');

  @override
  bool get fetching {
    _$fetchingAtom.context.enforceReadPolicy(_$fetchingAtom);
    _$fetchingAtom.reportObserved();
    return super.fetching;
  }

  @override
  set fetching(bool value) {
    _$fetchingAtom.context.conditionallyRunInAction(() {
      super.fetching = value;
      _$fetchingAtom.reportChanged();
    }, _$fetchingAtom, name: '${_$fetchingAtom.name}_set');
  }

  final _$indexAtom = Atom(name: '_ActivitiesStore.index');

  @override
  int get index {
    _$indexAtom.context.enforceReadPolicy(_$indexAtom);
    _$indexAtom.reportObserved();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.context.conditionallyRunInAction(() {
      super.index = value;
      _$indexAtom.reportChanged();
    }, _$indexAtom, name: '${_$indexAtom.name}_set');
  }

  final _$fetchMoreAsyncAction = AsyncAction('fetchMore');

  @override
  Future fetchMore() {
    return _$fetchMoreAsyncAction.run(() => super.fetchMore());
  }

  @override
  String toString() {
    final string =
        'activities: ${activities.toString()},fetching: ${fetching.toString()},index: ${index.toString()}';
    return '{$string}';
  }
}
