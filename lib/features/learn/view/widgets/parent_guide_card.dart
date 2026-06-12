import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/semantic_button.dart';
import '../../../../theme/app_colors.dart';

class ParentGuideCard extends StatelessWidget {
  const ParentGuideCard({
    super.key,
    required this.guide,
    required this.expanded,
    required this.onToggle,
    this.headerFocusNode,
  });
  final String guide;
  final bool expanded;
  final VoidCallback onToggle;
  final FocusNode? headerFocusNode;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.onSurfaceDark : AppColors.secondary;
    final backgroundColor = isDark
        ? AppColors.surfaceContainerHighDark
        : AppColors.secondaryContainer;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SemanticButton(
              focusNode: headerFocusNode,
              onPressed: onToggle,
              borderRadius: BorderRadius.circular(14),
              semanticLabel: expanded
                  ? 'Collapse For Parents'
                  : 'Expand For Parents',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.person_fill, size: 16, color: color),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'For Parents',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: color),
                      ),
                    ),
                    Icon(
                      expanded
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      size: 14,
                      color: color,
                    ),
                  ],
                ),
              ),
            ),
            if (expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: color.withValues(alpha: 0.15), height: 1),
                    const SizedBox(height: 14),
                    Text(guide, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
