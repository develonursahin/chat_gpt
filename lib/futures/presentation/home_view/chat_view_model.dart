import 'package:chat_gpt/futures/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatProvider with ChangeNotifier {
  Box<ChatModel>? _chatBox;
  final List<ChatModel> _messages = [];

  List<ChatModel> get messages => _messages.reversed.toList();

  Future<void> initialize() async {
    _chatBox = await Hive.openBox<ChatModel>('chat_messages');
    _messages.clear();
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

  void clearChatProvider() {
    _messages.clear();
    _chatBox?.clear();
    notifyListeners();
  }
}
