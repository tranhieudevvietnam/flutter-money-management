part of 'analysis_bloc.dart';

@immutable
abstract class AnalysisState {}

class AnalysisInitial extends AnalysisState {}

class AnalysisGetAllPaymentSuccess extends AnalysisState {
  final List<MoneyModel> listData;
  AnalysisGetAllPaymentSuccess({required this.listData});
}

// ignore: must_be_immutable
class AnalysisGetAllPaymentFailure extends AnalysisState {
  String? message;
  AnalysisGetAllPaymentFailure({this.message});
}
