import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/entities/money_type.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';
import 'package:money_management/utils/datetime_utils.dart';

import '../charts/line_chart/chart_line.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(AnalysisInitial()) {
    on<AnalysisInitEvent>(_onAnalysisInitEvent);
    on<AnalysisDetailEvent>(_onAnalysisDetailEvent);
    on<AnalysisDetailByMonthEvent>(_onAnalysisDetailByMonthEvent);
  }

  MoneyUseCase useCase = MoneyUseCase(MoneyRepository());

  DateTime? dateTimeCurrent;
  int? dayCurrent;

  //#region get list data
  FutureOr<void> _onAnalysisInitEvent(
      AnalysisInitEvent event, Emitter<AnalysisState> emit) async {
    dateTimeCurrent = event.dateTime;
    dayCurrent = event.day;
    final result = await useCase.getAllPayByDateTime(
        dateTime: event.dateTime, day: event.day);
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

      emit(AnalysisGetAllPaymentSuccess(
          listDataCollect: listDataCollect,
          listDataPay: listDataPay,
          sumCollect: sumTotalCollect,
          sumPay: sumTotalPay));
    } else {
      emit(AnalysisGetAllPaymentFailure(message: "Error"));
    }
  }
  //#endregion

  //#region get detail
  FutureOr<void> _onAnalysisDetailEvent(
      AnalysisDetailEvent event, Emitter<AnalysisState> emit) async {
    List<ChartModel> listCharts = [];
    final dateTemp = DateTime.now();
    DateTime dateTimeKnow =
        DateTime(dateTemp.year, dateTemp.month, dateTemp.daysInMonth);

    for (int i = 1; i <= 12; i++) {
      listCharts.insert(
          0,
          ChartModel(
              time: "T${dateTimeKnow.month}",
              date: dateTimeKnow,
              value: 0,
              color: event.data.moneyType == MoneyType.collect
                  ? ColorConst.success
                  : ColorConst.error));
      final days = dateTimeKnow.daysInMonth;

      dateTimeKnow = dateTimeKnow.add(Duration(days: -days));
    }

    final result = await useCase.getDetailAnalysis(
        categoryId: event.data.category.id,
        moneyType: event.data.moneyType!,
        dateTime: dateTemp,
        day: dateTemp.daysInMonth);
    if (result.success == true) {
      for (MoneyModel item in result.data) {
        int index = listCharts.indexWhere(
            (element) => element.time == "T${item.createDated.month}");
        listCharts[index].value += item.money;
      }
      result.data.sort(((a, b) => b.createDated.compareTo(a.createDated)));
      emit(AnalysisDetailState(
          success: true, listCharts: listCharts, listData: result.data));
    } else {
      emit(AnalysisDetailState(
          success: false,
          message: "Error",
          listCharts: const [],
          listData: const []));
    }
  }

  FutureOr<void> _onAnalysisDetailByMonthEvent(
      AnalysisDetailByMonthEvent event, Emitter<AnalysisState> emit) async {
    final result = await useCase.getDetailAnalysis(
        categoryId: event.data.category.id,
        moneyType: event.data.moneyType!,
        dateTime:
            DateTime(event.date.year, event.date.month, event.date.daysInMonth),
        day: event.date.daysInMonth);
    if (result.success == true) {
      result.data.sort(((a, b) => b.createDated.compareTo(a.createDated)));
      emit(AnalysisDetailByMonthState(success: true, listData: result.data));
    } else {
      emit(AnalysisDetailByMonthState(
          success: false, message: "Error", listData: const []));
    }
  }
  //#endregion

}
