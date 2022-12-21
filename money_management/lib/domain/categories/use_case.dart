import 'package:money_management/domain/categories/repositories/i_repository.dart';
import 'package:money_management/domain/result_basic.dart';

import '../../models/category_model.dart';

class CategoryUseCase {
  final ICategoryRepository repo;
  CategoryUseCase(this.repo);

  Future<ResultBasic<bool>> insert({required CategoryModel value}) async {
    final result = await repo.insert(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<bool>> update({required CategoryModel value}) async {
    final result = await repo.update(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<bool>> delete({required CategoryModel value}) async {
    final result = await repo.delete(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<List<CategoryModel>>> getAll({String? search}) async {
    final result = await repo.getAll(search: search);
    if (result.isNotEmpty == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }
}
