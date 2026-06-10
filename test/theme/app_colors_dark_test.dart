import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/theme/app_colors.dart';

double _srgbToLinear(double c) {
  if (c <= 0.03928) return c / 12.92;
  return math.pow((c + 0.055) / 1.055, 2.4).toDouble();
}

double _luminance(Color c) {
  return 0.2126 * _srgbToLinear(c.r) +
      0.7152 * _srgbToLinear(c.g) +
      0.0722 * _srgbToLinear(c.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

Color _blend(Color fg, Color bg, double alpha) {
  int chan(double f, double b) =>
      ((alpha * (f * 255) + (1 - alpha) * (b * 255)).round())
          .clamp(0, 255)
          .toInt();
  return Color.fromARGB(
    255,
    chan(fg.r, bg.r),
    chan(fg.g, bg.g),
    chan(fg.b, bg.b),
  );
}

void main() {
  group('AppColors — dark mode surface tokens', () {
    test('all dark surface tokens are defined', () {
      expect(AppColors.surfaceDark, isA<Color>());
      expect(AppColors.onSurfaceDark, isA<Color>());
      expect(AppColors.surfaceContainerLowestDark, isA<Color>());
      expect(AppColors.surfaceContainerLowDark, isA<Color>());
      expect(AppColors.surfaceContainerDark, isA<Color>());
      expect(AppColors.surfaceContainerHighDark, isA<Color>());
      expect(AppColors.surfaceContainerHighestDark, isA<Color>());
      expect(AppColors.onSurfaceVariantDark, isA<Color>());
      expect(AppColors.outlineDark, isA<Color>());
      expect(AppColors.outlineVariantDark, isA<Color>());
    });

    test('phasesDark contains exactly 6 entries', () {
      expect(AppColors.phasesDark, hasLength(6));
      expect(AppColors.phasesDark[0], AppColors.phase1Dark);
      expect(AppColors.phasesDark[1], AppColors.phase2Dark);
      expect(AppColors.phasesDark[2], AppColors.phase3Dark);
      expect(AppColors.phasesDark[3], AppColors.phase4Dark);
      expect(AppColors.phasesDark[4], AppColors.phase5Dark);
      expect(AppColors.phasesDark[5], AppColors.phase6Dark);
    });

    test('phasesOnDark contains exactly 6 entries', () {
      expect(AppColors.phasesOnDark, hasLength(6));
      expect(AppColors.phasesOnDark[0], AppColors.phase1OnDark);
      expect(AppColors.phasesOnDark[1], AppColors.phase2OnDark);
      expect(AppColors.phasesOnDark[2], AppColors.phase3OnDark);
      expect(AppColors.phasesOnDark[3], AppColors.phase4OnDark);
      expect(AppColors.phasesOnDark[4], AppColors.phase5OnDark);
      expect(AppColors.phasesOnDark[5], AppColors.phase6OnDark);
    });
  });

  group('WCAG AA — every phasesOnDark clears 4.5:1', () {
    for (var i = 0; i < 6; i++) {
      test('phasesOnDark[$i] on surfaceContainerLowestDark', () {
        final ratio = _contrast(
          AppColors.phasesOnDark[i],
          AppColors.surfaceContainerLowestDark,
        );
        expect(ratio, greaterThanOrEqualTo(4.5),
            reason:
                'phasesOnDark[$i]=${AppColors.phasesOnDark[i]} on surfaceContainerLowestDark must clear 4.5:1, got ${ratio.toStringAsFixed(2)}:1');
      });

      test('phasesOnDark[$i] on phasesDark[$i] @ 8% over surfaceContainerLowestDark',
          () {
        final blended = _blend(
          AppColors.phasesDark[i],
          AppColors.surfaceContainerLowestDark,
          0.08,
        );
        final ratio = _contrast(AppColors.phasesOnDark[i], blended);
        expect(ratio, greaterThanOrEqualTo(4.5),
            reason:
                'phasesOnDark[$i] on tinted bg must clear 4.5:1, got ${ratio.toStringAsFixed(2)}:1');
      });
    }
  });
}
