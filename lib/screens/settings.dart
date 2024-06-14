import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_app/features/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:workshop_app/widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: BlocBuilder<ThemeSettingsBloc, ThemeSettingsState>(
        builder: (context, state) {
          return Column(
            children: [
              Image.network(
                'https://cdn0.iconfinder.com/data/icons/apple-apps/100/Apple_Settings-512.png',
                scale: 1,
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: const Text('Light Theme'),
                    leading:
                        _themeIcon(state.themeMode, ThemeMode.light, context),
                    onTap: () {
                      context
                          .read<ThemeSettingsBloc>()
                          .add(const ThemeChanged(ThemeMode.light));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Dark Theme'),
                    leading:
                        _themeIcon(state.themeMode, ThemeMode.dark, context),
                    onTap: () {
                      context
                          .read<ThemeSettingsBloc>()
                          .add(const ThemeChanged(ThemeMode.dark));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('System Theme'),
                    leading: _themeIcon(
                      state.themeMode,
                      ThemeMode.system,
                      context,
                    ),
                    onTap: () {
                      context
                          .read<ThemeSettingsBloc>()
                          .add(const ThemeChanged(ThemeMode.system));
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _themeIcon(
    ThemeMode currentTheme,
    ThemeMode theme,
    BuildContext context,
  ) {
    return Icon(
      currentTheme == theme
          ? Icons.check_box_outlined
          : Icons.check_box_outline_blank,
      color: currentTheme == theme
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
    );
  }
}
