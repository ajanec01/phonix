import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../theme/app_colors.dart';

class LearnSkeleton extends StatelessWidget {
  const LearnSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceContainerHigh,
      highlightColor: AppColors.surfaceContainerLow,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text('Learn'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(height: 96, radius: 16),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _ShimmerBox(height: 70, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: _ShimmerBox(height: 70, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: _ShimmerBox(height: 70, radius: 12)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _ShimmerBox(height: 18, radius: 4, width: 56),
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
              itemBuilder: (_, _) => _ShimmerBox(height: 66, radius: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.height, required this.radius, this.width});
  final double height;
  final double radius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
