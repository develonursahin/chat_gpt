import 'package:chat_gpt/futures/core/hive/hive_box.dart';
import 'package:chat_gpt/futures/data/datasource/message_counter_local_datasource.dart';
import 'package:chat_gpt/futures/data/models/message_counter_model.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_gpt/futures/data/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatProvider with ChangeNotifier {
  Box<ChatModel>? _chatBox;
  final List<ChatModel> _messages = [];

  List<ChatModel> get messages => _messages.reversed.toList();

  Future<void> initialize() async {
    _chatBox = await Hive.openBox<ChatModel>('chat_messages');
    _messages.addAll(_chatBox!.values.toList());
    notifyListeners();
  }

  Future<void> addMessage(String message, String sender) async {
    _chatBox ??= await Hive.openBox<ChatModel>('chat_messages');

    final newMessage = ChatModel(message: message, sender: sender);
    _chatBox!.add(newMessage);
    _messages.add(newMessage);

    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    _chatBox?.clear();
    notifyListeners();
  }
}

class HomeViewModel with ChangeNotifier {
  final ChatProvider chatProvider = ChatProvider();
  final MessageCounterLocalDataSource _messageCounterLocalDataSource =
      MessageCounterLocalDataSource();
  int counter = 0;
  int index = 0;

  List<ChatModel> get messages => chatProvider.messages;

  Future<void> initialize() async {
    await chatProvider.initialize();
    await getMessageCounter();
    notifyListeners();
  }

  Future<void> getMessageCounter() async {
    if (messageCounterBox.isNotEmpty) {
      var model = await _messageCounterLocalDataSource.get();
      counter = model!.counter!;
      index = model.index!;
    }
    notifyListeners();
  }

  Future<void> updateCounter() async {
    if (messageCounterBox.isNotEmpty) {
      await _messageCounterLocalDataSource.update(MessageCounterModel(
        counter: counter++,
        index: index == 0 ? messages.length : index,
      ));
    }
    notifyListeners();
  }

  // Future<void> updateCounterIndex() async {
  //   if (messageCounterBox.isNotEmpty) {
  //     await _messageCounterLocalDataSource.update(MessageCounterModel(
  //       counter: counter,
  //       index: index,
  //     ));
  //   }
  //   notifyListeners();
  // }

  Future<void> clearChat() async {
    index = index + messages.length - 1;
    chatProvider.clearChat();
    messages.clear();
  }

  Future<void> addUserMessage(String message) async {
    await chatProvider.addMessage(message, 'user');
    notifyListeners();
  }
}
