import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/user-store.dart';
import 'package:styled_widget/styled_widget.dart';

class CreateCarForm extends HookWidget {
  UserStore userStore;
  CreateCarForm(this.userStore);

  @override
  Widget build(BuildContext context) {
    final plateC = useTextEditingController();
    final modelC = useTextEditingController();
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
                onPressed: () => Router.navigator.pop(),
                child: Text("CANCEL"),
              ),
              SizedBox(
                width: 40,
              ),
              RaisedButton(
                onPressed: () {
                  userStore.createCar(
                    CarModel(
                      active: true,
                      model: modelC.text,
                      plate: plateC.text,
                    ),
                  );
                  Router.navigator.pop();
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
