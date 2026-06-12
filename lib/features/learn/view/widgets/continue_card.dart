import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/phase.dart';
import '../screens/phase_screen.dart';

class ContinueCard extends StatelessWidget {
  const ContinueCard({super.key, required this.phase});
  final Phase phase;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // In dark mode the card sat on `surfaceContainerHighestDark` (#48484A),
    // which dragged the 60%-alpha label contrast to ~4.47:1 — under WCAG AA.
    // `surfaceContainerDark` (#2C2C2E) restores ~5.88:1 against onSecondary@60%
    // and matches the elevation used by other dark-mode cards.
    final backdropColor =
        isDark ? AppColors.surfaceContainerDark : AppColors.secondary;
    void navigate() => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => PhaseScreen(phase: phase),
          ),
        );
    return Semantics(
      label: 'Continue ${phase.title}',
      hint: phase.description,
      button: true,
      excludeSemantics: true,
      onTap: navigate,
      child: GestureDetector(
        onTap: navigate,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backdropColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Continue',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.onSecondary.withValues(alpha: 0.6),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phase.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.onSecondary,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      phase.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onSecondary.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.onSecondary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.arrow_right,
                  color: AppColors.onSecondary,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
