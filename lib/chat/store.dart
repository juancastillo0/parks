import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:parks/user/model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'store.g.dart';

@JsonSerializable()
class Message {
  String content;
  String userId;
  DateTime date;

  Message({
    this.content,
    this.userId,
    this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Widget get toWidget {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(userId),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(content),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.access_time),
            Text(
              timeago.format(date),
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChatModel = _ChatModel with _$ChatModel;

abstract class _ChatModel with Store {
  ObservableList<Message> messages;
  ChatType type;
  List<User> peers;
}

enum ChatType { Group, Individual }

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final _chatsDb = FirebaseDatabase.instance.reference().child("/chats/");

  @observable
  ObservableList<ChatModel> chats = ObservableList.of([]);

  @observable
  bool fetching = false;
}

ChatStore useActivityStore(BuildContext context) {
  return Provider.of<ChatStore>(context, listen: false);
}
