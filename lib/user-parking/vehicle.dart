import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:styled_widget/styled_widget.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 2)
class VehicleModel extends _VehicleModel with _$VehicleModel {
  VehicleModel({plate, model, active})
      : super(plate: plate, model: model, active: active);

  bool operator ==(other) {
    return plate == other.plate;
  }

  @override
  int get hashCode => plate.hashCode;
}

@jsonSerializable
abstract class _VehicleModel extends HiveObject with Store {
  @HiveField(0)
  String plate;
  @HiveField(1)
  @JsonProperty(name:"description")
  String model;
  @HiveField(2)
  @observable
  bool active;

  _VehicleModel({this.plate, this.model, this.active});
}

class VehicleListTile extends hooks.HookWidget {
  const VehicleListTile(this.vehicle, {this.trailing, Key key})
      : super(key: key);

  final VehicleModel vehicle;
  final IconButton trailing;

  @override
  Widget build(ctx) {
    final userStore = useUserStore(ctx);
    return Observer(
      builder: (_) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(vehicle.plate),
        leading: Switch(
          value: vehicle.active,
          onChanged: (_) => userStore.toggleVehicleState(vehicle),
        ),
        subtitle: Text(vehicle.model),
        trailing: trailing,
      ),
    );
  }
}

class CreateVehicleForm extends hooks.HookWidget {
  final UserStore userStore;
  const CreateVehicleForm(this.userStore);

  Widget build(ctx) {
    final plateC = hooks.useTextEditingController();
    final modelC = hooks.useTextEditingController();
    final navigator = useNavigator(ctx);

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
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ).padding(bottom: 24),
          TextFormField(
            controller: modelC,
            decoration: InputDecoration(
              labelText: "Model",
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ).padding(bottom: 15),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () => navigator.pop(),
                child: Text("CANCEL"),
              ),
              FlatButton(
                onPressed: () async {
                  await userStore.createVehicle(
                    VehicleModel(
                        active: true, model: modelC.text, plate: plateC.text),
                  );
                  navigator.pop();
                },
                child: Text("CREATE").textColor(Colors.white),
                color: Colors.green[700],
              )
            ],
          )
        ],
      ),
    );
  }
}
