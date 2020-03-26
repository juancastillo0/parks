import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/auth/store.dart';
import 'package:parks/routes.gr.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email, _password, _name, _password2;
  final _formKey = GlobalKey<FormState>();
  AuthStore authStore;
  // Is signing up or logging in
  var _isSigningUp = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Dependency injection
    authStore = Provider.of<AuthStore>(context, listen: false);
    if (authStore.user != null) {
      // Go to home if the user is logged in
      Future.delayed(Duration.zero, () {
        ExtendedNavigator.rootNavigator.pushNamed(Routes.home);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSigningUp ? "Sign up" : "Log in"),
      ),
      body: Center(
        child: Form(
          onChanged: () => authStore.resetError(),
          key: _formKey,
          child: Container(
            width: 400,
            constraints: BoxConstraints.loose(Size(350, 800)),
            margin: EdgeInsets.only(left: 18, right: 18),
            child: ListView(
              children: <Widget>[
                // NAME AND EMAIL

                if (_isSigningUp)
                  TextFormField(
                    key: Key("name"),
                    onSaved: (name) => _name = name,
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                TextFormField(
                  key: Key("email"),
                  onSaved: (email) => _email = email,
                  decoration: InputDecoration(labelText: "Email"),
                ),

                // PASSWORDS

                TextFormField(
                  key: Key("password"),
                  onSaved: (password) => _password = password,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                if (_isSigningUp)
                  TextFormField(
                    key: Key("password2"),
                    onSaved: (password2) => _password2 = password2,
                    decoration:
                        InputDecoration(labelText: "Verification Password"),
                    validator: (password2) {
                      if (!_isSigningUp) return null;
                      if (password2.length == 0) return "Required";
                      if (password2 != _password)
                        return "The passwords don't match";
                      return null;
                    },
                    obscureText: true,
                  ),

                // SUBMIT BUTTON

                Observer(
                    builder: (_) => RaisedButton(
                          onPressed: authStore.loading ? null : _authenticate,
                          child: authStore.loading
                              ? LinearProgressIndicator()
                              : Text((_isSigningUp ? "Sign up" : "Log in")),
                        )).padding(top: 24, bottom: 14),

                // Backend error
                mainError(),
                // Toggle _isSigningUp
                redirectSignInSignUp(),
                // Continue with out auth
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text("Or")],
                ).padding(top: 8.0),
                continueNoAuth(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authenticate() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      authStore.signIn(_email, _password);
    }
  }

  void _toggleSignUp() {
    setState(() {
      _isSigningUp = !_isSigningUp;
    });
  }

  Widget continueNoAuth() {
    return FlatButton(
      onPressed: () => ExtendedNavigator.rootNavigator.pushNamed(
        Routes.home,
      ),
      child: Text("Continue without an account")
          .fontSize(16)
          .fontWeight(FontWeight.bold),
    );
  }

  Widget mainError() {
    return Observer(
      builder: (_) {
        return (authStore.error != null
            ? Text(
                authStore.error,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ).padding(bottom: 10)
            : Container());
      },
    );
  }

  Widget redirectSignInSignUp() {
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
