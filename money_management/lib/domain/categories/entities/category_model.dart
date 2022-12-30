import 'dart:math';

import 'package:hive/hive.dart';
import 'package:money_management/constants/data_constant.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  late int id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? icon;
  @HiveField(3)
  List<CategoryModel>? subCategories;
  @HiveField(4)
  String? note;

  @HiveField(5)
  int? parentId;

  CategoryModel(
      {this.name, this.icon, this.subCategories, this.note, this.parentId}) {
    id = Random().nextInt(DataConst.valueRandom);
  }
}
