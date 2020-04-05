import 'package:auto_route/auto_route.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/routes.gr.dart';

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

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  String token;
  @observable
  String error;
  @observable
  bool loading = false;

  @action
  updateToken(String _token) async {
    final wasLoggedIn = token != null;
    token = _token;
    loading = false;
    error = null;

    // Switch pages
    final currentRoute =
        _token != null || !wasLoggedIn ? Routes.home : Routes.auth;

    // Pop  all the stack
    if (ExtendedNavigator.rootNavigator != null) {
      ExtendedNavigator.rootNavigator
          .pushNamedAndRemoveUntil(currentRoute, (_) => false);
    }
  }

  @action
  Future<void> signIn(String email, String password) async {
    if (loading) return;
    loading = true;
    try {} catch (e) {
      error = ERROR_MESSAGES[e.code] ?? ERROR_MESSAGES["default"];
      loading = false;
    }
  }

  @action
  void signOut() {
    updateToken(null);
  }

  @action
  void resetError() {
    if (error != null) {
      error = null;
    }
  }
}
