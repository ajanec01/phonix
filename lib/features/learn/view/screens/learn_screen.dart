import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../data/repository/curriculum_repository.dart';
import '../../data/repository/progress_repository.dart';
import '../../data/service/local_curriculum_service.dart';
import '../../data/service/local_progress_service.dart';
import '../../data/service/remote_curriculum_service.dart';
import '../../viewmodel/learn_state.dart';
import '../../viewmodel/learn_viewmodel.dart';
import '../widgets/learn_content.dart';
import '../widgets/learn_error.dart';
import '../widgets/learn_skeleton.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  late final LearnViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LearnViewModel(
      curriculumRepository: CurriculumRepository(
        remote: RemoteCurriculumService(),
        local: LocalCurriculumService(),
      ),
      progressRepository: ProgressRepository(
        local: LocalProgressService(),
      ),
    );
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      body: StreamBuilder<LearnState>(
        stream: _viewModel.stream,
        initialData: _viewModel.state,
        builder: (context, snapshot) {
          return switch (snapshot.data!) {
            LearnStateLoading() => const LearnSkeleton(),
            LearnStateLoaded(:final phases, :final currentPhase) =>
              LearnContent(phases: phases, currentPhase: currentPhase),
            LearnStateError(:final message) => LearnError(message: message),
          };
        },
      ),
    );
  }
}
