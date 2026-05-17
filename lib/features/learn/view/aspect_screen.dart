import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../data/curriculum.dart';

class AspectScreen extends StatefulWidget {
  const AspectScreen({super.key, required this.aspect});
  final Phase1Aspect aspect;

  @override
  State<AspectScreen> createState() => _AspectScreenState();
}

class _AspectScreenState extends State<AspectScreen> {
  bool _guideExpanded = false;

  @override
  Widget build(BuildContext context) {
    final aspect = widget.aspect;

    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: AppColors.surfaceContainerLow,
            surfaceTintColor: Colors.transparent,
            title: Text(aspect.title),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon + description card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.phase1.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(aspect.icon,
                              size: 26, color: AppColors.phase1),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ActivityTag(label: aspect.activityLabel),
                              const SizedBox(height: 8),
                              Text(
                                aspect.description,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Activity area
                  Text(
                    'Activity',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  _ActivityPlaceholder(aspect: aspect),

                  const SizedBox(height: 24),

                  // Parent guide
                  _ParentGuideCard(
                    guide: aspect.parentGuide,
                    expanded: _guideExpanded,
                    onToggle: () =>
                        setState(() => _guideExpanded = !_guideExpanded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityPlaceholder extends StatelessWidget {
  const _ActivityPlaceholder({required this.aspect});
  final Phase1Aspect aspect;

  static const _descriptions = {
    1: 'Listen to sounds and identify where they come from.',
    2: 'Hear two sounds and decide whether they are the same or different.',
    3: 'Watch a rhythm pattern and tap it back.',
    4: 'Match pairs of words that rhyme.',
    5: 'Three words share a starting sound — find the one that doesn\'t.',
    6: 'Listen to a voice sound and copy it.',
    7: 'Hear a word spoken in separate sounds and blend them together.',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(aspect.icon, size: 48, color: AppColors.phase1),
          const SizedBox(height: 16),
          Text(
            _descriptions[aspect.number] ?? aspect.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: null,
            child: const Text('Coming soon'),
          ),
        ],
      ),
    );
  }
}

class _ParentGuideCard extends StatelessWidget {
  const _ParentGuideCard({
    required this.guide,
    required this.expanded,
    required this.onToggle,
  });
  final String guide;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.secondary;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryContainer,
          borderRadius: BorderRadius.circular(14),
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
                    const Icon(CupertinoIcons.person_fill,
                        size: 16, color: color),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'For Parents',
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
                    Divider(
                        color: color.withValues(alpha: 0.15), height: 1),
                    const SizedBox(height: 14),
                    Text(guide,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
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
        color: AppColors.phase1.withValues(alpha: 0.12),
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
