import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/common/widgets.dart';
import 'package:parks/routes.dart';
import 'package:parks/validators/validators.dart';
import 'package:styled_widget/styled_widget.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(includeIfNull: false)
class VehicleModel extends _VehicleModel with _$VehicleModel {
  VehicleModel({String plate, String description, bool active})
      : super(plate: plate, description: description, active: active);

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);

  @override
  bool operator ==(dynamic other) {
    return plate == other.plate;
  }

  @override
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
  @HiveField(3)
  bool saved = true;

  VehicleModel toggled() => VehicleModel()
    ..plate = plate
    ..active = !active;

  _VehicleModel({this.plate, this.description, this.active});
}

class VehicleListTile extends hooks.HookWidget {
  const VehicleListTile(this.vehicle, {Key key}) : super(key: key);

  final VehicleModel vehicle;

  @override
  Widget build(ctx) {
    final userStore = useUserStore(ctx);
    return Observer(
      builder: (_) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(vehicle.plate),
              if (!vehicle.saved)
                Text(
                  "Not saved",
                  style: Theme.of(ctx).textTheme.subtitle2,
                )
            ],
          ),
          leading: Switch(
            value: vehicle.active,
            onChanged: (_) => userStore.toggleVehicleState(vehicle),
          ),
          subtitle: Text(vehicle.description),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteDialog(
              ctx,
              () {
                userStore.deleteVehicle(vehicle.plate);
                Navigator.of(ctx).pop();
              },
              const Text("Delete Vehicle"),
              const Text("Are you sure you want to delete the car?"),
            ),
          ),
        );
      },
    );
  }
}

class _ActiveVehicleModel {
  static bool fromJson(String jsonValue) {
    return jsonValue == "ACTIVE";
  }

  // ignore: avoid_positional_boolean_parameters
  static String toJson(bool object) {
    return object == null || object ? "ACTIVE" : "INACTIVE";
  }
}

Future createVehicleDialog(BuildContext ctx) async {
  await showDialog(
    context: ctx,
    builder: (ctx) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: [
        const SizedBox(height: 15),
        Text(
          "Create Vehicle",
          style: Theme.of(ctx).textTheme.headline6,
        ).alignment(Alignment.center).padding(bottom: 16),
        const SizedBox(height: 10),
        const CreateVehicleForm(),
      ]
          .toColumn(mainAxisSize: MainAxisSize.min)
          .scrollable()
          .padding(horizontal: 25)
          .constrained(maxWidth: 400)
          .backgroundColor(Colors.white),
    ),
  );
}

class CreateVehicleForm extends hooks.HookWidget {
  const CreateVehicleForm({Key key}) : super(key: key);

  @override
  Widget build(ctx) {
    final plateC = hooks.useTextEditingController();
    final descriptionC = hooks.useTextEditingController();
    final navigator = useNavigator(ctx);
    final userStore = useUserStore();

    final state = hooks.useState(RequestState.none());
    final _formKey = hooks.useMemoized(() => GlobalKey<FormState>(), []);
    final autovalid = hooks.useState(false);

    Future submit() async {
      autovalid.value = true;
      if (_formKey.currentState.validate()) {
        state.value = RequestState.loading();
        final error = await userStore.createVehicle(
          VehicleModel(
            active: true,
            description: descriptionC.text,
            plate: plateC.text.toUpperCase(),
          ),
        );
        if (error != null) {
          state.value = RequestState.err(error);
        } else {
          navigator.pop();
        }
      }
    }

    return Form(
      key: _formKey,
      autovalidate: autovalid.value,
      onChanged: () {
        if (state.value.isError) state.value = RequestState.none();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          // ------------- Plate
          TextFormField(
            controller: plateC,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            maxLength: 8,
            validator: (v) => StringValid(
              minLength: 6,
              maxLength: 8,
              pattern: RegExp(r"^[a-zA-Z]{3}[\s]?[0-9]{3,4}$"),
            ).valid(v)
                ? null
                : "Should be a valid plate, e.g. 'ABC 123'",
            decoration: const InputDecoration(
              labelText: "Plate",
              counterText: "-",
              prefixIcon: Icon(Icons.directions_car),
            ),
          ).padding(bottom: 10),
          //
          // ------------------- Description
          TextFormField(
            controller: descriptionC,
            maxLength: 30,
            validator: (v) => StringValid(
              minLength: 3,
              maxLength: 30,
            ).valid(v)
                ? null
                : "Minimum length 3 and maximum 40",
            decoration: const InputDecoration(
              labelText: "Description",
              counterText: "-",
              helperText: "Helpful description for you to remember",
              helperMaxLines: 2,
            ),
          ).padding(bottom: 15),
          //
          // ----------------- Error
          Text(state.value.error ?? "")
              .textColor(Theme.of(ctx).errorColor)
              .padding(vertical: 3),
          //
          // ----------------- Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              state.value.progressIndicator,
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: navigator.pop,
                    child: const Text("CANCEL"),
                  ),
                  RaisedButton(
                    color: Colors.green[700],
                    onPressed: state.value.isLoading ? null : submit,
                    child: const Text("CREATE").textColor(Colors.white),
                  )
                ],
              ),
            ],
          ).padding(bottom: 10)
        ],
      ),
    );
  }
}
