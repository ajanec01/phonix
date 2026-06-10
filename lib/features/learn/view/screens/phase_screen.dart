import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../theme/app_colors.dart';
import '../widgets/shimmer_box.dart';
import '../../data/repository/curriculum_repository.dart';
import '../../data/service/local_curriculum_service.dart';
import '../../data/service/remote_curriculum_service.dart';
import '../../domain/model/aspect.dart';
import '../../domain/model/phase.dart';
import '../../viewmodel/aspect_state.dart';
import '../../viewmodel/aspect_viewmodel.dart';
import '../widgets/aspect_card.dart';
import '../widgets/briefing_card.dart';

class PhaseScreen extends StatefulWidget {
  const PhaseScreen({super.key, required this.phase, this.viewModel});
  final Phase phase;
  final AspectViewModel? viewModel;

  @override
  State<PhaseScreen> createState() => _PhaseScreenState();
}

class _PhaseScreenState extends State<PhaseScreen> {
  bool _briefingExpanded = true;
  late final AspectViewModel _viewModel;

  Color _phaseColor(bool isDark) => isDark
      ? AppColors.phasesDark[widget.phase.id - 1]
      : AppColors.phases[widget.phase.id - 1];
  Color _phaseForegroundColor(bool isDark) => isDark
      ? AppColors.phasesOnDark[widget.phase.id - 1]
      : AppColors.phasesOnLight[widget.phase.id - 1];

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel ??
        AspectViewModel(
          repository: CurriculumRepository(
            remote: RemoteCurriculumService(),
            local: LocalCurriculumService(),
          ),
          phaseNumber: widget.phase.id,
        );
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phase = widget.phase;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldColor = isDark
        ? AppColors.surfaceContainerLowDark
        : AppColors.surfaceContainerLow;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: scaffoldColor,
            surfaceTintColor: Colors.transparent,
            title: Text(phase.title),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: BriefingCard(
                phase: phase,
                expanded: _briefingExpanded,
                onToggle: () =>
                    setState(() => _briefingExpanded = !_briefingExpanded),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) {
                final color = _phaseColor(isDark);
                final foregroundColor = _phaseForegroundColor(isDark);
                return switch (_viewModel.state) {
                  AspectStateLoading() => _AspectsLoading(),
                  AspectStateLoaded(:final aspects) when aspects.isEmpty =>
                    const SizedBox.shrink(),
                  AspectStateLoaded(:final aspects) => _AspectsList(
                      aspects: aspects,
                      color: color,
                      foregroundColor: foregroundColor,
                    ),
                  AspectStateError() => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AspectsLoading extends StatelessWidget {
  const _AspectsLoading();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shimmerBase = isDark
        ? AppColors.surfaceContainerHighDark
        : AppColors.surfaceContainerHigh;
    final shimmerHighlight = isDark
        ? AppColors.surfaceContainerLowDark
        : AppColors.surfaceContainerLow;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activities', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Shimmer.fromColors(
            baseColor: shimmerBase,
            highlightColor: shimmerHighlight,
            child: Column(
              children: List.generate(
                4,
                (i) => Padding(
                  padding: EdgeInsets.only(top: i > 0 ? 10.0 : 0),
                  child: ShimmerBox(height: 74, radius: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AspectsList extends StatelessWidget {
  const _AspectsList({
    required this.aspects,
    required this.color,
    required this.foregroundColor,
  });
  final List<Aspect> aspects;
  final Color color;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activities', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          for (int i = 0; i < aspects.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            AspectCard(
              aspect: aspects[i],
              color: color,
              foregroundColor: foregroundColor,
            ),
          ],
        ],
      ),
    );
  }
}
