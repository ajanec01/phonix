import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatChip(value: '0', label: 'Sounds'),
        const SizedBox(width: 10),
        _StatChip(value: '—', label: 'Accuracy'),
        const SizedBox(width: 10),
        _StatChip(value: '0', label: 'Stars'),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
