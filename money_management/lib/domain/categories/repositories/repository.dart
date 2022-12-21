import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';
import 'package:money_management/models/category_model.dart';

import 'i_repository.dart';

class CategoryRepository extends ICategoryRepository {
  @override
  Future<bool> insert({required CategoryModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      listOld!.insert(0, value);
      await HiveUtil.instant.boxCategories
          .put(HiveKeyConstant.categories, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update({required CategoryModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      for (CategoryModel element in listOld!) {
        if (element.id == value.id) {
          element = value;
          break;
        }
      }
      await HiveUtil.instant.boxCategories
          .put(HiveKeyConstant.categories, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete({required CategoryModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      listOld!.remove(value);
      await HiveUtil.instant.boxCategories
          .put(HiveKeyConstant.categories, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CategoryModel>> getAll({String? search}) async {
    try {
      final listOld = HiveUtil.instant.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      return listOld ?? [];
    } catch (e) {
      return [];
    }
  }
}
