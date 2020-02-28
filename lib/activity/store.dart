import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

part 'store.g.dart';

abstract class ActivityType {
  static const Music = "Music";
  static const Other = "Other";
  static const Sport = "Sport";
  static const Outdoor = "Outdoor";
}

@JsonSerializable()
class Activity {
  int key;
  String name;
  String description;
  String type;
  int participants;
  int maxParticipants;
  DateTime date;
  String city;
  String address;
  String fullDescription;

  Activity(
      {this.name,
      this.description,
      this.type,
      this.participants,
      this.maxParticipants,
      this.date,
      this.city,
      this.address,
      this.fullDescription});

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  String get fullness {
    return "$participants/$maxParticipants";
  }

  Widget get fullnessWidget {
    return Row(
      children: <Widget>[Icon(Icons.people).padding(right: 8.0),
        Text(
          fullness,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget get placeWidget {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.place),
        ),
        Text(
          address,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ActivitiesStore = _ActivitiesStore with _$ActivitiesStore;

abstract class _ActivitiesStore with Store {
  final _activitiesDb =
      FirebaseDatabase.instance.reference().child("/activities/");

  @observable
  ObservableList<Activity> activities = ObservableList.of([]);

  @observable
  bool fetching = false;

  @observable
  int index;

  @action
  fetchMore() async {
    if (fetching || activities.length == 3) return;
    fetching = true;

    final snapchot = await _activitiesDb.limitToFirst(20).once();
    activities.addAll((snapchot.value as List<dynamic>)
        .where((v) => v != null)
        .map((v) => Activity.fromJson(Map<String, dynamic>.from(v))));
    fetching = false;
  }
}

ActivitiesStore useActivityStore(BuildContext context) {
  return Provider.of<ActivitiesStore>(context, listen: false);
}
