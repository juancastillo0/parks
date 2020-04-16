import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/auth/auth-back.dart';
import 'package:parks/routes.gr.dart';

part 'auth-store.freezed.dart';
part 'auth-store.g.dart'; 

const ERROR_MESSAGES = {
  "ERROR_INVALID_EMAIL": "Correo inválido",
  "ERROR_WRONG_PASSWORD": "La combinación correo y contraseña no es válida",
  "ERROR_USER_NOT_FOUND": "No existen cuentas con este correo",
  "ERROR_USER_DISABLED": "La cuenta fue eliminada",
  "ERROR_TOO_MANY_REQUESTS":
      "Has realizado muchas peticiones, por favor intenta de nuevo más tarde",
  "default":
      "Hubo un error en el servidor, por favor intenta de nuevo más tarde"
};

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState(String token) = Authenticated;
  const factory AuthState.err(String message) = Error;
  const factory AuthState.loading() = Loading;
  const factory AuthState.none() = None;
}

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthBack back = AuthBack();

  @observable
  AuthState state = AuthState.none();

  @computed
  bool get isAuthenticated {
    return state.maybeWhen(
      (token) => true,
      orElse: () => false,
    );
  }

  @computed
  bool get isLoading {
    return state.maybeWhen(
      (token) => false,
      loading: () => true,
      orElse: () => false,
    );
  }

  @computed
  String get error {
    return state.maybeWhen(
      (token) => null,
      err: (err) => err,
      orElse: () => null,
    );
  }

  @action
  updateToken(String token) async {
    state = AuthState(token);

    if (ExtendedNavigator.rootNavigator != null) {
      // Pop all the stack
      ExtendedNavigator.rootNavigator
          .pushNamedAndRemoveUntil(Routes.home, (_) => false);
    }
  }

  @action
  Future<void> signIn(String email, String password) async {
    if (state.maybeWhen((token) => true, orElse: () => false)) return;
    state = AuthState.loading();
    try {
      final res = await back.signIn(email, password);
      res.when(
        (value) => updateToken(value),
        err: (err) => state = AuthState.err(err),
      );
    } catch (e) {
      print(e);
      state =
          AuthState.err( ERROR_MESSAGES["default"]);
    }
  }

  @action
  Future<void> signUp(String name, String email, String password) async {
    if (isLoading) return;
    state = AuthState.loading();
    try {
      final res = await back.signUp(name, email, password);
      res.when(
        (value) => updateToken(value),
        err: (err) => state = AuthState.err(err),
      );
    } catch (e) {
      print(e);
      state =
          AuthState.err( ERROR_MESSAGES["default"]);
    }
  }

  @action
  void signOut() {
    state = AuthState.none();

    if (ExtendedNavigator.rootNavigator != null) {
      // Pop all the stack
      ExtendedNavigator.rootNavigator
          .pushNamedAndRemoveUntil(Routes.auth, (_) => false);
    }
  }

  @action
  void resetError() {
    if (error != null) {
      state = AuthState.none();
    }
  }
}
