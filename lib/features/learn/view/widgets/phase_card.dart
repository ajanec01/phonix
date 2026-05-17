import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../data/curriculum.dart';
import '../screens/phase1_screen.dart';

class PhaseCard extends StatelessWidget {
  const PhaseCard({super.key, required this.phase});
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
              Container(width: 4, color: phase.color),
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
