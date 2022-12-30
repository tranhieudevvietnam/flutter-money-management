part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryGetAllSuccess extends CategoryState {
  final List<CategoryModel> listData;

  CategoryGetAllSuccess(this.listData);
}

class CategoryGetOneSuccess extends CategoryState {
  final CategoryModel data;
  CategoryGetOneSuccess(this.data);
}
