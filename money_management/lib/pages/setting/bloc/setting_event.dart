part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class SettingChangeLanguageEvent extends SettingEvent {
  final Locale locale;

  SettingChangeLanguageEvent(this.locale);
}

class SettingDeleteDataEvent extends SettingEvent {
  final TypeSettingDelete typeDelete; 
  SettingDeleteDataEvent({required this.typeDelete});
}

enum TypeSettingDelete { dataMoney, dataCategory }
