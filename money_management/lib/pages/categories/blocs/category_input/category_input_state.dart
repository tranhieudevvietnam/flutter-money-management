part of 'category_input_bloc.dart';

@immutable
abstract class CategoryInputState {
  final String? message;
  CategoryInputState({this.message});
}

class CategoryInputInitial extends CategoryInputState {
  CategoryInputInitial({super.message});
}

class CategoryInputCreateSuccess extends CategoryInputInitial {
  CategoryInputCreateSuccess({super.message});
}

 class CategoryInputCreateFailure extends CategoryInputInitial {
  CategoryInputCreateFailure({super.message});
}

class CategoryChangeSuccess extends CategoryInputInitial{
  CategoryChangeSuccess({super.message});
}
class CategoryChangeFailure extends CategoryInputInitial{
  CategoryChangeFailure({super.message});
}