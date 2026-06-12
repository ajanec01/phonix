import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/semantic_button.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/phase.dart';
import 'bullet_list.dart';
import 'tips_section.dart';

class BriefingCard extends StatelessWidget {
  const BriefingCard({
    super.key,
    required this.phase,
    required this.expanded,
    required this.onToggle,
    this.headerFocusNode,
  });
  final Phase phase;
  final bool expanded;
  final VoidCallback onToggle;
  final FocusNode? headerFocusNode;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark
        ? AppColors.phasesDark[phase.id - 1]
        : AppColors.phases[phase.id - 1];
    final foregroundColor = isDark
        ? AppColors.phasesOnDark[phase.id - 1]
        : AppColors.phasesOnLight[phase.id - 1];
    final headerRadius = BorderRadius.circular(14);

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: surfaceColor.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SemanticButton(
              focusNode: headerFocusNode,
              onPressed: onToggle,
              borderRadius: headerRadius,
              semanticLabel: expanded
                  ? 'Collapse About ${phase.title}'
                  : 'Expand About ${phase.title}',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.info_circle_fill,
                        size: 18, color: foregroundColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'About ${phase.title}',
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: foregroundColor,
                                ),
                      ),
                    ),
                    Icon(
                      expanded
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      size: 14,
                      color: foregroundColor,
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
                    Divider(
                        color: surfaceColor.withValues(alpha: 0.2), height: 1),
                    const SizedBox(height: 14),
                    Text(
                      phase.about,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    BulletList(items: phase.learningGoals),
                    const SizedBox(height: 16),
                    TipsSection(
                        color: foregroundColor, tips: phase.tipsForHome),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
