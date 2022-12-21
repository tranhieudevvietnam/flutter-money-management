import 'package:money_management/domain/moneys/repositories/i_repository.dart';
import 'package:money_management/domain/result_basic.dart';
import 'package:money_management/models/money_model.dart';

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

  Future<ResultBasic<bool>> insertCollect({required MoneyModel value}) async {
    final result = await repo.insertCollect(value: value);
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

  Future<ResultBasic<bool>> updateCollect({required MoneyModel value}) async {
    final result = await repo.updateCollect(value: value);
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

  Future<ResultBasic<bool>> deleteCollect({required MoneyModel value}) async {
    final result = await repo.deleteCollect(value: value);
    if (result == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<List<MoneyModel>>> getAllPay({String? search}) async {
    final result = await repo.getAllPay(search: search);
    if (result.isNotEmpty == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }

  Future<ResultBasic<List<MoneyModel>>> getAllCollect({String? search}) async {
    final result = await repo.getAllCollect(search: search);
    if (result.isNotEmpty == true) {
      return ResultBasic(data: result, success: true);
    }
    return ResultBasic(data: result, success: false);
  }
}
