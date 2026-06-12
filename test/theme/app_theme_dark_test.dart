import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonix/theme/app_colors.dart';
import 'package:phonix/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  // All AppTheme cases use `testWidgets` and pump a MaterialApp so the
  // GoogleFonts text-theme future has a widget binding to settle against —
  // see PR feedback in #30. A bare synchronous `test(...)` lets the future
  // fire after the test completes and the framework reports a failure.
  Future<ThemeData> pumpAndReadTheme(
      WidgetTester tester, ThemeData theme) async {
    late ThemeData rendered;
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Builder(
          builder: (context) {
            rendered = Theme.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    return rendered;
  }

  group('AppTheme.dark', () {
    testWidgets('exposes a dark ThemeData with Brightness.dark',
        (tester) async {
      final theme = await pumpAndReadTheme(tester, AppTheme.dark);
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    testWidgets('colorScheme maps to dark AppColors tokens', (tester) async {
      final theme = await pumpAndReadTheme(tester, AppTheme.dark);
      final scheme = theme.colorScheme;
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

    testWidgets('scaffold background uses the dark grouped surface',
        (tester) async {
      final theme = await pumpAndReadTheme(tester, AppTheme.dark);
      expect(theme.scaffoldBackgroundColor, AppColors.surfaceContainerLowDark);
    });

    testWidgets('useMaterial3 stays enabled', (tester) async {
      final theme = await pumpAndReadTheme(tester, AppTheme.dark);
      expect(theme.useMaterial3, isTrue);
    });

    testWidgets('light theme remains unchanged', (tester) async {
      final theme = await pumpAndReadTheme(tester, AppTheme.light);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.surface, AppColors.surface);
    });

    // NavigationBarThemeData callbacks need a real NavigationBar render to
    // exercise both the selected and unselected branches of `iconTheme` and
    // `labelTextStyle`. Pumping the bar at index 0 makes destination 0 the
    // selected case and destination 1 the unselected case, so both
    // WidgetStateProperty branches resolve in one frame.
    Future<NavigationBarThemeData> pumpDarkNavBar(WidgetTester tester) async {
      late NavigationBarThemeData barTheme;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: Builder(
            builder: (context) {
              barTheme = NavigationBarTheme.of(context);
              return Scaffold(
                body: const SizedBox(),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: 0,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Selected',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search),
                      label: 'Unselected',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
      return barTheme;
    }

    testWidgets(
        'NavigationBar dark theme resolves selected/unselected icon colours',
        (tester) async {
      final barTheme = await pumpDarkNavBar(tester);

      final selectedIcon = barTheme.iconTheme!
          .resolve(<WidgetState>{WidgetState.selected})!;
      final unselectedIcon = barTheme.iconTheme!.resolve(<WidgetState>{})!;

      expect(selectedIcon.color, AppColors.primary);
      expect(unselectedIcon.color, AppColors.onSurfaceVariantDark);
    });

    testWidgets(
        'NavigationBar dark theme resolves selected/unselected label styles',
        (tester) async {
      final barTheme = await pumpDarkNavBar(tester);

      final selectedLabel = barTheme.labelTextStyle!
          .resolve(<WidgetState>{WidgetState.selected})!;
      final unselectedLabel =
          barTheme.labelTextStyle!.resolve(<WidgetState>{})!;

      expect(selectedLabel.color, AppColors.primary);
      expect(selectedLabel.fontWeight, FontWeight.w700);
      expect(unselectedLabel.color, AppColors.onSurfaceVariantDark);
    });
  });
}
