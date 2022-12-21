import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_input_event.dart';
part 'category_input_state.dart';

class CategoryInputBloc extends Bloc<CategoryInputEvent, CategoryInputState> {
  CategoryInputBloc() : super(CategoryInputInitial()) {
    on<CategoryInputEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
