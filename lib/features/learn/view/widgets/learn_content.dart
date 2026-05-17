import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/phase.dart';
import '../widgets/continue_card.dart';
import '../widgets/phase_card.dart';
import '../widgets/stats_row.dart';

class LearnContent extends StatelessWidget {
  const LearnContent({super.key, required this.phases});
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
