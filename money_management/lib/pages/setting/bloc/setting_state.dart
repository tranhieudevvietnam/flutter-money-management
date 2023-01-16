part of 'setting_bloc.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingCountDataLocalState extends SettingState {
  final int countRowMoney;
  final int countRowCategory;

  SettingCountDataLocalState(this.countRowMoney, this.countRowCategory);
}

class SettingChangeLanguage extends SettingState {
  final Locale locale;

  SettingChangeLanguage(this.locale);
}

class SettingDeleteDataState extends SettingState {
  final bool success;
  final String? message;
  SettingDeleteDataState({required this.success, this.message});
}
