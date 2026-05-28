import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/aspect.dart';
import '../screens/aspect_screen.dart';
import 'aspect_icons.dart';

class AspectCard extends StatelessWidget {
  const AspectCard({super.key, required this.aspect, required this.color});
  final Aspect aspect;
  final Color color;

  @override
  Widget build(BuildContext context) {
    void navigate() => Navigator.of(context).push(
          CupertinoPageRoute(
              builder: (_) => AspectScreen(aspect: aspect, color: color)),
        );
    return MergeSemantics(
      child: Semantics(
        button: true,
        container: true,
        onTap: navigate,
        child: GestureDetector(
          onTap: navigate,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(aspectIcon(aspect.iconKey),
                      size: 20, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              aspect.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _ActivityTag(
                              label: aspect.activityLabel, color: color),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        aspect.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.chevron_right,
                    size: 14, color: AppColors.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityTag extends StatelessWidget {
  const _ActivityTag({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
