import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../data/curriculum.dart';
import 'continue_card.dart';
import 'stats_row.dart';
import 'phase1_screen.dart';

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
              itemBuilder: (context, index) => _PhaseCard(phase: phases[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({required this.phase});
  final PhaseInfo phase;

  @override
  Widget build(BuildContext context) {
    final isImplemented = phase.id == 1;

    return GestureDetector(
      onTap: isImplemented ? () => _navigateToPhase(context, phase) : null,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Accent strip
              Container(width: 4, color: phase.color),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              phase.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              phase.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 16,
                        color: isImplemented
                            ? AppColors.onSurfaceVariant
                            : AppColors.outlineVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToPhase(BuildContext context, PhaseInfo phase) {
  if (phase.id == 1) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const Phase1Screen()),
    );
  }
}
