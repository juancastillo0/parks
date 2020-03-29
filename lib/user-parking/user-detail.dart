import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/text-with-icon.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';
import 'package:styled_widget/styled_widget.dart';

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

class UserParkingDetail extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final store = useStore(context);
    final userStore = useUserStore(context);
    final user = userStore.user;
    final navigator = useNavigator(context: context);

    final showCreateVehicleDialog = useMemoized(
      () => () async {
        await showDialog(
          context: context,
          builder: (ctx) => SimpleDialog(
            title:
                Text("Create Vehicle", style: Theme.of(ctx).textTheme.headline5)
                    .textAlignment(TextAlign.center)
                    .padding(bottom: 12)
                    .border(bottom: 1, color: Colors.black12),
            contentPadding: EdgeInsets.all(30),
            children: [
              CreateVehicleForm(userStore),
            ],
          ),
        );
      },
    );

    final cars = _Item(
      contractedWidget: ListTile(
        title: Observer(
          builder: (_) => textWithIcon(
              Icons.directions_car, Text("Vehicles (${user.vehicles.length})")),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: showCreateVehicleDialog,
        ),
      ),
      expandedWidgetFn: (v) => VehicleListTile(
        v,
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: deleteDialog(
              context,
              () => userStore.deleteVehicle(v.plate),
              Text("Delete Vehicle"),
              Text("Are you sure you want to delete the car?")),
        ),
      ),
      list: user.vehicles,
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
          onPressed: () => navigator.pushNamed(
            Routes.createPaymentMethod,
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
      bottomNavigationBar: DefaultBottomNavigationBar(),
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
          ExpandibleList([cars, paymentMethods])
              .padding(bottom: 50)
              .constraints(maxWidth: 400)
              .alignment(Alignment.center),
          RaisedButton(
            child: Text(
              "Test Notification",
            ),
            onPressed: () => store.notificationService.testNotification(
                user.transactions
                    .firstWhere(
                        (element) => element.state == TransactionState.Waiting)
                    .vehicle
                    .plate,
                4),
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
