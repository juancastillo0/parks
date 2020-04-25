// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-back.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestVariantAdapter extends TypeAdapter<RequestVariant> {
  @override
  final typeId = 9;

  @override
  RequestVariant read(BinaryReader reader) {
    switch (reader.readByte()) {
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RequestVariant obj) {
    switch (obj) {
    }
  }
}

class UserRequestAdapter extends TypeAdapter<UserRequest> {
  @override
  final typeId = 10;

  @override
  UserRequest read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRequest(
      fields[0] as RequestVariant,
      fields[1] as String,
      (fields[2] as Map)?.cast<String, dynamic>(),
      fields[3] as String,
    )..id = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, UserRequest obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.variant)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.jsonBody)
      ..writeByte(3)
      ..write(obj.successInfo)
      ..writeByte(4)
      ..write(obj.id);
  }
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserBack on _UserBack, Store {
  final _$requestsAtom = Atom(name: '_UserBack.requests');

  @override
  ObservableList<UserRequest> get requests {
    _$requestsAtom.context.enforceReadPolicy(_$requestsAtom);
    _$requestsAtom.reportObserved();
    return super.requests;
  }

  @override
  set requests(ObservableList<UserRequest> value) {
    _$requestsAtom.context.conditionallyRunInAction(() {
      super.requests = value;
      _$requestsAtom.reportChanged();
    }, _$requestsAtom, name: '${_$requestsAtom.name}_set');
  }

  final _$_handleConnectionChangeAsyncAction =
      AsyncAction('_handleConnectionChange');

  @override
  Future _handleConnectionChange(bool isConnected) {
    return _$_handleConnectionChangeAsyncAction
        .run(() => super._handleConnectionChange(isConnected));
  }

  @override
  String toString() {
    final string = 'requests: ${requests.toString()}';
    return '{$string}';
  }
}
