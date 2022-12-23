import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';

part 'input_money_event.dart';
part 'input_money_state.dart';

class InputMoneyBloc extends Bloc<InputMoneyEvent, InputMoneyState> {
  InputMoneyBloc() : super(InputMoneyInitial()) {
    on<InputInsertEvent>(_onInputInsertEvent);
  }

  MoneyUseCase useCase = MoneyUseCase(MoneyRepository());

  FutureOr<void> _onInputInsertEvent(
      InputInsertEvent event, Emitter<InputMoneyState> emit) async {
    MoneyModel data = MoneyModel(
        category: event.categoryModel,
        createDated: event.dateTime,
        money: event.money,
        moneyType: event.type,
        note: event.note);

    final result = await useCase.insertPay(value: data);
    if (result.success == true) {
      emit(InputInsertSuccess(message: result.message));
    } else {
      emit(InputInsertFailure(message: result.message));
    }
  }
}
