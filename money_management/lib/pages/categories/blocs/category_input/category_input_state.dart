part of 'category_input_bloc.dart';

@immutable
abstract class CategoryInputState {
  final String? message;
  const CategoryInputState({this.message});
}

class CategoryInputInitial extends CategoryInputState {
  const CategoryInputInitial({super.message});
}

class CategoryInputCreateSuccess extends CategoryInputInitial {
  const CategoryInputCreateSuccess({super.message});
}

 class CategoryInputCreateFailure extends CategoryInputInitial {
  const CategoryInputCreateFailure({super.message});
}

class CategoryChangeSuccess extends CategoryInputInitial{
  const CategoryChangeSuccess({super.message});
}
class CategoryChangeFailure extends CategoryInputInitial{
  const CategoryChangeFailure({super.message});
}