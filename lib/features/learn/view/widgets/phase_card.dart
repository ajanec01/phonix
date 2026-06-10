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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? AppColors.surfaceContainerLowestDark
        : AppColors.surfaceContainerLowest;
    final borderColor =
        isDark ? AppColors.outlineVariantDark : AppColors.outlineVariant;
    final stripeColor = isDark
        ? AppColors.phasesOnDark[phase.id - 1]
        : AppColors.phasesOnLight[phase.id - 1];
    final chevronColor =
        isDark ? AppColors.onSurfaceVariantDark : AppColors.onSurfaceVariant;

    return SemanticButton(
      onPressed: () => _navigateToPhase(context, phase),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                color: stripeColor,
              ),
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
                        color: chevronColor,
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

void _navigateToPhase(BuildContext context, Phase phase) {
  Navigator.of(context).push(
    CupertinoPageRoute(
      builder: (_) => PhaseScreen(phase: phase),
    ),
  );
}
