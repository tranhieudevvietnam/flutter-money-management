part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarGetAllListDataSuccess extends CalendarState {
  final List<EventModel> listData;

  CalendarGetAllListDataSuccess(this.listData);
}
class CalendarGetAllListDataFailure extends CalendarState {
  final String message;
  CalendarGetAllListDataFailure(this.message);
}


class CalendarGetAllByDateSuccess extends CalendarState {
  final List<MoneyModel> listData;

  CalendarGetAllByDateSuccess(this.listData);
}