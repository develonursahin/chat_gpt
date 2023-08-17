import 'package:chat_gpt/futures/core/hive/hive_box.dart';
import 'package:chat_gpt/futures/data/models/message_counter_model.dart';
import 'package:flutter/foundation.dart';

class MessageCounterLocalDataSource {
  Future<void> create(MessageCounterModel model) async {
    try {
      await messageCounterBox.add(model);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<MessageCounterModel?> get() async {
    try {
      return messageCounterBox.getAt(0);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete() async {
    try {
      messageCounterBox.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> update(MessageCounterModel model) async {
    try {
      messageCounterBox.putAt(0, model);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
