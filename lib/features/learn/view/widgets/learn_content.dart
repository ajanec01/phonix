import 'package:flutter/material.dart';
import '../../domain/model/phase.dart';
import 'continue_card.dart';
import 'learn_scroll_view.dart';
import 'phase_card.dart';
import 'stats_row.dart';

class LearnContent extends StatelessWidget {
  const LearnContent({
    super.key,
    required this.phases,
    required this.currentPhase,
  });
  final List<Phase> phases;
  final Phase? currentPhase;

  @override
  Widget build(BuildContext context) {
    return LearnScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentPhase case final phase?) ...[
                  ContinueCard(phase: phase),
                  const SizedBox(height: 24),
                ],
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
