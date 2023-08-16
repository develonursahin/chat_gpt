import 'package:flutter/foundation.dart';
import 'package:chat_gpt/futures/data/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatProvider with ChangeNotifier {
  Box<ChatModel>? _chatBox; // Declare the box
  final List<ChatModel> _messages = [];

  List<ChatModel> get messages => _messages;

  Future<void> initialize() async {
    _chatBox = await Hive.openBox<ChatModel>('chat_messages'); // Open the box
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
    _chatBox?.clear(); // Clear the Hive box
    notifyListeners();
  }
}

class HomeViewModel with ChangeNotifier {
  final ChatProvider chatProvider = ChatProvider();

  List<ChatModel> get messages => chatProvider.messages;

  Future<void> initialize() async {
    await chatProvider.initialize();
    notifyListeners();
  }

  Future<void> clearChat() async {
    chatProvider.clearChat();
    messages.clear();
  }

  // Bu fonksiyonu ekleyin:
  Future<void> addUserMessage(String message) async {
    await chatProvider.addMessage(message, 'user');
    notifyListeners();
  }
}