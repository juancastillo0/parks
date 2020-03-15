import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:styled_widget/styled_widget.dart';

class CreatePaymentMethodForm extends HookWidget {
  final UserStore userStore;
  CreatePaymentMethodForm(this.userStore);

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();
    final number = useTextEditingController();
    final provider = useTextEditingController();
    final obscureText = useState(true);
    // final month = useState(DateTime.now().add(Duration(days: 365 * 2)));
    // final year = useState(DateTime.now().add(Duration(days: 365 * 2)));
    final expDate = useState(DateTime.now().add(Duration(days: 365 * 2)));
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Payment Method"),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      body: Form(
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: name,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ).padding(bottom: 20, top: 40),
            TextFormField(
              controller: provider,
              decoration: InputDecoration(
                labelText: "Provider",
                border: OutlineInputBorder(),
              ),
            ).padding(bottom: 20),
            TextFormField(
              controller: number,
              obscureText: obscureText.value,
              decoration: InputDecoration(
                  labelText: "Number",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => obscureText.value = !obscureText.value,
                  )),
            ).padding(bottom: 20),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              constraints: BoxConstraints.loose(Size(400, 100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // MonthPicker(
                  //   selectedDate: month.value,
                  //   onChanged: (v) => month.value = v,
                  //   firstDate: DateTime.now(),
                  //   lastDate: DateTime.now().add(Duration(days: 365 * 100)),
                  // ),
                  // YearPicker(
                  //   selectedDate: year.value,
                  //   onChanged: (v) => year.value = v,
                  //   firstDate: DateTime.now(),
                  //   lastDate: DateTime.now().add(Duration(days: 365 * 100)),
                  // ),
                  InkWell(
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
                        Text(
                            "Expiration Date:  ${expDate.value.month}/${expDate.value.year}"),
                        const SizedBox(width: 60),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Router.navigator.pop(),
                  child: Text("CANCEL"),
                ),
                SizedBox(
                  width: 40,
                ),
                RaisedButton(
                  onPressed: () {
                    userStore.createPaymentMethod(
                      PaymentMethod(
                        name: name.text,
                        type: PaymentMethodType.Credit,
                        lastDigits:
                            number.text.substring(number.text.length - 4),
                        provider: provider.text,
                      ),
                    );
                    Router.navigator.pop();
                  },
                  child: Text("CREATE"),
                )
              ],
            ).padding(bottom: 40)
          ],
        ),
      ).padding(horizontal: 40),
    );
  }
}
