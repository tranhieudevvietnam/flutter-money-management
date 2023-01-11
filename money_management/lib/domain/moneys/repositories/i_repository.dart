import 'package:money_management/domain/moneys/entities/money_model.dart';

abstract class IMoneyRepository {
  Future<bool> insertPay({required MoneyModel value});
  Future<bool> updatePay({required MoneyModel value});
  Future<bool> deletePay({required MoneyModel value});
  Future<List<MoneyModel>> getAllPay({String? search});
  Future<List<MoneyModel>> getAllPayAnalysis({required DateTime dateTime,required int day, required bool isGroupByDateTime});
}
