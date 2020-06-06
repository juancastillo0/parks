import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parks/common/bottom-nav-bar.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/scaffold.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/user-parking/paymentMethod/listTile.dart';
import 'package:parks/user-parking/vehicle.dart';
import 'package:styled_widget/styled_widget.dart';

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
    final expanded = useState([true, false]);

    return Scaffold(
      appBar: const DefaultAppBar(title: Text("Profile")),
      bottomNavigationBar: const DefaultBottomNavigationBar(),
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
                textWithIcon(Icons.email, const Text("Email")),
                Text(userStore.user.email).fontSize(16)
              ].toColumn(),
              const SizedBox(width: 60),
              [
                textWithIcon(Icons.phone, const Text("Phone")),
                Text(userStore.user.phone?.toString() ?? "No phone")
                    .fontSize(16)
              ].toColumn(),
            ],
          ).padding(bottom: 26),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              expanded.value[panelIndex] = !isExpanded;
              expanded.value = [...expanded.value];
            },
            children: [
              ExpansionPanel(
                isExpanded: expanded.value[0],
                headerBuilder: (ctx, isExpanded) => ListTile(
                  title: Observer(
                    builder: (_) => textWithIcon(Icons.directions_car,
                        Text("Vehicles (${userStore.user.vehicles.length})")),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => createVehicleDialog(ctx),
                  ),
                ),
                body: Observer(
                  builder: (_) => Column(
                    children: userStore.user.vehicles.values
                        .map((v) => VehicleListTile(v, key: Key(v.plate)))
                        .toList(),
                  ),
                ),
              ),
              ExpansionPanel(
                isExpanded: expanded.value[1],
                headerBuilder: (ctx, isExpanded) => ListTile(
                  title: Observer(
                    builder: (_) => textWithIcon(
                        Icons.payment,
                        Text(mq.size.width > 350
                            ? "Payment Methods (${userStore.user.paymentMethods.length})"
                            : "Payment (${userStore.user.paymentMethods.length})")),
                  ),
                  trailing: Observer(
                      builder: (_) => store.client.isConnected
                          ? IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => navigator
                                  .pushNamed(Routes.createPaymentMethod),
                            )
                          : const SizedBox(width: 0, height: 0,)),
                ),
                body: Observer(
                  builder: (_) => Column(
                    children: userStore.user.paymentMethods
                        .map((v) => PaymentMethodListTile(v, key: Key(v.id)))
                        .toList(),
                  ),
                ),
              ),
            ],
          )
              .padding(bottom: 50)
              .constrained(maxWidth: 400)
              .alignment(Alignment.center),
          // if (!kIsWeb)
          //   RaisedButton(
          //     child: Text("Test Notification"),
          //     onPressed: () => store.notificationService.testNotification(
          //       mockTransactions
          //           .firstWhere(
          //               (element) => element.state == TransactionState.Waiting)
          //           .vehicle
          //           .plate,
          //       3,
          //     ),
          //   )
        ],
      ).scrollable(),
    );
  }
}
