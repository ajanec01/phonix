import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/theme/app_colors.dart';
import 'package:phonix/theme/app_theme.dart';

void main() {
  group('AppTheme.dark', () {
    test('exposes a dark ThemeData with Brightness.dark', () {
      final theme = AppTheme.dark;
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('colorScheme maps to dark AppColors tokens', () {
      final scheme = AppTheme.dark.colorScheme;
      expect(scheme.surface, AppColors.surfaceDark);
      expect(scheme.onSurface, AppColors.onSurfaceDark);
      expect(scheme.surfaceContainerLowest, AppColors.surfaceContainerLowestDark);
      expect(scheme.surfaceContainerLow, AppColors.surfaceContainerLowDark);
      expect(scheme.surfaceContainer, AppColors.surfaceContainerDark);
      expect(scheme.surfaceContainerHigh, AppColors.surfaceContainerHighDark);
      expect(scheme.surfaceContainerHighest,
          AppColors.surfaceContainerHighestDark);
      expect(scheme.onSurfaceVariant, AppColors.onSurfaceVariantDark);
      expect(scheme.outline, AppColors.outlineDark);
      expect(scheme.outlineVariant, AppColors.outlineVariantDark);
    });

    test('scaffold background uses the dark grouped surface', () {
      expect(AppTheme.dark.scaffoldBackgroundColor,
          AppColors.surfaceContainerLowDark);
    });

    test('useMaterial3 stays enabled', () {
      expect(AppTheme.dark.useMaterial3, isTrue);
    });

    test('light theme remains unchanged', () {
      expect(AppTheme.light.brightness, Brightness.light);
      expect(AppTheme.light.colorScheme.surface, AppColors.surface);
    });
  });
}
