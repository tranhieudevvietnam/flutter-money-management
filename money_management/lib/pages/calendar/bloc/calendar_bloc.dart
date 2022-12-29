import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarInitEvent>(_onCalendarInitEvent);
  }

  MoneyUseCase useCase = MoneyUseCase(MoneyRepository());

  FutureOr<void> _onCalendarInitEvent(
      CalendarInitEvent event, Emitter<CalendarState> emit) async {
    final result = await useCase.getAllPay();
    if (result.success == true) {
      emit(CalendarGetAllListDataSuccess(result.data));
    } else {
      emit(CalendarGetAllListDataFailure("Error"));
    }
  }
}
