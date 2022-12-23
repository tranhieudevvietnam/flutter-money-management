import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';

import 'i_repository.dart';

class CategoryRepository extends ICategoryRepository {
  @override
  Future<bool> insert({required CategoryModel value}) async {
    try {
      final listOld = HiveUtil.boxCategories.get(
        HiveKeyConstant.categories,defaultValue: []
      );
      listOld!.insert(0, value);
      await HiveUtil.boxCategories.put(HiveKeyConstant.categories, listOld);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update({required CategoryModel value}) async {
    try {
      final listOld = HiveUtil.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      for (CategoryModel element in listOld!) {
        if (element.id == value.id) {
          element = value;
          break;
        }
      }
      await HiveUtil.boxCategories.put(HiveKeyConstant.categories, listOld);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete({required CategoryModel value}) async {
    try {
      final listOld = HiveUtil.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      listOld!.remove(value);
      await HiveUtil.boxCategories.put(HiveKeyConstant.categories, listOld);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getAll({String? search}) async {
    try {
      final listOld = HiveUtil.boxCategories
          .get(HiveKeyConstant.categories, defaultValue: []);
      return listOld?.cast<CategoryModel>()??[];
    } catch (e) {
      return [];
    }
  }
}
