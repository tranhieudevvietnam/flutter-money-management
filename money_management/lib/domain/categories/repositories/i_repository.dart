
import 'package:money_management/models/category_model.dart';

abstract class ICategoryRepository {
  Future<bool> insert({required CategoryModel value});
  Future<bool> update({required CategoryModel value});
  Future<bool> delete({required CategoryModel value});
  Future<List<CategoryModel>> getAll({String? search});
}
