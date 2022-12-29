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

  num? percent;
  Color? color;
}
