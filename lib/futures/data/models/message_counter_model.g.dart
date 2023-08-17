// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_counter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageCounterModelAdapter extends TypeAdapter<MessageCounterModel> {
  @override
  final int typeId = 3;

  @override
  MessageCounterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageCounterModel(
      counter: fields[0] as int?,
      index: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageCounterModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.counter)
      ..writeByte(1)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageCounterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
