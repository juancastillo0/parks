import 'package:json_annotation/json_annotation.dart';
import 'package:parks/activity/store.dart';
import 'package:parks/place/place-store.dart';

part "model.g.dart";

@JsonSerializable()
class User {
  String userId;
  String name;
  String email;
  List<Activity> publishedActivities;
  List<Activity> activities;
  List<Place> places;

  User(
      {this.name,
      this.userId,
      this.email,
      this.activities: const [],
      this.places: const [],
      this.publishedActivities: const []});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
