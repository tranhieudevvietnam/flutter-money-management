part of 'analysis_bloc.dart';

@immutable
abstract class AnalysisState {}

class AnalysisInitial extends AnalysisState {}

class AnalysisGetAllPaymentSuccess extends AnalysisState {
  final List<MoneyModel> listDataCollect;
  final List<MoneyModel> listDataPay;
  final num sumCollect;
  final num sumPay;
  AnalysisGetAllPaymentSuccess(
      {required this.listDataCollect,
      required this.listDataPay,
      required this.sumCollect,
      required this.sumPay});
}

// ignore: must_be_immutable
class AnalysisGetAllPaymentFailure extends AnalysisState {
  String? message;
  AnalysisGetAllPaymentFailure({this.message});
}
