part of 'theme_settings_bloc.dart';

class ThemeSettingsState extends Equatable {
  final ThemeMode themeMode;
  const ThemeSettingsState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
