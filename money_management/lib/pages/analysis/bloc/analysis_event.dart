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
