import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'features/learn/data/repository/curriculum_repository.dart';
import 'features/learn/data/repository/progress_repository.dart';
import 'features/learn/data/service/local_curriculum_service.dart';
import 'features/learn/data/service/local_progress_service.dart';
import 'features/learn/data/service/remote_curriculum_service.dart';
import 'features/learn/view/screens/learn_screen.dart';
import 'features/learn/viewmodel/learn_viewmodel.dart';
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
  late final LearnViewModel _learnViewModel;

  @override
  void initState() {
    super.initState();
    _learnViewModel = LearnViewModel(
      curriculumRepository: CurriculumRepository(
        remote: RemoteCurriculumService(),
        local: LocalCurriculumService(),
      ),
      progressRepository: ProgressRepository(
        local: LocalProgressService(),
      ),
    );
  }

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
        children: [
          LearnScreen(viewModel: _learnViewModel),
          const PracticeScreen(),
          const PlayScreen(),
          const LibraryScreen(),
          const ProgressScreen(),
        ],
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
