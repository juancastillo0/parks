import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/routes.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:styled_widget/styled_widget.dart';

@jsonSerializable
class VehicleModel {
  String plate;
  String model;
  bool active;

  VehicleModel({this.plate, this.model, this.active});
}

class VehicleListTile extends HookWidget {
  const VehicleListTile(this.car, this.trailing, {Key key}) : super(key: key);

  final VehicleModel car;
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

class CreateVehicleForm extends HookWidget {
  final UserStore userStore;
  const CreateVehicleForm(this.userStore);

  @override
  Widget build(BuildContext context) {
    final plateC = useTextEditingController();
    final modelC = useTextEditingController();
    final navigator = useNavigator(context: context);

    FormState();
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: plateC,
            autofocus: true,
            validator: (v) => v.length > 0 ? null : "Required",
            decoration: InputDecoration(
              labelText: "Plate",
              border: OutlineInputBorder(),
            ),
          ).padding(bottom: 20),
          TextFormField(
            controller: modelC,
            decoration: InputDecoration(
              labelText: "Model",
              border: OutlineInputBorder(),
            ),
          ).padding(bottom: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () => navigator.pop(),
                child: Text("CANCEL"),
              ),
              SizedBox(
                width: 40,
              ),
              RaisedButton(
                onPressed: () {
                  userStore.createVehicle(
                    VehicleModel(
                      active: true,
                      model: modelC.text,
                      plate: plateC.text,
                    ),
                  );
                  navigator.pop();
                },
                child: Text("CREATE"),
              )
            ],
          )
        ],
      ),
    );
  }
}
