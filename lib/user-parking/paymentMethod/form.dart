import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';
import 'package:parks/validators/validators.dart';
import 'package:styled_widget/styled_widget.dart';

class CreatePaymentMethodForm extends HookWidget {
  CreatePaymentMethodForm({Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final description = useTextEditingController();
    final number = useTextEditingController();
    final provider = useTextEditingController();
    final obscureText = useState(true);
    final expDate = useState(DateTime.now().add(Duration(days: 365 * 2)));
    final navigator = useNavigator(ctx);
    final userStore = useUserStore(ctx);
    final inputPadding = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Payment Method"),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(),
      body: MaterialResponsiveWrapper(
        breakpoint: 575,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: description,
              decoration: InputDecoration(labelText: "Name", counterText: "-"),
            ).padding(bottom: inputPadding, top: 40),
            TextFormField(
              controller: provider,
              decoration:
                  InputDecoration(labelText: "Provider", counterText: "-"),
            ).padding(bottom: inputPadding),
            TextFormField(
              controller: number,
              obscureText: obscureText.value,
              validator: StringValid(minLength: 4).firstError,
              decoration: InputDecoration(
                labelText: "Number",
                counterText: "-",
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () => obscureText.value = !obscureText.value,
                ),
              ),
              keyboardType: TextInputType.phone,
            ).padding(bottom: inputPadding + 3),
            Container(
              padding: EdgeInsets.only(bottom: inputPadding + 3),
              constraints: BoxConstraints.loose(Size(400, 100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [MonthPicker(expDate)],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => navigator.pop(),
                  child: Text("CANCEL"),
                ),
                SizedBox(
                  width: 50,
                ),
                RaisedButton(
                  onPressed: () {
                    userStore.createPaymentMethod(
                      PaymentMethod(
                        description: description.text,
                        type: PaymentMethodType.Credit,
                        lastDigits:
                            number.text.substring(number.text.length - 4),
                        provider: provider.text,
                      ),
                    );
                    navigator.pop();
                  },
                  child: Text("CREATE"),
                )
              ],
            ).padding(bottom: 40)
          ],
        )
            .padding(horizontal: 30)
            .scrollable(scrollDirection: Axis.vertical)
            .constrained(maxWidth: 400),
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
          Icon(Icons.calendar_today),
          const SizedBox(width: 20),
          Text("Expiration Date:  ${expDate.value.month}/${expDate.value.year}")
              .fontSize(16),
          const SizedBox(width: 60),
          Icon(
            Icons.arrow_drop_down,
            size: 26,
          ),
        ],
      ),
    );
  }
}
