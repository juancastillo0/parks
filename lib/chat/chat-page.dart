import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parks/chat/store.dart';
import 'package:styled_widget/styled_widget.dart';

class ChatPage extends HookWidget {
  final ChatModel chat;
  ChatPage(this.chat);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chat.messages.length,
      itemBuilder: (_, index) {
        return chat.messages[index].toWidget.padding(vertical: 8);
      },
    );
  }
}
