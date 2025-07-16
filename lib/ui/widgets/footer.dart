import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  final String currentRouteName;

  const Footer({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _calculateSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          activeIcon: Icon(Icons.list_alt),
          label: 'Tarefas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          activeIcon: Icon(Icons.school),
          label: 'Disciplinas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    switch (currentRouteName) {
      case 'home':
        return 0;
      case 'tasks':
        return 1;
      case 'disciplines':
        return 2;
      case 'settings':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/tasks');
        break;
      case 2:
        context.go('/disciplines');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }
}