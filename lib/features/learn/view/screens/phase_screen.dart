import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../data/curriculum.dart';
import '../widgets/aspect_card.dart';
import '../widgets/bullet_list.dart';

class PhaseScreen extends StatefulWidget {
  const PhaseScreen({super.key, required this.phase});
  final PhaseInfo phase;

  @override
  State<PhaseScreen> createState() => _PhaseScreenState();
}

class _PhaseScreenState extends State<PhaseScreen> {
  bool _briefingExpanded = true;

  @override
  Widget build(BuildContext context) {
    final phase = widget.phase;
    final aspects = phase.id == 1 ? phase1Aspects : <Phase1Aspect>[];

    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: AppColors.surfaceContainerLow,
            surfaceTintColor: Colors.transparent,
            title: Text(phase.title),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: _BriefingCard(
                phase: phase,
                expanded: _briefingExpanded,
                onToggle: () =>
                    setState(() => _briefingExpanded = !_briefingExpanded),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Text(
                'Activities',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            sliver: SliverList.separated(
              itemCount: aspects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) =>
                  AspectCard(aspect: aspects[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _BriefingCard extends StatelessWidget {
  const _BriefingCard({
    required this.phase,
    required this.expanded,
    required this.onToggle,
  });
  final PhaseInfo phase;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final color = phase.color;

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
            InkWell(
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
                    _TipsSection(color: color, tips: phase.tipsForHome),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TipsSection extends StatefulWidget {
  const _TipsSection({required this.color, required this.tips});
  final Color color;
  final List<String> tips;

  @override
  State<_TipsSection> createState() => _TipsSectionState();
}

class _TipsSectionState extends State<_TipsSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Icon(CupertinoIcons.lightbulb, size: 15, color: widget.color),
              const SizedBox(width: 6),
              Text(
                'Tips for home',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: widget.color,
                    ),
              ),
              const SizedBox(width: 4),
              Icon(
                _expanded
                    ? CupertinoIcons.chevron_up
                    : CupertinoIcons.chevron_down,
                size: 12,
                color: widget.color,
              ),
            ],
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 10),
          BulletList(items: widget.tips),
        ],
      ],
    );
  }
}
