import 'package:flutter/material.dart';
import 'package:workshop_app/screens/home.dart';
import 'package:workshop_app/screens/settings.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const SettingsScreen(),
  ];
  int _activeScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeScreen,
        onTap: (int index) {
          setState(() => _activeScreen = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
