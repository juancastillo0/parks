// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    content: json['content'] as String,
    userId: json['userId'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'userId': instance.userId,
      'date': instance.date?.toIso8601String(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatModel on _ChatModel, Store {
  @override
  String toString() {
    final string = '';
    return '{$string}';
  }
}

mixin _$ChatStore on _ChatStore, Store {
  final _$chatsAtom = Atom(name: '_ChatStore.chats');

  @override
  ObservableList<ChatModel> get chats {
    _$chatsAtom.context.enforceReadPolicy(_$chatsAtom);
    _$chatsAtom.reportObserved();
    return super.chats;
  }

  @override
  set chats(ObservableList<ChatModel> value) {
    _$chatsAtom.context.conditionallyRunInAction(() {
      super.chats = value;
      _$chatsAtom.reportChanged();
    }, _$chatsAtom, name: '${_$chatsAtom.name}_set');
  }

  final _$fetchingAtom = Atom(name: '_ChatStore.fetching');

  @override
  bool get fetching {
    _$fetchingAtom.context.enforceReadPolicy(_$fetchingAtom);
    _$fetchingAtom.reportObserved();
    return super.fetching;
  }

  @override
  set fetching(bool value) {
    _$fetchingAtom.context.conditionallyRunInAction(() {
      super.fetching = value;
      _$fetchingAtom.reportChanged();
    }, _$fetchingAtom, name: '${_$fetchingAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'chats: ${chats.toString()},fetching: ${fetching.toString()}';
    return '{$string}';
  }
}
