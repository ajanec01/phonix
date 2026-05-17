import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../data/curriculum.dart';
import 'continue_card.dart';
import 'phase_card.dart';
import 'stats_row.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      body: CustomScrollView(
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
      ),
    );
  }
}


