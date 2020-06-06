import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/auth/auth-back.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.dart';

part 'auth-store.g.dart';

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
  Future _updateStateBackClient(bool authenticated) async {
    final nav = getNavigator();
    if (authenticated) {
      _root.userStore.fetchUser();
      if (nav != null) nav.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } else {
      await _root.clearData();
      if (nav != null) nav.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    }
  }

  @computed
  bool get isAuthenticated {
    return _backClient.isAuthorized;
  }

  @action
  Future<String> signIn(String email, String password) async {
    if (isAuthenticated) return null;

    final fcmToken = await _root.notificationService.getToken();
    final res = await _back.signIn(email, password, fcmToken);
    return res.okOrError(
      _backClient.setToken,
      unauthorized: null,
    );
  }

  @action
  Future<String> signUp(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    if (isAuthenticated) return null;

    final fcmToken = await _root.notificationService.getToken();
    final res = await _back.signUp(name, email, password, phone, fcmToken);
    return res.okOrError(
      _backClient.setToken,
      unauthorized: null,
    );
  }

  @action
  Future signOut() => _backClient.setToken(null);
}
