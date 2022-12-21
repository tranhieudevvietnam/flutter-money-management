import 'package:money_management/models/money_model.dart';

abstract class IMoneyRepository {
  Future<bool> insertPay({required MoneyModel value});
  Future<bool> insertCollect({required MoneyModel value});
  Future<bool> updatePay({required MoneyModel value});
  Future<bool> updateCollect({required MoneyModel value});
  Future<bool> deletePay({required MoneyModel value});
  Future<bool> deleteCollect({required MoneyModel value});
  Future<List<MoneyModel>> getAllPay({String? search});
  Future<List<MoneyModel>> getAllCollect({String? search});
}
