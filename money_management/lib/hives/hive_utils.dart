import 'package:hive/hive.dart';
import 'package:money_management/domain/moneys/entities/money_type.dart';
import 'package:money_management/hives/hive_constant.dart';

import '../domain/categories/entities/category_model.dart';
import '../domain/moneys/entities/money_model.dart';

class HiveUtil {
  static late Box<List<dynamic>> boxCategories;
  static late Box<List<dynamic>> boxMoney;
  static late Box<dynamic> boxLocal;

  static init() async {
    // Register Adapter
    registerAdapter();
    // Open box
    boxCategories = await Hive.openBox(HiveConstant.categories);
    boxMoney = await Hive.openBox(HiveConstant.collectMoney);
    boxLocal = await Hive.openBox("myBox");
  }

  // Register Adapter
  static registerAdapter() {
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(MoneyModelAdapter());
    Hive.registerAdapter(MoneyTypeAdapter());
  }
}
