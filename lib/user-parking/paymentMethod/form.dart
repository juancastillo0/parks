import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/validators/validators.dart';
import 'package:styled_widget/styled_widget.dart';

class CreatePaymentMethodForm extends HookWidget {
  const CreatePaymentMethodForm({Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final description = useTextEditingController();
    final number = useTextEditingController();
    final provider = useTextEditingController();
    final securityNumber = useTextEditingController();
    final obscureText = useState(true);
    final expDate = useState(DateTime.now().add(const Duration(days: 365 * 2)));
    final navigator = useNavigator(ctx);
    final userStore = useUserStore(ctx);
    const inputPadding = 10.0;

    final state = useState(RequestState.none());
    final _formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final autovalid = useState(false);

    Future submit() async {
      autovalid.value = true;
      if (!_formKey.currentState.validate()) {
        return;
      }
      state.value = RequestState.loading();
      final error = await userStore.createPaymentMethod(
        PaymentMethod(
          description: description.text,
          type: PaymentMethodType.Credit,
          lastDigits: number.text.substring(number.text.length - 4),
          provider: provider.text,
        ),
      );
      if (error != null) {
        state.value = RequestState.err(error);
      } else {
        navigator.pop();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Create Payment Method")),
      bottomNavigationBar: const DefaultBottomNavigationBar(),
      body: MaterialResponsiveWrapper(
        breakpoint: 575,
        child: Form(
          key: _formKey,
          autovalidate: autovalid.value,
          child: Column(
            children: <Widget>[
              //
              //  -----------   Provider
              TextFormField(
                controller: provider,
                validator: StringValid(minLength: 4).firstError,
                decoration: const InputDecoration(
                  labelText: "Provider",
                  counterText: "-",
                  prefixIcon: Icon(Icons.card_membership),
                ),
              ).padding(bottom: inputPadding, top: 30),
              //
              //  -----------   Card Number
              TextFormField(
                controller: number,
                obscureText: obscureText.value,
                validator: StringValid(
                  minLength: 4,
                  pattern: RegExp(r"^[0-9]+$"),
                ).firstError,
                decoration: InputDecoration(
                  labelText: "Number",
                  counterText: "-",
                  prefixIcon: const Icon(Icons.credit_card),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () => obscureText.value = !obscureText.value,
                  ),
                ),
                keyboardType: TextInputType.phone,
              ).padding(bottom: inputPadding),
              //
              //  -----------   Security Number
              TextFormField(
                controller: securityNumber,
                maxLength: 4,
                obscureText: true,
                validator: StringValid(
                  minLength: 3,
                  maxLength: 4,
                  pattern: RegExp(r"^[0-9]+$"),
                ).firstError,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Security Number",
                  counterText: "-",
                  prefixIcon: Icon(Icons.lock),
                ),
              ).padding(bottom: inputPadding + 3),
              //
              //  -----------   Exp Date
              Container(
                padding: const EdgeInsets.only(bottom: inputPadding + 3),
                constraints: BoxConstraints.loose(const Size(400, 100)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [MonthPicker(expDate)],
                ),
              ),
              //
              //  -----------   Description
              TextFormField(
                controller: description,
                maxLength: 50,
                validator: StringValid(
                  minLength: 3,
                  maxLength: 50,
                ).firstError,
                decoration: const InputDecoration(
                  labelText: "Description",
                  helperText: "Helpful description for you to remember",
                ),
              ).padding(bottom: inputPadding, top: 12),
              //
              //  -----------   Error
              Text(state.value.error ?? "").padding(vertical: 10),
              //
              //  -----------   Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.value.progressIndicator,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: navigator.pop,
                        child: const Text("CANCEL"),
                      ),
                      const SizedBox(width: 20),
                      RaisedButton(
                        color: Colors.green[700],
                        onPressed: state.value.isLoading ? null : submit,
                        child: const Text("CREATE").textColor(Colors.white),
                      )
                    ],
                  )
                ],
              ).padding(bottom: 30)
            ],
          ).padding(horizontal: 30).scrollable().constrained(maxWidth: 400),
        ),
      ).alignment(Alignment.center),
    );
  }
}

class MonthPicker extends HookWidget {
  const MonthPicker(this.expDate, {Key key}) : super(key: key);
  final ValueNotifier<DateTime> expDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final _date = await showMonthPicker(
          context: context,
          initialDate: expDate.value,
          firstDate: DateTime.now(),
        );
        if (_date != null) expDate.value = _date;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(Icons.calendar_today),
          const SizedBox(width: 20),
          Text("Expiration Date:  ${expDate.value.month}/${expDate.value.year}")
              .fontSize(16),
          const SizedBox(width: 60),
          const Icon(Icons.arrow_drop_down, size: 26),
        ],
      ),
    );
  }
}
