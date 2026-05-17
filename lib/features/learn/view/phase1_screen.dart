import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../data/curriculum.dart';
import 'aspect_screen.dart';

class Phase1Screen extends StatefulWidget {
  const Phase1Screen({super.key});

  @override
  State<Phase1Screen> createState() => _Phase1ScreenState();
}

class _Phase1ScreenState extends State<Phase1Screen> {
  bool _briefingExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: AppColors.surfaceContainerLow,
            surfaceTintColor: Colors.transparent,
            title: const Text('Phase 1'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: _BriefingCard(
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
              itemCount: phase1Aspects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) =>
                  _AspectCard(aspect: phase1Aspects[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _BriefingCard extends StatelessWidget {
  const _BriefingCard({required this.expanded, required this.onToggle});
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.phase1;

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
            // Header — always visible
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
                        'About Phase 1',
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
            // Expanded content
            if (expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                        color: color.withValues(alpha: 0.2), height: 1),
                    const SizedBox(height: 14),
                    Text(
                      'Before children learn letter sounds, they need to develop a sharp ear. Phase 1 builds listening skills, rhythm, and the ability to hear individual sounds in spoken words — all through play.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    _BulletList(items: const [
                      'Tune in to sounds in the environment',
                      'Develop a sense of rhythm and rhyme',
                      'Hear individual sounds in words',
                      'Blend spoken sounds into words',
                    ]),
                    const SizedBox(height: 16),
                    _TipsSection(color: color),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('· ',
                      style: TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(item,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TipsSection extends StatefulWidget {
  const _TipsSection({required this.color});
  final Color color;

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
          _BulletList(items: const [
            'Narrate sounds on a walk — "I can hear a bird, can you?"',
            'Sing nursery rhymes together every day',
            'Play "I spy" using sounds, not letters: "/s/ for something I can see…"',
            'Clap the words in a sentence: "Fish and chips" — three claps',
            'Read aloud often and pause to let your child predict the rhyming word',
          ]),
        ],
      ],
    );
  }
}

class _AspectCard extends StatelessWidget {
  const _AspectCard({required this.aspect});
  final Phase1Aspect aspect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => AspectScreen(aspect: aspect)),
      ),
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
                color: AppColors.phase1.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(aspect.icon, size: 20, color: AppColors.phase1),
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
                      _ActivityTag(label: aspect.activityLabel),
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
    );
  }
}

class _ActivityTag extends StatelessWidget {
  const _ActivityTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.phase1.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.phase1,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
