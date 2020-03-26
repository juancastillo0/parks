import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/text-with-icon.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:styled_widget/styled_widget.dart';

import 'car.dart';


class PaymentMethodListTile extends HookWidget {
  const PaymentMethodListTile(this.method, this.trailing, {Key key})
      : super(key: key);

  final PaymentMethod method;

  final Widget trailing;

  @override
  Widget build(_) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      title: Text(method.name),
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
      trailing: trailing,
    );
  }
}

class CarListTile extends HookWidget {
  const CarListTile(this.car, this.trailing, {Key key}) : super(key: key);

  final CarModel car;
  final IconButton trailing;

  @override
  Widget build(_) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      title: Text(car.plate),
      leading: Switch(
        value: car.active,
        onChanged: (_) {},
      ),
      subtitle: Text(car.model),
      trailing: trailing,
    );
  }
}

class _Item<T> {
  bool isExpanded;
  Widget contractedWidget;
  ObservableList<T> list;
  Widget Function(T) expandedWidgetFn;

  _Item(
      {this.isExpanded: false,
      this.list,
      this.contractedWidget,
      this.expandedWidgetFn});
}

Future Function() deleteDialog(BuildContext context, void Function() onPressed,
    Widget title, Widget content) {
  return () async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: title,
        content: content,
        actions: [
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () => Router.navigator.pop(),
          ),
          FlatButton(
            child: Text("DELETE").textColor(Colors.white),
            color: Colors.red[800],
            onPressed: onPressed,
          )
        ],
      ),
    );
  };
}

class UserParkingDetail extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final store = useStore(context);
    final userStore = useUserStore(context);
    final user = userStore.user;
    final showDeleteCarDialog = useMemoized(() => () async {
          await showDialog(
            context: context,
            builder: (_context) {
              return SimpleDialog(
                title: Text("Create Car").padding(bottom: 5),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                children: [
                  CreateCarForm(userStore),
                ],
              );
            },
          );
        });

    final cars = _Item(
      contractedWidget: ListTile(
        title: Observer(
          builder: (_) => textWithIcon(
              Icons.directions_car, Text("Cars (${user.cars.length})")),
        ),
        trailing: IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: showDeleteCarDialog),
      ),
      expandedWidgetFn: (v) => Observer(
        builder: (_) => CarListTile(
          v,
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteDialog(
                context,
                () => userStore.deleteCar(v.plate),
                Text("Delete Car"),
                Text("Are you sure you want to delete the car?")),
          ),
        ),
      ),
      list: user.cars,
      isExpanded: true,
    );

    final paymentMethods = _Item(
      contractedWidget: ListTile(
        title: Observer(
          builder: (_) => textWithIcon(Icons.payment,
              Text("Payment Methods (${user.paymentMethods.length})")),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () => Router.navigator.pushNamed(
            Router.createPaymentMethod,
            arguments: userStore,
          ),
        ),
      ),
      expandedWidgetFn: (v) => Observer(
        builder: (_) => PaymentMethodListTile(
          v,
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteDialog(
                context,
                () => userStore.deletePaymentMethod(v),
                Text("Delete Payment Method"),
                Text("Are you sure you want to delete the payment method?")),
          ),
        ),
      ),
      list: user.paymentMethods,
    );

    final authStore = useAuthStore(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: getActions(authStore),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      body: Column(
        children: [
          Text(
            user.name,
            style: useTextTheme().headline5,
          ).padding(top: 18, bottom: 20, horizontal: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              [
                textWithIcon(Icons.email, Text("Email")),
                Text(user.email).fontSize(16)
              ].toColumn(),
              [
                textWithIcon(Icons.phone, Text("Phone")),
                Text(user.phone.toString()).fontSize(16)
              ].toColumn(),
            ],
          ).padding(bottom: 26),
          ExpandibleList([cars, paymentMethods]).padding(bottom: 50),
          RaisedButton(
            child: Text(
              "Test Notification",
            ),
            onPressed: () => store.notificationService
                .testNotification(user.cars[0].plate, 4),
          )
        ],
      ).scrollable(),
    );
  }
}

class ExpandibleList<T> extends HookWidget {
  final List<_Item<T>> items;
  ExpandibleList(this.items);

  @override
  Widget build(BuildContext context) {
    final _data = useState(items.map((e) => e.isExpanded).toList());
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        _data.value[index] = !isExpanded;
        _data.value = [..._data.value];
      },
      children: items.asMap().entries.map<ExpansionPanel>((e) {
        final index = e.key;
        _Item<T> item = e.value;

        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return item.contractedWidget;
          },
          body: Observer(
            builder: (_) => Column(
              children: item.list.map(item.expandedWidgetFn).toList(),
            ),
          ),
          isExpanded: _data.value[index],
        );
      }).toList(),
    );
  }
}
