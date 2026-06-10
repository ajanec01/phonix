import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/learn_skeleton.dart';
import 'package:phonix/features/learn/view/widgets/shimmer_box.dart';
import 'package:phonix/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) =>
    MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(body: child),
    );

Future<void> _pumpTallSkeleton(WidgetTester tester,
    {Brightness brightness = Brightness.light}) async {
  await tester.binding.setSurfaceSize(const Size(800, 2400));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
      _wrap(const LearnSkeleton(), brightness: brightness));
}

void main() {
  group('LearnSkeleton', () {
    testWidgets('contains a Shimmer widget', (tester) async {
      await _pumpTallSkeleton(tester);

      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('Shimmer.baseColor is AppColors.surfaceContainerHigh',
        (tester) async {
      await _pumpTallSkeleton(tester);

      final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));
      // Shimmer.fromColors builds a 5-stop LinearGradient where the baseColor
      // sits at the endpoints (indices 0, 1, 3, 4).
      expect(shimmer.gradient.colors.first, AppColors.surfaceContainerHigh);
      expect(shimmer.gradient.colors.last, AppColors.surfaceContainerHigh);
    });

    testWidgets('Shimmer.highlightColor is AppColors.surfaceContainerLow',
        (tester) async {
      await _pumpTallSkeleton(tester);

      final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));
      // Shimmer.fromColors places highlightColor at the middle stop (index 2).
      expect(shimmer.gradient.colors[2], AppColors.surfaceContainerLow);
    });

    testWidgets(
        'renders 11 ShimmerBox widgets (1 hero + 3 stats + 1 label + 6 list)',
        (tester) async {
      await _pumpTallSkeleton(tester);

      expect(find.byType(ShimmerBox), findsNWidgets(11));
    });

    testWidgets(
        'Brightness.dark: Shimmer base/highlight use dark surface tokens',
        (tester) async {
      await _pumpTallSkeleton(tester, brightness: Brightness.dark);

      final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));
      expect(shimmer.gradient.colors.first, AppColors.surfaceContainerHighDark);
      expect(shimmer.gradient.colors[2], AppColors.surfaceContainerLowDark);
    });
  });
}
