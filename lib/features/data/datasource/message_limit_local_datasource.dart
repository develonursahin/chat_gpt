import 'package:chat_gpt/features/core/hive/hive_box.dart';
import 'package:chat_gpt/features/data/models/message_limit_model.dart';

class MessageLimitLocalDataSource {
  Future<void> create(MessageLimitModel model) async {
    await messageLimitBox.add(model);
  }

  Future<MessageLimitModel?> get() async {
    return messageLimitBox.getAt(0);
  }

  Future<void> delete() async {
    messageLimitBox.clear();
  }

  Future<void> update(MessageLimitModel model) async {
    messageLimitBox.putAt(0, model);
  }
}
