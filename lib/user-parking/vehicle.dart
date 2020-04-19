import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:styled_widget/styled_widget.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class VehicleModel extends _VehicleModel with _$VehicleModel {
  VehicleModel({plate, description, active})
      : super(plate: plate, description: description, active: active);

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);

  bool operator ==(other) {
    return plate == other.plate;
  }

  int get hashCode => plate.hashCode;
}

abstract class _VehicleModel extends HiveObject with Store {
  @HiveField(0)
  String plate;

  @HiveField(1)
  String description;

  @HiveField(2)
  @observable
  @JsonKey(
      name: "state",
      fromJson: _ActiveVehicleModel.fromJson,
      toJson: _ActiveVehicleModel.toJson)
  bool active;

  @observable
  @JsonKey(ignore: true)
  bool saved = false;

  _VehicleModel({this.plate, this.description, this.active});
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
          value: vehicle.active ?? true,
          onChanged: (_) => userStore.toggleVehicleState(vehicle),
        ),
        subtitle: Text(vehicle.description),
        trailing: trailing,
      ),
    );
  }
}

// class ActiveVehicleModel implements ICustomConverter<bool> {
//   const ActiveVehicleModel();

//   @override
//   bool fromJSON(jsonValue, [JsonProperty jsonProperty]) {
//     return jsonValue == "ACTIVE" || jsonValue == true ? true : false;
//   }

//   @override
//   toJSON(bool object, [JsonProperty jsonProperty]) {
//     return object ? "ACTIVE" : "INACTIVE";
//   }
// }

class _ActiveVehicleModel {
  static bool fromJson(String jsonValue) {
    return jsonValue == "ACTIVE" ? true : false;
  }

  static String toJson(bool object) {
    return object == null || object ? "ACTIVE" : "INACTIVE";
  }
}

class CreateVehicleForm extends hooks.HookWidget {
  final UserStore userStore;
  const CreateVehicleForm(this.userStore);

  Widget build(ctx) {
    final plateC = hooks.useTextEditingController();
    final descriptionC = hooks.useTextEditingController();
    final navigator = useNavigator(ctx);

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: plateC,
            autofocus: true,
            validator: (v) => v.length > 0 ? null : "Required",
            decoration: InputDecoration(labelText: "Plate"),
          ).padding(bottom: 24),
          TextFormField(
            controller: descriptionC,
            decoration: InputDecoration(labelText: "Description"),
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
                      active: true,
                      description: descriptionC.text,
                      plate: plateC.text,
                    ),
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
