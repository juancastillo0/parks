// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool> _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated => (_$isAuthenticatedComputed ??=
          Computed<bool>(() => super.isAuthenticated))
      .value;

  final _$_updateStateBackClientAsyncAction =
      AsyncAction('_updateStateBackClient');

  @override
  Future<dynamic> _updateStateBackClient(bool authenticated) {
    return _$_updateStateBackClientAsyncAction
        .run(() => super._updateStateBackClient(authenticated));
  }

  final _$signInAsyncAction = AsyncAction('signIn');

  @override
  Future<String> signIn(String email, String password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  final _$signUpAsyncAction = AsyncAction('signUp');

  @override
  Future<String> signUp(
      String name, String email, String password, String phone) {
    return _$signUpAsyncAction
        .run(() => super.signUp(name, email, password, phone));
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  Future<dynamic> signOut() {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.signOut();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isAuthenticated: ${isAuthenticated.toString()}';
    return '{$string}';
  }
}
