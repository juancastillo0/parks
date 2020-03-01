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

List<Activity> allActivities = [
  {
    "address": "33529 Gislason Drive",
    "city": "Bogotá",
    "date": "2020-02-19T22:34:16.186",
    "description": "Nice music, nice place",
    "fullDescription":
        "In a voluptas sit sit dolore aperiam voluptatem. Et repellat consequatur. Cumque cupiditate consequatur sit ad dolor sint culpa doloribus.",
    "maxParticipants": 25,
    "name": "Jazz Concert",
    "participants": 3,
    "type": "Music"
  },
  {
    "address": "8781 Hettinger Stream",
    "city": "Bogotá",
    "date": "2020-02-19T22:34:16.186",
    "description": "5 vs 5 footbal match",
    "fullDescription":
        "Quod quidem nobis quas quidem voluptates. Enim at voluptatibus accusantium. A officia sed ut id similique sit temporibus molestias commodi. Qui voluptate at possimus similique non. Placeat non voluptatum hic et ab.",
    "maxParticipants": 5,
    "name": "Football match",
    "participants": 3,
    "type": "Other"
  },
  {
    "address": "43695 Kemmer Road",
    "city": "Bogotá",
    "date": "2020-02-25T22:34:16.186",
    "description": "Outdoor yoga class",
    "fullDescription":
        "Maxime reprehenderit cumque est aut quo molestiae et dolore. Natus labore consequuntur. Hic delectus praesentium eveniet beatae et veritatis. Est ab maxime eum vel harum rerum ut explicabo reiciendis.",
    "maxParticipants": 12,
    "name": "Yoga class",
    "participants": 3,
    "type": "Outdoor"
  }
].map((j) => Activity.fromJson(j)).toList();

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
      children: <Widget>[
        Icon(Icons.people).padding(right: 8.0),
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
  // final _activitiesDb =
  //     FirebaseDatabase.instance.reference().child("/activities/");

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

    // final snapchot = await _activitiesDb.limitToFirst(20).once();
    // activities.addAll((snapchot.value as List<dynamic>)
    //     .where((v) => v != null)
    //     .map((v) => Activity.fromJson(Map<String, dynamic>.from(v))));
    activities.addAll(allActivities);

    fetching = false;
  }
}

ActivitiesStore useActivityStore(BuildContext context) {
  return Provider.of<ActivitiesStore>(context, listen: false);
}
