import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';

class Footer extends StatelessWidget {
  final String currentRouteName;

  const Footer({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BottomNavigationBar(
      currentIndex: _calculateSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.footerHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list_alt_outlined),
          activeIcon: const Icon(Icons.list_alt),
          label: l10n.footerTasks,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school_outlined),
          activeIcon: const Icon(Icons.school),
          label: l10n.footerDisciplines,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings_outlined),
          activeIcon: const Icon(Icons.settings),
          label: l10n.footerSettings,
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