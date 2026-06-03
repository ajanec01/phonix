import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final color = AppColors.phases[phase.id - 1];

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: expanded
                  ? 'Collapse About ${phase.title}'
                  : 'Expand About ${phase.title}',
              button: true,
              child: InkWell(
                focusNode: headerFocusNode,
                onTap: onToggle,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.info_circle_fill,
                          size: 18, color: color),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'About ${phase.title}',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: color,
                                  ),
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
            ),
            if (expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: color.withValues(alpha: 0.2), height: 1),
                    const SizedBox(height: 14),
                    Text(
                      phase.about,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    BulletList(items: phase.learningGoals),
                    const SizedBox(height: 16),
                    TipsSection(color: color, tips: phase.tipsForHome),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
