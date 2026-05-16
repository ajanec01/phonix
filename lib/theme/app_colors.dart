import 'package:flutter/material.dart';

abstract final class AppColors {
  // --- Brand ---
  static const primary = Color(0xFFEA580C);
  static const onPrimary = Colors.white;
  static const primaryContainer = Color(0xFFFFEDE3);
  static const onPrimaryContainer = Color(0xFF4A1A00);

  // --- Secondary (navy — grounding, trustworthy for parent-facing content) ---
  static const secondary = Color(0xFF0369A1);
  static const onSecondary = Colors.white;
  static const secondaryContainer = Color(0xFFDCEEFA);
  static const onSecondaryContainer = Color(0xFF002033);

  // --- Tertiary (green — success, completion) ---
  static const tertiary = Color(0xFF16A34A);
  static const onTertiary = Colors.white;
  static const tertiaryContainer = Color(0xFFD1FAE5);
  static const onTertiaryContainer = Color(0xFF003317);

  // --- Surface ---
  static const surface = Color(0xFFFEFAF7);
  static const onSurface = Color(0xFF1C1917);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF8F3EE);
  static const surfaceContainer = Color(0xFFF2ECE5);
  static const surfaceContainerHigh = Color(0xFFEBE5DC);
  static const surfaceContainerHighest = Color(0xFFE4DDD3);
  static const onSurfaceVariant = Color(0xFF7C7269);
  static const outline = Color(0xFFB0A89F);
  static const outlineVariant = Color(0xFFDDD5CC);

  // --- Error ---
  static const error = Color(0xFFDC2626);
  static const onError = Colors.white;
  static const errorContainer = Color(0xFFFEE2E2);
  static const onErrorContainer = Color(0xFF4A0000);

  // --- Phase accent colours (used in lesson cards, progress, games) ---
  static const phase1 = Color(0xFFF59E0B); // amber
  static const phase2 = Color(0xFFEA580C); // orange  (matches primary)
  static const phase3 = Color(0xFF10B981); // emerald
  static const phase4 = Color(0xFF3B82F6); // blue
  static const phase5 = Color(0xFF8B5CF6); // violet
  static const phase6 = Color(0xFFEC4899); // pink

  static const List<Color> phases = [
    phase1,
    phase2,
    phase3,
    phase4,
    phase5,
    phase6,
  ];
}
