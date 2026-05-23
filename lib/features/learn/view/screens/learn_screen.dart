import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../viewmodel/learn_state.dart';
import '../../viewmodel/learn_viewmodel.dart';
import '../widgets/learn_content.dart';
import '../widgets/learn_error.dart';
import '../widgets/learn_skeleton.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key, required this.viewModel});
  final LearnViewModel viewModel;

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.load();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return switch (widget.viewModel.state) {
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
