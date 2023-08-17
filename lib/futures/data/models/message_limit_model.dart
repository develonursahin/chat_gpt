import 'package:hive_flutter/hive_flutter.dart';

part 'message_limit_model.g.dart';

@HiveType(typeId: 4)
class MessageLimitModel {
  @HiveField(0)
  bool? isLimitFull;
  MessageLimitModel({required this.isLimitFull});
}
