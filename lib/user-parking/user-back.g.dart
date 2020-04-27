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
      case 0:
        return RequestVariant.deleteVehicle;
      case 1:
        return RequestVariant.updateVehicle;
      case 2:
        return RequestVariant.createVehicle;
      case 3:
        return RequestVariant.deletePaymentMethod;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RequestVariant obj) {
    switch (obj) {
      case RequestVariant.deleteVehicle:
        writer.writeByte(0);
        break;
      case RequestVariant.updateVehicle:
        writer.writeByte(1);
        break;
      case RequestVariant.createVehicle:
        writer.writeByte(2);
        break;
      case RequestVariant.deletePaymentMethod:
        writer.writeByte(3);
        break;
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

  final _$handlingConnectionChangeAtom =
      Atom(name: '_UserBack.handlingConnectionChange');

  @override
  bool get handlingConnectionChange {
    _$handlingConnectionChangeAtom.context
        .enforceReadPolicy(_$handlingConnectionChangeAtom);
    _$handlingConnectionChangeAtom.reportObserved();
    return super.handlingConnectionChange;
  }

  @override
  set handlingConnectionChange(bool value) {
    _$handlingConnectionChangeAtom.context.conditionallyRunInAction(() {
      super.handlingConnectionChange = value;
      _$handlingConnectionChangeAtom.reportChanged();
    }, _$handlingConnectionChangeAtom,
        name: '${_$handlingConnectionChangeAtom.name}_set');
  }

  final _$handleConnectionChangeAsyncAction =
      AsyncAction('handleConnectionChange');

  @override
  Future handleConnectionChange(bool isConnected) {
    return _$handleConnectionChangeAsyncAction
        .run(() => super.handleConnectionChange(isConnected));
  }

  final _$deleteAllRequestsAsyncAction = AsyncAction('deleteAllRequests');

  @override
  Future deleteAllRequests() {
    return _$deleteAllRequestsAsyncAction.run(() => super.deleteAllRequests());
  }

  final _$_addRequestsAsyncAction = AsyncAction('_addRequests');

  @override
  Future<dynamic> _addRequests(UserRequest request) {
    return _$_addRequestsAsyncAction.run(() => super._addRequests(request));
  }

  final _$_deleteVehicleAsyncAction = AsyncAction('_deleteVehicle');

  @override
  Future<BackResult<String>> _deleteVehicle(UserRequest request, bool cache) {
    return _$_deleteVehicleAsyncAction
        .run(() => super._deleteVehicle(request, cache));
  }

  final _$_updateVehicleAsyncAction = AsyncAction('_updateVehicle');

  @override
  Future<BackResult<String>> _updateVehicle(UserRequest request, bool cache) {
    return _$_updateVehicleAsyncAction
        .run(() => super._updateVehicle(request, cache));
  }

  final _$_createVehicleAsyncAction = AsyncAction('_createVehicle');

  @override
  Future<BackResult<VehicleModel>> _createVehicle(
      UserRequest request, bool cache) {
    return _$_createVehicleAsyncAction
        .run(() => super._createVehicle(request, cache));
  }

  final _$_deletePaymentMethodAsyncAction = AsyncAction('_deletePaymentMethod');

  @override
  Future<BackResult<String>> _deletePaymentMethod(
      UserRequest request, bool cache) {
    return _$_deletePaymentMethodAsyncAction
        .run(() => super._deletePaymentMethod(request, cache));
  }

  @override
  String toString() {
    final string =
        'requests: ${requests.toString()},handlingConnectionChange: ${handlingConnectionChange.toString()}';
    return '{$string}';
  }
}
