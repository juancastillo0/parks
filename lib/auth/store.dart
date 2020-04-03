import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/routes.gr.dart';

part 'store.g.dart';

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
  final _auth = FirebaseAuth.instance;

  _AuthStore() {
    _auth.onAuthStateChanged.listen(updateUser);
  }

  @observable
  FirebaseUser user;
  @observable
  String error;
  @observable
  bool loading = false;

  @action
  updateUser(FirebaseUser _user) async {
    final wasLoggedIn = user != null;
    user = _user;
    loading = false;
    error = null;

    // Switch pages
    final currentRoute =
        _user != null || !wasLoggedIn ? Routes.home : Routes.auth;
    // Pop  all the stack
    ExtendedNavigator.rootNavigator
        .pushNamedAndRemoveUntil(currentRoute, (_) => false);
  }

  @action
  Future<void> signIn(String email, String password) async {
    if (loading) return;
    loading = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      error = ERROR_MESSAGES[e.code] ?? ERROR_MESSAGES["default"];
      loading = false;
    }
  }

  @action
  Future<void> signOut() {
    return _auth.signOut();
  }

  @action
  void resetError() {
    if (error != null) {
      error = null;
    }
  }
}
