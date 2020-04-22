import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/auth/auth-store.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/widgets.dart';
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
    final _phone = useTextEditingController();
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
            await authStore.signUp(
                _name.text, _email.text, _password.text, _phone.text);
          } else {
            await authStore.signIn(_email.text, _password.text);
          }
        }
      },
      [_isSigningUp],
    );

    if (authStore.isAuthenticated) {
      Future.delayed(Duration.zero, () {
        ExtendedNavigator.rootNavigator.pushNamed(Routes.home);
      });
      return Container(height: 0, width: 0);
    }
    final inputPadding = 10.0;
    final isBigScreen = MediaQuery.of(ctx).size.width > 550;
    final constrainedWidth =
        _isSigningUp && isBigScreen ? 210 : double.infinity;

    return Scaffold(
      appBar: AppBar(title: Text(_isSigningUp ? "Sign up" : "Log in")),
      body: MaterialResponsiveWrapper(
        breakpoint: _isSigningUp ? 600 : 500,
        child: Form(
          onChanged: () => authStore.resetError(),
          autovalidate: autovalid.value,
          key: _formKey,
          child: Container(
            width: _isSigningUp && isBigScreen ? 450 : 350,
            margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                // NAME AND EMAIL
                SizedBox(height: inputPadding),
                if (_isSigningUp)
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: _name,
                        validator: StringValid(minLength: 3).firstError,
                        decoration: InputDecoration(
                            labelText: "Name", counterText: "-"),
                      )
                          .padding(bottom: inputPadding)
                          .constrained(maxWidth: constrainedWidth),
                      TextFormField(
                        controller: _phone,
                        validator: StringValid(
                          minLength: 5,
                          pattern: RegExp(r'^[0-9]+$'),
                        ).firstError,
                        decoration: InputDecoration(
                            labelText: "Phone", counterText: "-"),
                        keyboardType: TextInputType.phone,
                      )
                          .padding(bottom: inputPadding)
                          .constrained(maxWidth: constrainedWidth)
                    ],
                  ),
                TextFormField(
                  controller: _email,
                  validator: StringValid(
                    minLength: 5,
                    pattern: RegExp(r'^[\w]+@[\w]+(\.[\w]+)+$'),
                  ).firstError,
                  decoration:
                      InputDecoration(labelText: "Email", counterText: "-"),
                  keyboardType: TextInputType.emailAddress,
                ).padding(bottom: inputPadding),
                // PASSWORDS
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                          labelText: "Password", counterText: "-"),
                      validator: StringValid(minLength: 3).firstError,
                      obscureText: true,
                    )
                        .padding(bottom: inputPadding)
                        .constrained(maxWidth: constrainedWidth),
                    if (_isSigningUp)
                      TextFormField(
                        controller: _password2,
                        decoration: InputDecoration(
                            labelText: "Verification Password",
                            counterText: "-"),
                        validator: (password2) {
                          if (!_isSigningUp) return null;
                          if (password2.length == 0) return "Required";
                          if (password2 != _password.text)
                            return "The passwords don't match";
                          return null;
                        },
                        obscureText: true,
                      )
                          .padding(bottom: inputPadding + 5)
                          .constrained(maxWidth: constrainedWidth),
                  ],
                ),

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
