// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location-service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocationService on _LocationService, Store {
  final _$serviceEnabledAtom = Atom(name: '_LocationService.serviceEnabled');

  @override
  bool get serviceEnabled {
    _$serviceEnabledAtom.context.enforceReadPolicy(_$serviceEnabledAtom);
    _$serviceEnabledAtom.reportObserved();
    return super.serviceEnabled;
  }

  @override
  set serviceEnabled(bool value) {
    _$serviceEnabledAtom.context.conditionallyRunInAction(() {
      super.serviceEnabled = value;
      _$serviceEnabledAtom.reportChanged();
    }, _$serviceEnabledAtom, name: '${_$serviceEnabledAtom.name}_set');
  }

  final _$permissionGrantedAtom =
      Atom(name: '_LocationService.permissionGranted');

  @override
  PermissionStatus get permissionGranted {
    _$permissionGrantedAtom.context.enforceReadPolicy(_$permissionGrantedAtom);
    _$permissionGrantedAtom.reportObserved();
    return super.permissionGranted;
  }

  @override
  set permissionGranted(PermissionStatus value) {
    _$permissionGrantedAtom.context.conditionallyRunInAction(() {
      super.permissionGranted = value;
      _$permissionGrantedAtom.reportChanged();
    }, _$permissionGrantedAtom, name: '${_$permissionGrantedAtom.name}_set');
  }

  final _$hasPermissionAsyncAction = AsyncAction('hasPermission');

  @override
  Future<bool> hasPermission() {
    return _$hasPermissionAsyncAction.run(() => super.hasPermission());
  }

  @override
  String toString() {
    final string =
        'serviceEnabled: ${serviceEnabled.toString()},permissionGranted: ${permissionGranted.toString()}';
    return '{$string}';
  }
}
