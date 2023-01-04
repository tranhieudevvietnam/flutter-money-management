part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class SettingChangeLanguageEvent extends SettingEvent{
  final Locale locale;

  SettingChangeLanguageEvent(this.locale);
}
