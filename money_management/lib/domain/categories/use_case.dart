import 'repositories/i_repository.dart';
import '../result_basic.dart';

import 'entities/category_model.dart';

class CategoryUseCase {
  final ICategoryRepository repo;
  CategoryUseCase(this.repo);

  Future<ResultBasic<bool>> insert({required CategoryModel value}) async {
    final result = await repo.insert(value: value);
    if (result == true) {
      return ResultBasic(
          data: result, success: true, message: "Insert success.");
    }
    return ResultBasic(
        data: result, success: false, message: "Insert failure.");
  }

  Future<ResultBasic<bool>> update({required CategoryModel value}) async {
    final result = await repo.update(value: value);
    if (result == true) {
      return ResultBasic(
          data: result, success: true, message: "Update success.");
    }
    return ResultBasic(
        data: result, success: false, message: "Update failure.");
  }

  Future<ResultBasic<bool>> delete({required CategoryModel value}) async {
    final result = await repo.delete(value: value);
    if (result == true) {
      return ResultBasic(
          data: result, success: true, message: "Delete success.");
    }
    return ResultBasic(
        data: result, success: false, message: "Delete failure.");
  }

  Future<ResultBasic<List<CategoryModel>>> getAll({String? search}) async {
    final result = await repo.getAll(search: search);
    if (result.isNotEmpty == true) {
      return ResultBasic(
          data: result, success: true, message: "Get All success.");
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<CategoryModel?>> getOne(
      {required CategoryModel data}) async {
    final result = await repo.getAll();
    if (result.isNotEmpty == true) {
      final dataResult = result.firstWhere((element) => element == data);
      return ResultBasic(
          data: dataResult, success: true, message: "Get All success.");
    }
    return ResultBasic(data: null, success: false);
  }
}
