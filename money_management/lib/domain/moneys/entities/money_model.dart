import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/constants/data_constant.dart';

import '../../categories/entities/category_model.dart';
import 'money_type.dart';

part 'money_model.g.dart';

@HiveType(typeId: 2)
class MoneyModel {
  @HiveField(0)
  late int id;
  @HiveField(1, defaultValue: 0)
  late num money;
  @HiveField(2)
  late DateTime createDated;
  @HiveField(3)
  late CategoryModel category;
  @HiveField(4)
  String? note;
  @HiveField(5)
  MoneyType? moneyType;

  DateTime? startDate;

  MoneyModel(
      {int? idMoney,
      this.moneyType,
      required this.category,
      this.note,
      required this.createDated,
      this.money = 0}) {
    id = idMoney ?? Random().nextInt(DataConst.valueRandom);
  }

  num? percent;
  Color? color;

 static copyWith({required MoneyModel data}) {
    return MoneyModel(
        idMoney: data.id,
        category: data.category,
        createDated: data.createDated,
        money: data.money,
        moneyType: data.moneyType,
        note: data.note);
  }
}
