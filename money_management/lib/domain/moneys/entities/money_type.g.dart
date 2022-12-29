// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyTypeAdapter extends TypeAdapter<MoneyType> {
  @override
  final int typeId = 3;

  @override
  MoneyType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MoneyType.pay;
      case 1:
        return MoneyType.collect;
      default:
        return MoneyType.pay;
    }
  }

  @override
  void write(BinaryWriter writer, MoneyType obj) {
    switch (obj) {
      case MoneyType.pay:
        writer.writeByte(0);
        break;
      case MoneyType.collect:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
