import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';
import 'dart:math' as math;

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(AnalysisInitial()) {
    on<AnalysisInitEvent>(_onAnalysisInitEvent);
  }

  MoneyUseCase useCase = MoneyUseCase(MoneyRepository());

  FutureOr<void> _onAnalysisInitEvent(
      AnalysisInitEvent event, Emitter<AnalysisState> emit) async {
    final result = await useCase.getAllPay();
    if (result.success == true) {
      List<MoneyModel> listData = [];
      final sumTotal = result.data.fold(
          0, (previousValue, element) => previousValue + element.money.toInt());
      for (MoneyModel item in result.data) {
        item.percent = (item.money / sumTotal * 100);
        item.color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
        listData.add(item);
      }
      emit(AnalysisGetAllPaymentSuccess(listData: listData));
    } else {
      emit(AnalysisGetAllPaymentFailure(message: "Error"));
    }
  }
}
