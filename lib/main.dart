import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_app/features/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:workshop_app/features/todos/bloc/todos_bloc.dart';
import 'package:workshop_app/layouts/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeSettingsBloc(),
        ),
      ],
      child: BlocBuilder<ThemeSettingsBloc, ThemeSettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.blueAccent).copyWith(
                surface: Colors.grey[50]!,
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueAccent,
                brightness: Brightness.dark,
              ).copyWith(surface: Colors.grey[850]!),
            ),
            themeMode: state.themeMode,
            home: const MainLayout(),
          );
        },
      ),
    );
  }
}
