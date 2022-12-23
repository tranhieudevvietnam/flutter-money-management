part of 'category_input_bloc.dart';

@immutable
abstract class CategoryInputEvent {}

class CategoryCreateEvent extends CategoryInputEvent {
  final String categoryName;
  final String note;
  final String iconData;

  CategoryCreateEvent(
      {required this.categoryName, required this.note, required this.iconData});
}

class CategoryCreateSubCategoryEvent extends CategoryInputEvent {
  final String categoryName;
  final String note;
  final String iconData;
  final CategoryModel data;

  CategoryCreateSubCategoryEvent(
      {required this.data,
      required this.categoryName,
      required this.note,
      required this.iconData});
}
