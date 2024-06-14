part of 'theme_settings_bloc.dart';

sealed class ThemeSettingsEvent extends Equatable {
  const ThemeSettingsEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeSettingsEvent {
  final ThemeMode themeMode;

  const ThemeChanged(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
