import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/learn_skeleton.dart';
import 'package:phonix/features/learn/view/widgets/shimmer_box.dart';
import 'package:phonix/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );

void main() {
  group('LearnSkeleton', () {
    testWidgets('contains a Shimmer widget', (tester) async {
      await tester.pumpWidget(_wrap(const LearnSkeleton()));

      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets(
        'Shimmer.baseColor is AppColors.surfaceContainerHigh and '
        'highlightColor is AppColors.surfaceContainerLow', (tester) async {
      await tester.pumpWidget(_wrap(const LearnSkeleton()));

      final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));
      final gradient = shimmer.gradient;
      // Shimmer.fromColors builds a LinearGradient whose colour stops include
      // the base colour at the ends and the highlight at the middle. Verify
      // both AppColors values appear in the gradient.
      expect(gradient.colors, contains(AppColors.surfaceContainerHigh));
      expect(gradient.colors, contains(AppColors.surfaceContainerLow));
    });

    testWidgets('renders 11 ShimmerBox widgets in the skeleton',
        (tester) async {
      // The SliverList builds items lazily, so the test viewport must be tall
      // enough to fit the SliverAppBar.large, the header block, and all six
      // list items (~66 + 10 separator each).
      tester.view.physicalSize = const Size(800, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(_wrap(const LearnSkeleton()));

      expect(find.byType(ShimmerBox), findsNWidgets(11));
    });
  });
}
