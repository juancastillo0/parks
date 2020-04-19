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
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading)).value;
  Computed<String> _$errorComputed;

  @override
  String get error =>
      (_$errorComputed ??= Computed<String>(() => super.error)).value;

  final _$stateAtom = Atom(name: '_AuthStore.state');

  @override
  AuthState get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$_updateStateBackClientAsyncAction =
      AsyncAction('_updateStateBackClient');

  @override
  Future _updateStateBackClient(bool authenticated) {
    return _$_updateStateBackClientAsyncAction
        .run(() => super._updateStateBackClient(authenticated));
  }

  final _$signInAsyncAction = AsyncAction('signIn');

  @override
  Future<void> signIn(String email, String password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  final _$signUpAsyncAction = AsyncAction('signUp');

  @override
  Future<void> signUp(String name, String email, String password) {
    return _$signUpAsyncAction.run(() => super.signUp(name, email, password));
  }

  final _$signOutAsyncAction = AsyncAction('signOut');

  @override
  Future signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void resetError() {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.resetError();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'state: ${state.toString()},isAuthenticated: ${isAuthenticated.toString()},isLoading: ${isLoading.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
