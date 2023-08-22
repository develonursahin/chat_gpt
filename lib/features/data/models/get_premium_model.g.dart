// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_premium_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetPremiumModelAdapter extends TypeAdapter<GetPremiumModel> {
  @override
  final int typeId = 2;

  @override
  GetPremiumModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetPremiumModel(
      isPremium: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GetPremiumModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isPremium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetPremiumModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
