import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'features/learn/learn_screen.dart';
import 'features/library/library_screen.dart';
import 'features/play/play_screen.dart';
import 'features/practice/practice_screen.dart';
import 'features/progress/progress_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static final _screens = [
    LearnScreen(),
    PracticeScreen(),
    PlayScreen(),
    LibraryScreen(),
    ProgressScreen(),
  ];

  static final _destinations = [
    NavigationDestination(
      icon: PhosphorIcon(PhosphorIcons.bookOpen()),
      selectedIcon: PhosphorIcon(PhosphorIcons.bookOpen(PhosphorIconsStyle.fill)),
      label: 'Learn',
    ),
    NavigationDestination(
      icon: PhosphorIcon(PhosphorIcons.pencilSimple()),
      selectedIcon: PhosphorIcon(PhosphorIcons.pencilSimple(PhosphorIconsStyle.fill)),
      label: 'Practice',
    ),
    NavigationDestination(
      icon: PhosphorIcon(PhosphorIcons.gameController()),
      selectedIcon: PhosphorIcon(PhosphorIcons.gameController(PhosphorIconsStyle.fill)),
      label: 'Play',
    ),
    NavigationDestination(
      icon: PhosphorIcon(PhosphorIcons.books()),
      selectedIcon: PhosphorIcon(PhosphorIcons.books(PhosphorIconsStyle.fill)),
      label: 'Library',
    ),
    NavigationDestination(
      icon: PhosphorIcon(PhosphorIcons.chartBar()),
      selectedIcon: PhosphorIcon(PhosphorIcons.chartBar(PhosphorIconsStyle.fill)),
      label: 'Progress',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) =>
            setState(() => _currentIndex = index),
        destinations: _destinations,
      ),
    );
  }
}
