import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/semantic_button.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/phase.dart';
import '../screens/phase_screen.dart';

class PhaseCard extends StatelessWidget {
  const PhaseCard({super.key, required this.phase});
  final Phase phase;

  @override
  Widget build(BuildContext context) {
    return SemanticButton(
      onPressed: () => _navigateToPhase(context, phase),
      borderRadius: BorderRadius.circular(14),
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
              Container(width: 4, color: _stripeColor(phase.id)),
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
                      const Icon(
                        CupertinoIcons.chevron_right,
                        size: 16,
                        color: AppColors.onSurfaceVariant,
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

// Option A stripe rule: only phases 1–3 fall below the 3:1 UI-component
// threshold with the original phaseN token, so they take the darker companion.
// phases 4–6 keep the original phaseN — both already clear 3:1 on white.
Color _stripeColor(int phaseId) =>
    phaseId <= 3 ? AppColors.phasesOnLight[phaseId - 1] : AppColors.phases[phaseId - 1];

void _navigateToPhase(BuildContext context, Phase phase) {
  Navigator.of(context).push(
    CupertinoPageRoute(
      builder: (_) => PhaseScreen(phase: phase),
    ),
  );
}
