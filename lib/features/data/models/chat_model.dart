import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0)
class ChatModel {
  @HiveField(0)
  String? sender;
  @HiveField(1)
  String? message;

  ChatModel({
    required this.sender,
    required this.message,
  });
}
