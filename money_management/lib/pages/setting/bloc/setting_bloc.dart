import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<SettingChangeLanguageEvent>(_onSettingChangeLanguageEvent);
  }

  FutureOr<void> _onSettingChangeLanguageEvent(
      SettingChangeLanguageEvent event, Emitter<SettingState> emit) {
    HiveUtil.boxLocal.put(HiveKeyConstant.language, event.locale.languageCode);
    emit(SettingChangeLanguage(event.locale));
  }
}
