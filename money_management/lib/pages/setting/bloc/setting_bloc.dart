import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/domain/categories/repositories/repository.dart';
import 'package:money_management/domain/categories/use_case.dart';
import 'package:money_management/domain/moneys/repositories/repository.dart';
import 'package:money_management/domain/moneys/use_case.dart';
import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<SettingCountDataEvent>(_onSettingCountDataEvent);
    on<SettingChangeLanguageEvent>(_onSettingChangeLanguageEvent);
    on<SettingDeleteDataEvent>(_onSettingDeleteDataEvent);
  }

  MoneyUseCase useCaseMoney = MoneyUseCase(MoneyRepository());
  CategoryUseCase useCaseCategory = CategoryUseCase(CategoryRepository());

  FutureOr<void> _onSettingChangeLanguageEvent(
      SettingChangeLanguageEvent event, Emitter<SettingState> emit) {
    HiveUtil.boxLocal.put(HiveKeyConstant.language, event.locale.languageCode);
    emit(SettingChangeLanguage(event.locale));
  }

  FutureOr<void> _onSettingDeleteDataEvent(
      SettingDeleteDataEvent event, Emitter<SettingState> emit) async {
    try {
      switch (event.typeDelete) {
        case TypeSettingDelete.dataMoney:
          await HiveUtil.boxMoney.put(HiveKeyConstant.payMoney, []);
          emit(SettingDeleteDataState(success: true));
          break;
        case TypeSettingDelete.dataCategory:
          await HiveUtil.boxMoney.put(HiveKeyConstant.categories, []);
          emit(SettingDeleteDataState(success: true));
          break;
        default:
          break;
      }
    } catch (e) {
      emit(SettingDeleteDataState(success: false, message: e.toString()));
    }
  }

  FutureOr<void> _onSettingCountDataEvent(
      SettingCountDataEvent event, Emitter<SettingState> emit) async {
    int countMoney = 0;
    int countCategory = 0;

    await Future.delayed(const Duration(seconds: 3));

    final resultMoney = await useCaseMoney.countDataLocal();
    final resultCategory = await useCaseCategory.countDataLocal();

    if (resultMoney.success == true) {
      countMoney = resultMoney.data;
    }
    if (resultCategory.success == true) {
      countCategory = resultCategory.data;
    }

    emit(SettingCountDataLocalState(countMoney, countCategory));
  }
}
