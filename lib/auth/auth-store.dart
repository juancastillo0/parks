import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/auth/auth-back.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.gr.dart';

part 'auth-store.freezed.dart';
part 'auth-store.g.dart';


@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.err(String message) = Error;
  const factory AuthState.loading() = Loading;
  const factory AuthState.none() = None;
}

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore(this._root) {
    reaction((r) => _backClient.isAuthorized, _updateStateBackClient);
    _updateStateBackClient(_backClient.isAuthorized);
  }
  final RootStore _root;
  final AuthBack _back = AuthBack();
  final BackClient _backClient = GetIt.I.get<BackClient>();

  @action
  _updateStateBackClient(bool authenticated) async {
    final nav = ExtendedNavigator.rootNavigator;
    if (authenticated) {
      _root.userStore.fetchUser();
      if (nav != null) nav.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } else {
      await _root.clearData();
      if (nav != null) nav.pushNamedAndRemoveUntil(Routes.auth, (_) => false);
    }
    state = AuthState.none();
  }

  @observable
  AuthState state = AuthState.none();

  @computed
  bool get isAuthenticated {
    return _backClient.isAuthorized;
  }

  @computed
  bool get isLoading {
    return state.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
  }

  @computed
  String get error {
    return state.maybeWhen(
      err: (err) => err,
      orElse: () => null,
    );
  }

  @action
  Future<void> signIn(String email, String password) async {
    if (isAuthenticated || isLoading) return;

    state = AuthState.loading();
    final res = await _back.signIn(email, password);
    res.when(
      (value) async => await _backClient.setToken(value),
      err: (err) => state = AuthState.err(err),
    );
  }

  @action
  Future<void> signUp(String name, String email, String password) async {
    if (isAuthenticated || isLoading) return;

    state = AuthState.loading();
    final res = await _back.signUp(name, email, password);
    res.when(
      (value) async => await _backClient.setToken(value),
      err: (err) => state = AuthState.err(err),
    );
  }

  @action
  signOut() async {
    await _backClient.setToken(null);
  }

  @action
  void resetError() {
    if (error != null) {
      state = AuthState.none();
    }
  }
}
