import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../theme/app_colors.dart';
import 'learn_scroll_view.dart';
import 'shimmer_box.dart';

class LearnSkeleton extends StatelessWidget {
  const LearnSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shimmerBase = isDark
        ? AppColors.surfaceContainerHighDark
        : AppColors.surfaceContainerHigh;
    final shimmerHighlight = isDark
        ? AppColors.surfaceContainerLowDark
        : AppColors.surfaceContainerLow;
    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      child: LearnScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(height: 96, radius: 16),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: ShimmerBox(height: 70, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: ShimmerBox(height: 70, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: ShimmerBox(height: 70, radius: 12)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ShimmerBox(height: 18, radius: 4, width: 56),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList.separated(
              itemCount: 6,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, _) => ShimmerBox(height: 66, radius: 14),
            ),
          ),
        ],
      ),
    );
  }
}
