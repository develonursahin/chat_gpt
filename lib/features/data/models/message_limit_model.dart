import 'package:hive_flutter/hive_flutter.dart';

part 'message_limit_model.g.dart';

@HiveType(typeId: 4)
class MessageLimitModel {
  @HiveField(0)
  bool? isLimitFull;
  @HiveField(1)
  int? messageCount;
  MessageLimitModel({required this.isLimitFull, required this.messageCount});
}
