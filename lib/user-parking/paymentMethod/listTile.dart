import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/user-parking/paymentMethod/model.dart';

class PaymentMethodListTile extends HookWidget {
  const PaymentMethodListTile(this.method, {Key key}) : super(key: key);

  final PaymentMethod method;

  @override
  Widget build(ctx) {
    final userStore = useUserStore(ctx);
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      title: Text(method.description),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(method.type.toString().split(".")[1])],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(method.provider),
          Text("Last Digits: ${method.lastDigits}"),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: deleteDialog(
          ctx,
          () async {
            await userStore.deletePaymentMethod(method);
            Navigator.of(ctx).pop();
          },
          Text("Delete Payment Method"),
          Text("Are you sure you want to delete the payment method?"),
        ),
      ),
    );
  }
}