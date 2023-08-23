import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatProvider with ChangeNotifier {
  Box<ChatModel>? _chatBox;
  final List<ChatModel> _messages = [];

  List<ChatModel> get messages => _messages.reversed.toList();

  Future<void> initialize() async {
    _chatBox =
        await Hive.openBox<ChatModel>(TextConstants.instance.chatMessages);
    _messages.clear();
    _messages.addAll(_chatBox!.values.toList());
    notifyListeners();
  }

  Future<void> addMessage(String message, String sender) async {
    _chatBox ??=
        await Hive.openBox<ChatModel>(TextConstants.instance.chatMessages);
    final newMessage = ChatModel(message: message, sender: sender);
    _chatBox!.add(newMessage);
    _messages.add(newMessage);
    notifyListeners();
  }

  Future<void> addEmptyMessage() async {
    final newMessage = ChatModel(
        message: TextConstants.instance.emptyMessage,
        sender: TextConstants.instance.robot);
    _messages.add(newMessage);
    notifyListeners();
  }

  Future<void> deleteEmptyMessage() async {
    _messages.removeAt(_messages.length - 2);
  }

  void clearChatProvider() {
    _messages.clear();
    _chatBox?.clear();
    notifyListeners();
  }
}
