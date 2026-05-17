import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../data/curriculum.dart';
import 'phase1_screen.dart';

class ContinueCard extends StatelessWidget {
  const ContinueCard({super.key, required this.phase});
  final PhaseInfo phase;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPhase(context, phase),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.secondary,
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
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phase.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Sound Awareness',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.arrow_right,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
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
