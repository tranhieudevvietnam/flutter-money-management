import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';
import 'package:money_management/domain/categories/repositories/repository.dart';
import 'package:money_management/domain/categories/use_case.dart';
import 'package:collection/collection.dart';

part 'category_input_event.dart';
part 'category_input_state.dart';

class CategoryInputBloc extends Bloc<CategoryInputEvent, CategoryInputState> {
  CategoryInputBloc() : super(CategoryInputInitial()) {
    on<CategoryCreateEvent>(_onCategoryCreateEvent);
    on<CategoryCreateSubCategoryEvent>(_onCategoryCreateSubCategoryEvent);
  }
  final CategoryUseCase useCase = CategoryUseCase(CategoryRepository());

  FutureOr<void> _onCategoryCreateEvent(
      CategoryCreateEvent event, Emitter<CategoryInputState> emit) async {
    CategoryModel categoryModel = CategoryModel(
        icon: event.iconData,
        name: event.categoryName,
        subCategories: [],
        note: event.note);
    final result = await useCase.insert(value: categoryModel);
    if (result.success == true) {
      emit(CategoryInputCreateSuccess(message: result.message));
    } else {
      emit(CategoryInputCreateFailure(message: result.message));
    }
  }

  FutureOr<void> _onCategoryCreateSubCategoryEvent(
      CategoryCreateSubCategoryEvent event,
      Emitter<CategoryInputState> emit) async {
    CategoryModel categoryModel = CategoryModel(
        icon: event.iconData,
        name: event.categoryName,
        subCategories: [],
        note: event.note);

    final listCategories = await useCase.getAll();
    final dataCurrent = listCategories.data
        .firstWhereOrNull((element) => element.id == event.data.id);
    if (dataCurrent != null) {
      dataCurrent.subCategories ??= [];
      dataCurrent.subCategories!.add(categoryModel);
      final result = await useCase.update(value: dataCurrent);
      if (result.success == true) {
        emit(CategoryInputCreateSuccess(message: result.message));
      } else {
        emit(CategoryInputCreateFailure(message: result.message));
      }
    } else {
      emit(CategoryInputCreateFailure(message: "Error ^_^"));
    }
  }
}
