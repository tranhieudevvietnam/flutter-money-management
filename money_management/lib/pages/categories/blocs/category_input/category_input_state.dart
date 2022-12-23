part of 'category_input_bloc.dart';

@immutable
abstract class CategoryInputState {}

class CategoryInputInitial extends CategoryInputState {
  final String? message;

  CategoryInputInitial({this.message});
}

class CategoryInputCreateSuccess extends CategoryInputInitial {
  CategoryInputCreateSuccess({super.message});
}

class CategoryInputCreateFailure extends CategoryInputInitial {
  CategoryInputCreateFailure({super.message});
}
