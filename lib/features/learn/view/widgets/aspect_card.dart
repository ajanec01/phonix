import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/aspect.dart';
import '../screens/aspect_screen.dart';
import 'aspect_icons.dart';

class AspectCard extends StatelessWidget {
  const AspectCard({
    super.key,
    required this.aspect,
    required this.color,
    required this.foregroundColor,
  });
  final Aspect aspect;
  final Color color;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? AppColors.surfaceContainerLowestDark
        : AppColors.surfaceContainerLowest;
    final borderColor =
        isDark ? AppColors.outlineVariantDark : AppColors.outlineVariant;
    final chevronColor =
        isDark ? AppColors.onSurfaceVariantDark : AppColors.onSurfaceVariant;

    void navigate() => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => AspectScreen(
              aspect: aspect,
              color: color,
              foregroundColor: foregroundColor,
            ),
          ),
        );
    return Semantics(
      button: true,
      container: true,
      onTap: navigate,
      child: GestureDetector(
        onTap: navigate,
        excludeFromSemantics: true,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
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
                    size: 20, color: foregroundColor),
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
                          label: aspect.activityLabel,
                          color: color,
                          foregroundColor: foregroundColor,
                        ),
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
              Icon(CupertinoIcons.chevron_right,
                  size: 14, color: chevronColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityTag extends StatelessWidget {
  const _ActivityTag({
    required this.label,
    required this.color,
    required this.foregroundColor,
  });
  final String label;
  final Color color;
  final Color foregroundColor;

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
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
