import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/mock-data.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/paymentMethod.dart';
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
  Iterable<T> list;
  Widget Function(T) expandedWidgetFn;

  _Item(
      {this.isExpanded: false,
      this.list,
      this.contractedWidget,
      this.expandedWidgetFn});
}

class UserParkingDetail extends HookWidget {
  @override
  Widget build(ctx) {
    final store = useStore(ctx);
    final userStore = useUserStore(ctx);
    final navigator = useNavigator(ctx);
    useEffect(() {
      userStore.fetchUser();
      return null;
    }, []);
    final mq = MediaQuery.of(ctx);

    final showCreateVehicleDialog = useMemoized(
      () => () async {
        await showDialog(
          context: ctx,
          builder: (ctx) => SimpleDialog(
            title:
                Text("Create Vehicle", style: Theme.of(ctx).textTheme.headline6)
                    .textAlignment(TextAlign.center)
                    .padding(bottom: 12)
                    .border(bottom: 1, color: Colors.black12),
            contentPadding:
                EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
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
          builder: (_) => textWithIcon(Icons.directions_car,
              Text("Vehicles (${userStore.user.vehicles.length})")),
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
          onPressed: deleteDialog(ctx, () async {
            await userStore.deleteVehicle(v.plate);
            navigator.pop();
          }, Text("Delete Vehicle"),
              Text("Are you sure you want to delete the car?")),
        ),
      ),
      list: userStore.user.vehicles.values,
      isExpanded: true,
    );

    final paymentMethods = _Item(
      contractedWidget: ListTile(
        title: Observer(
          builder: (_) => textWithIcon(
              Icons.payment,
              Text(mq.size.width > 350
                  ? "Payment Methods (${userStore.user.paymentMethods.length})"
                  : "Payment (${userStore.user.paymentMethods.length})")),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () => navigator.pushNamed(Routes.createPaymentMethod),
        ),
      ),
      expandedWidgetFn: (v) => Observer(
        builder: (_) => PaymentMethodListTile(
          v,
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteDialog(ctx, () async {
              await userStore.deletePaymentMethod(v);
              navigator.pop();
            }, Text("Delete Payment Method"),
                Text("Are you sure you want to delete the payment method?")),
          ),
        ),
      ),
      list: userStore.user.paymentMethods,
    );

    return Scaffold(
      appBar: DefaultAppBar(
        title: Text("Profile"),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(),
      body: Column(
        children: [
          Text(
            userStore.user.name,
            style: Theme.of(ctx).textTheme.headline5,
          ).padding(top: 18, bottom: 20, horizontal: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              [
                textWithIcon(Icons.email, Text("Email")),
                Text(userStore.user.email).fontSize(16)
              ].toColumn(),
              SizedBox(width: 60),
              [
                textWithIcon(Icons.phone, Text("Phone")),
                Text(userStore.user.phone?.toString() ?? "No phone")
                    .fontSize(16)
              ].toColumn(),
            ],
          ).padding(bottom: 26),
          ExpandibleList([cars, paymentMethods])
              .padding(bottom: 50)
              .constrained(maxWidth: 400)
              .alignment(Alignment.center),
          if (!kIsWeb)
            RaisedButton(
              child: Text(
                "Test Notification",
              ),
              onPressed: () => store.notificationService.testNotification(
                  mockTransactions
                      .firstWhere((element) =>
                          element.state == TransactionState.Waiting)
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
