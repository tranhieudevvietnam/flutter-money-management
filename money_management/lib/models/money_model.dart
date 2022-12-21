import 'dart:math';

import 'package:hive/hive.dart';
import 'package:money_management/constants/data_constant.dart';

import 'category_model.dart';

part 'money_model.g.dart';

@HiveType(typeId: 2)
class MoneyModel {
  @HiveField(0)
  late int id;
  @HiveField(1, defaultValue: 0)
  late num money;
  @HiveField(2)
  DateTime? createDated;
  @HiveField(3)
  CategoryModel? category;
  @HiveField(4)
  String? note;
  @HiveField(5)
  MoneyType? moneyType;

  MoneyModel(
      {this.moneyType,
      this.category,
      this.note,
      this.createDated,
      this.money = 0}) {
    id = Random().nextInt(DataConst.valueRandom);
  }
}

@HiveType(typeId: 3)
enum MoneyType {
  @HiveField(0)
  pay,

  @HiveField(1)
  collect,
}
