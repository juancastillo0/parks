import 'package:json_annotation/json_annotation.dart';

part "model.g.dart";

@JsonSerializable()
class User {
  String userId;
  String name;

  User({this.name, this.userId});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
