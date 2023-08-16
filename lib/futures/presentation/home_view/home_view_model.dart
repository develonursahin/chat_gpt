import 'package:flutter/foundation.dart';
import 'package:chat_gpt/futures/data/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatProvider with ChangeNotifier {
  Box<ChatModel>? _chatBox; // Declare the box
  final List<ChatModel> _messages = [
    ChatModel(message: "message", sender: "user"),
    ChatModel(message: "message", sender: "robot"),
  ];

  List<ChatModel> get messages => _messages;

  Future<void> initialize() async {
    _chatBox = await Hive.openBox<ChatModel>('chat_messages'); // Open the box
    _messages.addAll(_chatBox!.values.toList());
    print(_messages);
    print(_messages);
    notifyListeners();
  }

  void addMessage(String message, String sender) {
    if (_chatBox != null) {
      final newMessage = ChatModel(message: message, sender: sender);
      _chatBox!.add(newMessage);
      _messages.add(newMessage);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Error: _chatBox has not been initialized.');
      }
    }
  }
}

class HomeViewModel extends ChangeNotifier {
  final ChatProvider chatProvider = ChatProvider();

  List<ChatModel> get messages => chatProvider.messages;

  Future<void> initialize() async {
    print(messages);
    print(messages);
    await chatProvider.initialize();
    notifyListeners();
  }
}
