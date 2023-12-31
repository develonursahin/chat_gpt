// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_limit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageLimitModelAdapter extends TypeAdapter<MessageLimitModel> {
  @override
  final int typeId = 4;

  @override
  MessageLimitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageLimitModel(
      isLimitFull: fields[0] as bool?,
      messageCount: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageLimitModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isLimitFull)
      ..writeByte(1)
      ..write(obj.messageCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageLimitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
