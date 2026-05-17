import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../theme/app_colors.dart';
import '../../data/repository/curriculum_repository.dart';
import '../../data/service/local_curriculum_service.dart';
import '../../data/service/remote_curriculum_service.dart';
import '../../domain/model/phase.dart';
import '../../viewmodel/learn_state.dart';
import '../../viewmodel/learn_viewmodel.dart';
import '../widgets/continue_card.dart';
import '../widgets/phase_card.dart';
import '../widgets/stats_row.dart';

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
      repository: CurriculumRepository(
        remote: RemoteCurriculumService(),
        local: LocalCurriculumService(),
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
            LearnStateLoading() => const _LearnSkeleton(),
            LearnStateLoaded(:final phases) => _LearnContent(phases: phases),
            LearnStateError(:final message) => _LearnError(message: message),
          };
        },
      ),
    );
  }
}

class _LearnContent extends StatelessWidget {
  const _LearnContent({required this.phases});
  final List<Phase> phases;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          backgroundColor: AppColors.surfaceContainerLow,
          surfaceTintColor: Colors.transparent,
          title: const Text('Learn'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContinueCard(phase: phases.first),
                const SizedBox(height: 24),
                const StatsRow(),
                const SizedBox(height: 32),
                Text(
                  'Phases',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          sliver: SliverList.separated(
            itemCount: phases.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) => PhaseCard(phase: phases[index]),
          ),
        ),
      ],
    );
  }
}

class _LearnSkeleton extends StatelessWidget {
  const _LearnSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceContainerHigh,
      highlightColor: AppColors.surfaceContainerLow,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text('Learn'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(height: 96, radius: 16),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _ShimmerBox(height: 70, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: _ShimmerBox(height: 70, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: _ShimmerBox(height: 70, radius: 12)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _ShimmerBox(height: 18, radius: 4, width: 56),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList.separated(
              itemCount: 6,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, _) => _ShimmerBox(height: 66, radius: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.height, required this.radius, this.width});
  final double height;
  final double radius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _LearnError extends StatelessWidget {
  const _LearnError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          backgroundColor: AppColors.surfaceContainerLow,
          surfaceTintColor: Colors.transparent,
          title: const Text('Learn'),
        ),
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
