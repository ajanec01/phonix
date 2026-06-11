import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/screens/learn_screen.dart';
import 'package:phonix/main.dart';
import 'package:phonix/theme/app_colors.dart';

void main() {
  testWidgets('AppShell displays LearnScreen by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PhonixApp());
    expect(find.byType(LearnScreen), findsOneWidget);
  });

  testWidgets('PhonixApp wires light, dark, and system theme mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PhonixApp());
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.theme, isNotNull);
    expect(materialApp.theme!.brightness, Brightness.light);
    expect(materialApp.theme!.colorScheme.surface, AppColors.surface);

    expect(materialApp.darkTheme, isNotNull);
    expect(materialApp.darkTheme!.brightness, Brightness.dark);
    expect(materialApp.darkTheme!.colorScheme.surface, AppColors.surfaceDark);

    expect(materialApp.themeMode, ThemeMode.system);
  });
}
