import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../data/curriculum.dart';
import '../screens/phase_screen.dart';

class PhaseCard extends StatelessWidget {
  const PhaseCard({super.key, required this.phase});
  final PhaseInfo phase;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPhase(context, phase),
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

void _navigateToPhase(BuildContext context, PhaseInfo phase) {
  Navigator.of(context).push(
    CupertinoPageRoute(builder: (_) => PhaseScreen(phase: phase)),
  );
}
