import 'package:hive/hive.dart';

part 'message_counter_model.g.dart';

@HiveType(typeId: 3)
class MessageCounterModel {
  @HiveField(0)
  int? counter;
  @HiveField(1)
  int? index;

  MessageCounterModel({
    required this.counter,
    required this.index,
  });
}
