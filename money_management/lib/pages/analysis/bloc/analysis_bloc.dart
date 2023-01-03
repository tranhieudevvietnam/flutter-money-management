import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/entities/money_type.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(AnalysisInitial()) {
    on<AnalysisInitEvent>(_onAnalysisInitEvent);
  }

  MoneyUseCase useCase = MoneyUseCase(MoneyRepository());

  FutureOr<void> _onAnalysisInitEvent(
      AnalysisInitEvent event, Emitter<AnalysisState> emit) async {
    final result =
        await useCase.getAllPay(dateTime: event.dateTime, day: event.day);
    if (result.success == true) {
      List<MoneyModel> listDataCollect = [];
      List<MoneyModel> listDataPay = [];
      final sumTotalCollect = result.data
          .where((element) => element.moneyType == MoneyType.collect)
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + element.money.toInt());
      final sumTotalPay = result.data
          .where((element) => element.moneyType == MoneyType.pay)
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + element.money.toInt());

      int index = 0;
      int indexPay = 0;
      int indexCollect = 0;
      result.data.sort((a, b) => b.money.compareTo(a.money));
      while (index < result.data.length) {
        final item = result.data[index];
        if (event.dateTime != null && event.day != null) {
          item.startDate = event.dateTime!.add(Duration(days: -event.day!));
        }
        if (item.moneyType == MoneyType.collect) {
          item.percent = (item.money / sumTotalCollect * 100);
          item.color =
              ColorConst.success.withOpacity(indexCollect % 2 == 0 ? 1.0 : .7);
          listDataCollect.add(item);
          indexCollect++;
        } else {
          item.percent = (item.money / sumTotalPay * 100);
          item.color =
              ColorConst.error.withOpacity(indexPay % 2 == 0 ? 1.0 : .7);
          listDataPay.add(item);
          indexPay++;
        }
        index++;
      }

      // listDataPay.sort((a, b) => b.money.compareTo(a.money));
      // listDataCollect.sort((a, b) => b.money.compareTo(a.money));
      // for (int i = 1; i - 1 < listDataPay.length; i++) {
      //   listDataPay[i - 1].color =
      //       ColorConst.error.withOpacity(i % 2 == 0 ? 1.0 : .7);
      // }
      // for (int i = 1; i - 1 < listDataCollect.length; i++) {
      //   listDataCollect[i - 1].color =
      //       ColorConst.success.withOpacity(i % 2 == 0 ? 1.0 : .7);
      // }

      emit(AnalysisGetAllPaymentSuccess(
          listDataCollect: listDataCollect,
          listDataPay: listDataPay,
          sumCollect: sumTotalCollect,
          sumPay: sumTotalPay));
    } else {
      emit(AnalysisGetAllPaymentFailure(message: "Error"));
    }
  }
}
