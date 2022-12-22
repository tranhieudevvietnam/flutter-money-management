
import 'package:money_management/domain/categories/entities/category_model.dart';

abstract class ICategoryRepository {
  Future<bool> insert({required CategoryModel value});
  Future<bool> update({required CategoryModel value});
  Future<bool> delete({required CategoryModel value});
  Future<List<CategoryModel>> getAll({String? search});
}
