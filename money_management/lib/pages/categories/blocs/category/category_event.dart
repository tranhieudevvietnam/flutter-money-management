part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryGetAllEvent extends CategoryEvent {}

class CategoryGetOneEvent extends CategoryEvent {
  final CategoryModel data;

  CategoryGetOneEvent({required this.data});
}
