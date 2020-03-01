// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place-store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    key: json['key'] as int,
    name: json['name'] as String,
    latitud: (json['latitud'] as num)?.toDouble(),
    longitud: (json['longitud'] as num)?.toDouble(),
    description: json['description'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    address: json['address'] as String,
    activities: (json['activities'] as List)
        ?.map((e) =>
            e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'description': instance.description,
      'rating': instance.rating,
      'address': instance.address,
      'activities': instance.activities,
    };
