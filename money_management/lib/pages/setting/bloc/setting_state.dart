part of 'setting_bloc.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingChangeLanguage extends SettingState {
  final Locale locale;

  SettingChangeLanguage(this.locale);
}

class SettingDeleteDataState extends SettingState {
  final bool success;
  final String? message;
  SettingDeleteDataState({required this.success, this.message});
}
