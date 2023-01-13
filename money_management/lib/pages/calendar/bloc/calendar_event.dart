part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent {}

class CalendarInitEvent extends CalendarEvent {}


class CalendarGetAllByDateEvent extends CalendarEvent{
  final DateTime dateTime;

  CalendarGetAllByDateEvent(this.dateTime);
}
