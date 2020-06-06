import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/validators/validators.dart';
import 'package:styled_widget/styled_widget.dart';

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

class AuthPage extends HookWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final _email = useTextEditingController();
    final _password = useTextEditingController();
    final _name = useTextEditingController();
    final _password2 = useTextEditingController();
    final _phone = useTextEditingController();
    final _formKey = useMemoized(() => GlobalKey<FormState>(), []);

    final rootStore = useStore(ctx);
    final isSigningUp = useState(false);
    final autovalid = useState(false);
    final _isSigningUp = isSigningUp.value;
    final authStore = rootStore.authStore;

    void goToHome() =>
        Navigator.of(ctx).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    final state = useState(RequestState.none());

    final _authenticate = useMemoized(
      () => () async {
        final formState = _formKey.currentState;
        autovalid.value = true;
        if (formState.validate()) {
          state.value = RequestState.loading();
          String err;
          if (_isSigningUp) {
            err = await authStore.signUp(
              _name.text.trim(),
              _email.text.toLowerCase().replaceAll(" ", ""),
              _password.text,
              _phone.text.replaceAll(" ", ""),
            );
          } else {
            err = await authStore.signIn(
              _email.text.toLowerCase().replaceAll(" ", ""),
              _password.text,
            );
          }
          if (err != null) {
            state.value = RequestState.err(err);
          } else {
            state.value = RequestState.none();
          }
        }
      },
      [_isSigningUp],
    );

    // if (authStore.isAuthenticated) {
    //   Future.delayed(Duration.zero, goToHome);
    //   return Container(height: 0, width: 0);
    // } else if (!rootStore.client.isConnected &&
    //     !rootStore.client.isAuthorized) {
    //   // Not authorized, not connected and not in home (maybe in auth), then go to home
    //   rootStore.showInfo(SnackBar(
    //     content: Text("You don't have an internet connection, "
    //         "we can't log you in or register your account."),
    //   ));
    //   Future.delayed(Duration.zero, goToHome);
    // }

    void _clearError() {
      if (state.value.isError) state.value = RequestState.none();
    }

    const inputPadding = 10.0;
    final isBigScreen = MediaQuery.of(ctx).size.width > 550;
    final constrainedWidth =
        _isSigningUp && isBigScreen ? 210.0 : double.infinity;

    return Scaffold(
      appBar: AppBar(title: Text(_isSigningUp ? "Sign up" : "Log in")),
      bottomNavigationBar: const DefaultBottomNavigationBar(show: false),
      body: MaterialResponsiveWrapper(
        breakpoint: _isSigningUp ? 600 : 500,
        child: Form(
          onChanged: _clearError,
          autovalidate: autovalid.value,
          key: _formKey,
          child: Container(
            width: _isSigningUp && isBigScreen ? 450 : 350,
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const SizedBox(height: 25),

                // NAME AND EMAIL
                const SizedBox(height: inputPadding),
                if (_isSigningUp)
                  _NameAndPhone(
                    name: _name,
                    inputPadding: inputPadding,
                    constrainedWidth: constrainedWidth,
                    phone: _phone,
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
                  decoration: const InputDecoration(
                    labelText: "Email",
                    counterText: "-",
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ).padding(bottom: inputPadding),
                //
                // PASSWORDS
                _Passwords(
                  password: _password,
                  inputPadding: inputPadding,
                  constrainedWidth: constrainedWidth,
                  isSigningUp: _isSigningUp,
                  password2: _password2,
                ),
                //
                // ---------------  SUBMIT BUTTON
                Observer(
                  builder: (_) {
                    return RaisedButton(
                      onPressed: state.value.isLoading ? null : _authenticate,
                      child: state.value.isLoading
                          ? const LinearProgressIndicator()
                          : Text(_isSigningUp ? "Sign up" : "Log in"),
                    );
                  },
                ).padding(bottom: 14),

                // Backend error
                Text(
                  state.value.error ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ).padding(bottom: 10),

                // Toggle _isSigningUp
                ToggleSignInSignUp(
                  isSigningUp: _isSigningUp,
                  toggleSignUp: () {
                    autovalid.value = false;
                    _clearError();
                    isSigningUp.value = !_isSigningUp;
                  },
                ).padding(top: 6),

                // Continue without auth
                const Text("Or").padding(top: 8.0).alignment(Alignment.center),
                FlatButton(
                  onPressed: goToHome,
                  child: const Text("Continue without an account")
                      .fontSize(18)
                      .fontWeight(FontWeight.bold),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleSignInSignUp extends StatelessWidget {
  const ToggleSignInSignUp({
    Key key,
    this.isSigningUp,
    this.toggleSignUp,
  }) : super(key: key);

  final bool isSigningUp;
  final void Function() toggleSignUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(isSigningUp
                ? "¿You have an account?"
                : "¿You don't have an account?")
            .fontSize(16),
        InkWell(
          onTap: toggleSignUp,
          child: Text(
            isSigningUp ? "Log in" : "Sign up",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ).padding(all: 6),
      ],
    );
  }
}

class _NameAndPhone extends StatelessWidget {
  const _NameAndPhone({
    Key key,
    @required TextEditingController name,
    @required this.inputPadding,
    @required this.constrainedWidth,
    @required TextEditingController phone,
  })  : _name = name,
        _phone = phone,
        super(key: key);

  final TextEditingController _name;
  final double inputPadding;
  final double constrainedWidth;
  final TextEditingController _phone;

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
          decoration: const InputDecoration(
            labelText: "Name",
            counterText: "-",
            prefixIcon: Icon(Icons.person),
          ),
        ).padding(bottom: inputPadding).constrained(maxWidth: constrainedWidth),
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
          decoration: const InputDecoration(
            labelText: "Phone",
            counterText: "-",
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ).padding(bottom: inputPadding).constrained(maxWidth: constrainedWidth)
      ],
    );
  }
}

class _Passwords extends StatelessWidget {
  const _Passwords({
    Key key,
    @required TextEditingController password,
    @required this.inputPadding,
    @required this.constrainedWidth,
    @required bool isSigningUp,
    @required TextEditingController password2,
  })  : _password = password,
        _isSigningUp = isSigningUp,
        _password2 = password2,
        super(key: key);

  final TextEditingController _password;
  final double inputPadding;
  final double constrainedWidth;
  final bool _isSigningUp;
  final TextEditingController _password2;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceBetween,
      children: [
        TextFormField(
          controller: _password,
          decoration: const InputDecoration(
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
        ).padding(bottom: inputPadding).constrained(maxWidth: constrainedWidth),
        if (_isSigningUp)
          TextFormField(
            controller: _password2,
            maxLength: 256,
            decoration: const InputDecoration(
              labelText: "Verification Password",
              counterText: "-",
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (password2) {
              if (!_isSigningUp) return null;
              if (password2.isEmpty) return "Required";
              if (password2 != _password.text) {
                return "The passwords don't match";
              }
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
    );
  }
}
