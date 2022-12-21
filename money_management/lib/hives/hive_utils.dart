import 'package:hive/hive.dart';
import 'package:money_management/hives/hive_constant.dart';

import '../models/category_model.dart';
import '../models/money_model.dart';

class HiveUtil {
  HiveUtil._();

  static HiveUtil get instant => HiveUtil._();

  late Box<List<CategoryModel>> boxCategories;
  late Box<List<MoneyModel>> boxMoney;

  init() async {
    // Register Adapter
    registerAdapter();
    // Open box
    boxCategories =
        await Hive.openBox<List<CategoryModel>>(HiveConstant.categories);
    boxMoney = await Hive.openBox<List<MoneyModel>>(HiveConstant.collectMoney);
  }

  // Register Adapter
  registerAdapter() {
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(MoneyModelAdapter());
  }
}
