import 'package:hive/hive.dart';
import 'package:money_management/hives/hive_constant.dart';

import '../domain/categories/entities/category_model.dart';
import '../domain/moneys/entities/money_model.dart';

class HiveUtil {
  static late Box<List<dynamic>> boxCategories;
  static late Box<List<dynamic>> boxMoney;

  static init() async {
    // Register Adapter
    registerAdapter();
    // Open box
    boxCategories = await Hive.openBox(HiveConstant.categories);
    boxMoney = await Hive.openBox(HiveConstant.collectMoney);
  }

  // Register Adapter
  static registerAdapter() {
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(MoneyModelAdapter());
  }
}
