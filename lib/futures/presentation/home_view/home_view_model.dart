import 'package:chat_gpt/futures/core/hive/hive_box.dart';
import 'package:chat_gpt/futures/data/datasource/message_limit_local_datasource.dart';
import 'package:chat_gpt/futures/data/models/message_limit_model.dart';
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
  final MessageLimitLocalDataSource _messageLimitLocalDataSource =
      MessageLimitLocalDataSource();

  bool isLimitFull = false;

  List<ChatModel> get messages => chatProvider.messages;

  Future<void> initialize() async {
    await chatProvider.initialize();
    await getMessageLimit();
    notifyListeners();
  }

  Future<void> getMessageLimit() async {
    var messageLimitModel = await _messageLimitLocalDataSource.get();
    if (messageLimitModel != null) {
      isLimitFull = messageLimitModel.isLimitFull!;
    }
  }

  Future<void> updateMessageLimit() async {
    if (messageLimitBox.isNotEmpty) {
      await _messageLimitLocalDataSource
          .update(MessageLimitModel(isLimitFull: true));
    }
    notifyListeners();
  }

  Future<void> clearChat() async {
    chatProvider.clearChat();
    messages.clear();
  }

  Future<void> addUserMessage(String message) async {
    await chatProvider.addMessage(message, 'user');
    notifyListeners();
  }
}
