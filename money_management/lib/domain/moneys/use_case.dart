import 'package:money_management/domain/moneys/entities/money_type.dart';
import 'package:money_management/domain/moneys/repositories/i_repository.dart';
import 'package:money_management/domain/result_basic.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';

class MoneyUseCase {
  final IMoneyRepository repo;
  MoneyUseCase(this.repo);

  Future<ResultBasic<bool>> insertPay({required MoneyModel value}) async {
    final result = await repo.insertPay(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<bool>> updatePay({required MoneyModel value}) async {
    final result = await repo.updatePay(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<bool>> deletePay({required MoneyModel value}) async {
    final result = await repo.deletePay(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<List<MoneyModel>>> getAllPay({String? search}) async {
    List<MoneyModel> result = [];
    result = await repo.getAllPay(search: search);
    return ResultBasic(data: result, success: true);
  }

  Future<ResultBasic<List<MoneyModel>>> getAllPayByDateTime(
      {DateTime? dateTime, int? day}) async {
    List<MoneyModel> result = [];
    if (dateTime != null && day != null) {
      result = await repo.getAllPayAnalysis(
          dateTime: dateTime, day: day, isGroupByDateTime: true);
    }
    return ResultBasic(data: result, success: true);
  }

  Future<ResultBasic<List<MoneyModel>>> getDetailAnalysis(
      {required MoneyType moneyType,
      required categoryId,
      DateTime? dateTime,
      int? day}) async {
    List<MoneyModel> result = [];
    if (dateTime != null && day != null) {
      result = await repo.getAllPayAnalysis(
          dateTime: dateTime, day: day, isGroupByDateTime: false);
      result = result
          .where((element) =>
              element.moneyType == moneyType &&
              element.category.id == categoryId)
          .toList();
    }
    return ResultBasic(data: result, success: true);
  }
}
