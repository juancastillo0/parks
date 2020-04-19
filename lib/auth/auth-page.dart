import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/auth/auth-store.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/validators/validators.dart';
import 'package:styled_widget/styled_widget.dart';

class AuthPage extends HookWidget {
  AuthPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(ctx) {
    final _email = useTextEditingController();
    final _password = useTextEditingController();
    final _name = useTextEditingController();
    final _password2 = useTextEditingController();
    final _formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final isSigningUp = useState(false);
    final autovalid = useState(false);
    final _isSigningUp = isSigningUp.value;
    final authStore = useAuthStore(ctx);
    final _authenticate = useMemoized(
      () => () async {
        final formState = _formKey.currentState;
        autovalid.value = true;
        if (formState.validate()) {
          if (_isSigningUp) {
            await authStore.signUp(_name.text, _email.text, _password.text);
          } else {
            await authStore.signIn(_email.text, _password.text);
          }
        }
      },
      [_isSigningUp],
    );

    if (authStore.isAuthenticated) {
      // Go to home if the user is logged in
      Future.delayed(Duration.zero, () {
        ExtendedNavigator.rootNavigator.pushNamed(Routes.home);
      });
      return Container(height: 0, width: 0);
    }
    final inputPadding = 25.0;

    return Scaffold(
      appBar: AppBar(title: Text(_isSigningUp ? "Sign up" : "Log in")),
      body: Center(
        child: Form(
          onChanged: () => authStore.resetError(),
          autovalidate: autovalid.value,
          key: _formKey,
          child: Container(
            width: 400,
            constraints: BoxConstraints.loose(Size(350, 800)),
            margin: EdgeInsets.only(left: 18, right: 18),
            child: ListView(
              children: <Widget>[
                // NAME AND EMAIL
                SizedBox(height: inputPadding),
                if (_isSigningUp)
                  TextFormField(
                    key: Key("name"),
                    controller: _name,
                    validator: StringValid(minLength: 3).firstError,
                    decoration: InputDecoration(labelText: "Name"),
                  ).padding(bottom: inputPadding),
                TextFormField(
                  key: Key("email"),
                  controller: _email,
                  validator: StringValid(
                    minLength: 5,
                    pattern: RegExp(r'^[\w]+@[\w]+(\.[\w]+)+$'),
                  ).firstError,
                  decoration: InputDecoration(labelText: "Email"),
                ).padding(bottom: inputPadding),
                // PASSWORDS

                TextFormField(
                  key: Key("password"),
                  controller: _password,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: StringValid(minLength: 3).firstError,
                  obscureText: true,
                ).padding(bottom: inputPadding),
                if (_isSigningUp)
                  TextFormField(
                    key: Key("password2"),
                    controller: _password2,
                    decoration: InputDecoration(
                      labelText: "Verification Password",
                    ),
                    validator: (password2) {
                      if (!_isSigningUp) return null;
                      if (password2.length == 0) return "Required";
                      if (password2 != _password.text)
                        return "The passwords don't match";
                      return null;
                    },
                    obscureText: true,
                  ).padding(bottom: inputPadding + 5),

                // SUBMIT BUTTON

                Observer(
                  builder: (_) {
                    return RaisedButton(
                      onPressed: authStore.isLoading ? null : _authenticate,
                      child: authStore.isLoading
                          ? LinearProgressIndicator()
                          : Text((_isSigningUp ? "Sign up" : "Log in")),
                    );
                  },
                ).padding(bottom: 14),

                // Backend error
                mainError(authStore),
                // Toggle _isSigningUp
                redirectSignInSignUp(
                  _isSigningUp,
                  () => isSigningUp.value = !_isSigningUp,
                ),
                // Continue with out auth
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Or")],
                ).padding(top: 8.0),
                continueNoAuth(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget continueNoAuth() {
    return FlatButton(
      onPressed: () => ExtendedNavigator.rootNavigator.pushNamed(Routes.home),
      child: Text("Continue without an account")
          .fontSize(16)
          .fontWeight(FontWeight.bold),
    );
  }

  Widget mainError(AuthStore authStore) {
    return Observer(
      builder: (_) {
        if (authStore.error != null)
          return Text(
            authStore.error,
            style: TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ).padding(bottom: 10);
        else
          return Container(height: 0, width: 0);
      },
    );
  }

  Widget redirectSignInSignUp(bool _isSigningUp, Function _toggleSignUp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_isSigningUp
                ? "¿You have an account?"
                : "¿You don't have an account?")
            .fontSize(16),
        InkWell(
          onTap: _toggleSignUp,
          child: Text(
            _isSigningUp ? "Log in" : "Sign up",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ).padding(all: 6),
      ],
    );
  }
}
