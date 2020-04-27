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

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

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

    final rootStore = useStore();
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
              _name.text,
              _email.text.toLowerCase().replaceAll(" ", ""),
              _password.text,
              _phone.text.replaceAll(" ", ""),
            );
          } else {
            await authStore.signIn(
              _email.text.toLowerCase().replaceAll(" ", ""),
              _password.text,
            );
          }
        }
      },
      [_isSigningUp],
    );

    if (authStore.isAuthenticated) {
      print("authenticated ///////////////////////////////");
      Future.delayed(Duration.zero, () {
        ExtendedNavigator.rootNavigator.pushNamed(Routes.home);
      });
      return Container(height: 0, width: 0);
    }
    final inputPadding = 10.0;
    final isBigScreen = MediaQuery.of(ctx).size.width > 550;
    final constrainedWidth =
        _isSigningUp && isBigScreen ? 210 : double.infinity;

    if (!rootStore.client.isConnected && !rootStore.client.isAuthorized) {
      // Not authorized, not connected and not in home (maybe in auth), then go to home
      print("other ///////////////////////////////");
      Future.delayed(
        Duration.zero,
        () => Navigator.of(ctx).pushNamedAndRemoveUntil(
          Routes.home,
          (_) => false,
        ),
      );
    }

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
            margin: EdgeInsets.only(left: 25, right: 25),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 25),
                // NAME AND EMAIL
                SizedBox(height: inputPadding),
                if (_isSigningUp)
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: _name,
                        validator: StringValid(
                          minLength: 3,
                          maxLength: 50,
                        ).firstError,
                        maxLength: 50,
                        decoration: InputDecoration(
                          labelText: "Name",
                          counterText: "-",
                          prefixIcon: Icon(Icons.person),
                        ),
                      )
                          .padding(bottom: inputPadding)
                          .constrained(maxWidth: constrainedWidth),
                      TextFormField(
                        controller: _phone,
                        maxLength: 10,
                        validator: (v) => StringValid(
                          minLength: 7,
                          maxLength: 10,
                          pattern: RegExp(r'^[0-9]+$'),
                        ).valid(v)
                            ? null
                            : "Invalid phone number",
                        decoration: InputDecoration(
                          labelText: "Phone",
                          counterText: "-",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      )
                          .padding(bottom: inputPadding)
                          .constrained(maxWidth: constrainedWidth)
                    ],
                  ),
                TextFormField(
                  controller: _email,
                  validator: (v) => StringValid(
                    minLength: 5,
                    maxLength: 256,
                    pattern: RegExp(EMAIL_REGEX),
                  ).valid(v)
                      ? null
                      : "Invalid email address",
                  maxLength: 256,
                  decoration: InputDecoration(
                    labelText: "Email",
                    counterText: "-",
                    prefixIcon: Icon(Icons.email),
                  ),
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
                        labelText: "Password",
                        counterText: "-",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      maxLength: 256,
                      validator: StringValid(
                        minLength: 3,
                        maxLength: 256,
                      ).firstError,
                      obscureText: true,
                    )
                        .padding(bottom: inputPadding)
                        .constrained(maxWidth: constrainedWidth),
                    if (_isSigningUp)
                      TextFormField(
                        controller: _password2,
                        maxLength: 256,
                        decoration: InputDecoration(
                          labelText: "Verification Password",
                          counterText: "-",
                        ),
                        validator: (password2) {
                          if (!_isSigningUp) return null;
                          if (password2.length == 0) return "Required";
                          if (password2 != _password.text)
                            return "The passwords don't match";
                          return StringValid(
                            minLength: 3,
                            maxLength: 256,
                          ).firstError(password2);
                        },
                        obscureText: true,
                      )
                          .padding(bottom: inputPadding + 5)
                          .constrained(maxWidth: constrainedWidth),
                  ],
                ),
                //
                // ---------------  SUBMIT BUTTON
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
                SizedBox(height: 25),
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
