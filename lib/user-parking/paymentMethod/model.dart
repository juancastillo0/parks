import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 5)
enum PaymentMethodType {
  @HiveField(0)
  Credit
}

@HiveType(typeId: 4)
@JsonSerializable()
class PaymentMethod {
  PaymentMethod({
    this.id,
    this.description,
    this.type,
    this.lastDigits,
    this.provider,
  });

  @HiveField(0)
  String description;

  @HiveField(1)
  @JsonKey(defaultValue: PaymentMethodType.Credit)
  PaymentMethodType type;

  @HiveField(2)
  String lastDigits;

  @HiveField(3)
  String provider;

  @HiveField(4)
  String id;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
