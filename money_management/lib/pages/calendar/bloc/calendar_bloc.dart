import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';
import 'package:money_management/models/event_model.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarInitEvent>(_onCalendarInitEvent);
    on<CalendarGetAllByDateEvent>(_onCalendarGetAllByDateEvent);
  }

  MoneyUseCase useCase = MoneyUseCase(MoneyRepository());

  FutureOr<void> _onCalendarInitEvent(
      CalendarInitEvent event, Emitter<CalendarState> emit) async {
    final result = await useCase.getAllPay();
    List<EventModel> listData = [];
    if (result.success == true) {
      for (var item in result.data) {
        listData.add(EventModel(
            dateTime: DateTime(item.createDated.year, item.createDated.month,
                item.createDated.day),
            moneyModel: item));
      }
      emit(CalendarGetAllListDataSuccess(listData));
    } else {
      emit(CalendarGetAllListDataFailure("Error"));
    }
  }

  FutureOr<void> _onCalendarGetAllByDateEvent(
      CalendarGetAllByDateEvent event, Emitter<CalendarState> emit) async {
    final result = await useCase.getAllPayByOneDateTime(
        dateTime: DateTime(
            event.dateTime.year, event.dateTime.month, event.dateTime.day));
    if (result.success == true) {
      emit(CalendarGetAllByDateSuccess(result.data));
    } else {
      emit(CalendarGetAllListDataFailure("Error"));
    }
  }
}
