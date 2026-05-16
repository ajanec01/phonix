import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  static const _screens = [
    LearnScreen(),
    PracticeScreen(),
    PlayScreen(),
    LibraryScreen(),
    ProgressScreen(),
  ];

  static const _destinations = [
    NavigationDestination(
      icon: Icon(CupertinoIcons.book),
      selectedIcon: Icon(CupertinoIcons.book_fill),
      label: 'Learn',
    ),
    NavigationDestination(
      icon: Icon(CupertinoIcons.pencil_circle),
      selectedIcon: Icon(CupertinoIcons.pencil_circle_fill),
      label: 'Practice',
    ),
    NavigationDestination(
      icon: Icon(CupertinoIcons.game_controller),
      selectedIcon: Icon(CupertinoIcons.game_controller_solid),
      label: 'Play',
    ),
    NavigationDestination(
      icon: Icon(CupertinoIcons.square_stack_3d_up),
      selectedIcon: Icon(CupertinoIcons.square_stack_3d_up_fill),
      label: 'Library',
    ),
    NavigationDestination(
      icon: Icon(CupertinoIcons.graph_circle),
      selectedIcon: Icon(CupertinoIcons.graph_circle_fill),
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
