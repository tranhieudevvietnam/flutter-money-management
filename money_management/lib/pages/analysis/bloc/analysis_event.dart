part of 'analysis_bloc.dart';

@immutable
abstract class AnalysisEvent {}

class AnalysisInitEvent extends AnalysisEvent {
  final DateTime? dateTime;
  final int? day;

  AnalysisInitEvent({this.dateTime, this.day})
      : assert(
            dateTime != null && day != null || dateTime == null && day == null);
}

class AnalysisDetailEvent extends AnalysisEvent {
  final MoneyModel data;
  AnalysisDetailEvent(this.data);
}

class AnalysisDetailByMonthEvent extends AnalysisEvent {
  final DateTime date;
  final MoneyModel data;

  AnalysisDetailByMonthEvent({required this.date,required this.data});
}
