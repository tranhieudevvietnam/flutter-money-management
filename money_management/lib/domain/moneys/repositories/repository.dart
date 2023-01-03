import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';
import '../entities/money_model.dart';
import 'package:collection/collection.dart';

import 'i_repository.dart';

class MoneyRepository extends IMoneyRepository {
  @override
  Future<bool> deletePay({required MoneyModel value}) async {
    try {
      final listOld =
          HiveUtil.boxMoney.get(HiveKeyConstant.payMoney, defaultValue: []);
      listOld!.remove(value);
      await HiveUtil.boxMoney.put(HiveKeyConstant.payMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<MoneyModel>> getAllPay({String? search}) async {
    try {
      final listOld =
          HiveUtil.boxMoney.get(HiveKeyConstant.payMoney, defaultValue: []);
      final listData = listOld?.cast<MoneyModel>() ?? [];
      return listData;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> insertPay({required MoneyModel value}) async {
    try {
      final listOld =
          HiveUtil.boxMoney.get(HiveKeyConstant.payMoney, defaultValue: []);
      final dataOld = listOld?.firstWhereOrNull((element) {
        if (element.category!.id == value.category.id &&
            DateTime(element.createDated.year, element.createDated.month,
                        element.createDated.day)
                    .difference(DateTime(value.createDated.year,
                        value.createDated.month, value.createDated.day))
                    .inDays ==
                0) {
          return true;
        }
        return false;
      });
      if (dataOld != null) {
        dataOld.money += value.money;
      } else {
        listOld?.insert(0, value);
      }
      await HiveUtil.boxMoney.put(HiveKeyConstant.payMoney, listOld ?? []);
      // await HiveUtil.boxMoney.put(HiveKeyConstant.payMoney, []);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updatePay({required MoneyModel value}) async {
    try {
      final listOld =
          HiveUtil.boxMoney.get(HiveKeyConstant.payMoney, defaultValue: []);
      for (MoneyModel element in listOld!) {
        if (element.id == value.id) {
          element = value;
          break;
        }
      }
      await HiveUtil.boxMoney.put(HiveKeyConstant.payMoney, listOld);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<MoneyModel>> getAllPayAnalysis(
      {required DateTime dateTime, required int day}) async {
    try {
      final listOld =
          HiveUtil.boxMoney.get(HiveKeyConstant.payMoney, defaultValue: []);
      final listData = listOld?.cast<MoneyModel>() ?? [];
      List<MoneyModel> listData3 = [];

      final startDate = dateTime.add(Duration(days: -day));
      final endDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      final listData2 = listData
          .where((element) =>
              element.createDated.difference(startDate).inDays > 0 &&
              DateTime(element.createDated.year, element.createDated.month,
                          element.createDated.day)
                      .difference(endDate)
                      .inDays <=
                  0)
          .toList();
      for (var item in listData2) {
        final index = listData3
            .indexWhere((element) => element.category.id == item.category.id
                //  &&
                // DateTime(element.createDated.year, element.createDated.month,
                //             element.createDated.day)
                //         .difference(DateTime(item.createDated.year,
                //             item.createDated.month, item.createDated.day))
                //         .inDays ==
                //     0
                );
        if (index >= 0) {
          listData3[index].money += item.money;
        } else {
          listData3.add(item);
        }
      }

      return listData3;
    } catch (e) {
      return [];
    }
  }
}
