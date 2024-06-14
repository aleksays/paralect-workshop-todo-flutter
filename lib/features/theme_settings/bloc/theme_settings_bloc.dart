import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_settings_event.dart';
part 'theme_settings_state.dart';

class ThemeSettingsBloc extends Bloc<ThemeSettingsEvent, ThemeSettingsState> {
  ThemeSettingsBloc() : super(const ThemeSettingsState(ThemeMode.system)) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeSettingsState(event.themeMode));
    });
  }
}
