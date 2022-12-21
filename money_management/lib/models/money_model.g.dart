// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyModelAdapter extends TypeAdapter<MoneyModel> {
  @override
  final int typeId = 2;

  @override
  MoneyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyModel(
      moneyType: fields[5] as MoneyType?,
      category: fields[3] as CategoryModel?,
      note: fields[4] as String?,
      createDated: fields[2] as DateTime?,
      money: fields[1] == null ? 0 : fields[1] as num,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, MoneyModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.money)
      ..writeByte(2)
      ..write(obj.createDated)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.moneyType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
