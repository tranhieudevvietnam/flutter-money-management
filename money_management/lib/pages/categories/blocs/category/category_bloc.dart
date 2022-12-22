import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/categories/repositories/repository.dart';
import 'package:money_management/domain/categories/use_case.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    useCase = CategoryUseCase(CategoryRepository());
    on<CategoryGetAllEvent>(_onCategoryGetAllEvent);
  }

  late CategoryUseCase useCase;

  FutureOr<void> _onCategoryGetAllEvent(
      CategoryGetAllEvent event, Emitter<CategoryState> emit) async {
    final result = await useCase.getAll();
    emit(CategoryGetAllSuccess(result.data));
  }




}
