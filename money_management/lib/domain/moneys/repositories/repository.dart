import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';
import '../entities/money_model.dart';

import 'i_repository.dart';

class MoneyRepository extends IMoneyRepository {
  @override
  Future<bool> deleteCollect({required MoneyModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.collectMoney, defaultValue: []);
      listOld!.remove(value);
      await HiveUtil.instant.boxMoney
          .put(HiveKeyConstant.collectMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deletePay({required MoneyModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.payMoney, defaultValue: []);
      listOld!.remove(value);
      await HiveUtil.instant.boxMoney.put(HiveKeyConstant.payMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<MoneyModel>> getAllCollect({String? search}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.collectMoney, defaultValue: []);
      return listOld ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<MoneyModel>> getAllPay({String? search}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.payMoney, defaultValue: []);
      return listOld ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> insertCollect({required MoneyModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.collectMoney, defaultValue: []);
      listOld!.insert(0, value);
      await HiveUtil.instant.boxMoney
          .put(HiveKeyConstant.collectMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> insertPay({required MoneyModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.collectMoney, defaultValue: []);
      listOld!.insert(0, value);
      await HiveUtil.instant.boxMoney
          .put(HiveKeyConstant.collectMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateCollect({required MoneyModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.collectMoney, defaultValue: []);
      for (MoneyModel element in listOld!) {
        if (element.id == value.id) {
          element = value;
          break;
        }
      }
      await HiveUtil.instant.boxMoney
          .put(HiveKeyConstant.collectMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updatePay({required MoneyModel value}) async {
    try {
      final listOld = HiveUtil.instant.boxMoney
          .get(HiveKeyConstant.payMoney, defaultValue: []);
      for (MoneyModel element in listOld!) {
        if (element.id == value.id) {
          element = value;
          break;
        }
      }
      await HiveUtil.instant.boxMoney.put(HiveKeyConstant.payMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }
}
