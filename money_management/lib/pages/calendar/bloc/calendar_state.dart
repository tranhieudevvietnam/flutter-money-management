part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarGetAllListDataSuccess extends CalendarState {
  final List<MoneyModel> listData;

  CalendarGetAllListDataSuccess(this.listData);
}
class CalendarGetAllListDataFailure extends CalendarState {
  final String message;
  CalendarGetAllListDataFailure(this.message);
}
