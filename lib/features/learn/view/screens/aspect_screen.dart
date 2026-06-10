import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/model/aspect.dart';
import '../widgets/aspect_icons.dart';
import '../widgets/parent_guide_card.dart';

class AspectScreen extends StatefulWidget {
  const AspectScreen({
    super.key,
    required this.aspect,
    required this.color,
    required this.foregroundColor,
  });
  final Aspect aspect;
  final Color color;
  final Color foregroundColor;

  @override
  State<AspectScreen> createState() => _AspectScreenState();
}

class _AspectScreenState extends State<AspectScreen> {
  bool _guideExpanded = false;

  @override
  Widget build(BuildContext context) {
    final aspect = widget.aspect;
    final color = widget.color;
    final foregroundColor = widget.foregroundColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldColor = isDark
        ? AppColors.surfaceContainerLowDark
        : AppColors.surfaceContainerLow;
    final cardColor = isDark
        ? AppColors.surfaceContainerLowestDark
        : AppColors.surfaceContainerLowest;
    final borderColor =
        isDark ? AppColors.outlineVariantDark : AppColors.outlineVariant;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: scaffoldColor,
            surfaceTintColor: Colors.transparent,
            title: Text(aspect.title),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(aspectIcon(aspect.iconKey),
                              size: 26, color: foregroundColor),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ActivityTag(
                                label: aspect.activityLabel,
                                color: color,
                                foregroundColor: foregroundColor,
                              ),
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
                  Text(
                    'Activity',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  _ActivityPlaceholder(
                      aspect: aspect, foregroundColor: foregroundColor),
                  const SizedBox(height: 24),
                  ParentGuideCard(
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
  const _ActivityPlaceholder(
      {required this.aspect, required this.foregroundColor});
  final Aspect aspect;
  final Color foregroundColor;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? AppColors.surfaceContainerLowestDark
        : AppColors.surfaceContainerLowest;
    final borderColor =
        isDark ? AppColors.outlineVariantDark : AppColors.outlineVariant;
    final secondaryTextColor =
        isDark ? AppColors.onSurfaceVariantDark : AppColors.onSurfaceVariant;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Icon(aspectIcon(aspect.iconKey), size: 48, color: foregroundColor),
          const SizedBox(height: 16),
          Text(
            _descriptions[aspect.number] ?? aspect.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: secondaryTextColor,
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
        color: color.withValues(alpha: 0.12),
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
