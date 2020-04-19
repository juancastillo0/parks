// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentMethod.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentMethodTypeAdapter extends TypeAdapter<PaymentMethodType> {
  @override
  final typeId = 5;

  @override
  PaymentMethodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentMethodType.Credit;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentMethodType obj) {
    switch (obj) {
      case PaymentMethodType.Credit:
        writer.writeByte(0);
        break;
    }
  }
}

class PaymentMethodAdapter extends TypeAdapter<PaymentMethod> {
  @override
  final typeId = 4;

  @override
  PaymentMethod read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentMethod(
      name: fields[0] as String,
      type: fields[1] as PaymentMethodType,
      lastDigits: fields[2] as String,
      provider: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentMethod obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.lastDigits)
      ..writeByte(3)
      ..write(obj.provider);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return PaymentMethod(
    name: json['description'] as String,
    type: _$enumDecodeNullable(_$PaymentMethodTypeEnumMap, json['type']) ??
        PaymentMethodType.Credit,
    lastDigits: json['lastDigits'] as String,
    provider: json['provider'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'description': instance.name,
      'type': _$PaymentMethodTypeEnumMap[instance.type],
      'lastDigits': instance.lastDigits,
      'provider': instance.provider,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.Credit: 'Credit',
};
