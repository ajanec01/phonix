import 'package:flutter/material.dart';

abstract final class AppColors {
  // --- Primary (adapted Apple blue — slightly deeper than #007AFF) ---
  static const primary = Color(0xFF0071E3);
  static const onPrimary = Colors.white;
  static const primaryContainer = Color(0xFFDEEEFF);
  static const onPrimaryContainer = Color(0xFF003770);

  // --- Secondary (near-black — for secondary actions, parent-facing content) ---
  static const secondary = Color(0xFF1D1D1F);
  static const onSecondary = Colors.white;
  static const secondaryContainer = Color(0xFFE5E5EA);
  static const onSecondaryContainer = Color(0xFF1D1D1F);

  // --- Tertiary (green — success, completion) ---
  static const tertiary = Color(0xFF34C759); // Apple system green
  static const onTertiary = Colors.white;
  static const tertiaryContainer = Color(0xFFD1F5DC);
  static const onTertiaryContainer = Color(0xFF00391A);

  // --- Surface (Apple system background values) ---
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF1D1D1F);         // Apple primary label
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF2F2F7); // Apple grouped background
  static const surfaceContainer = Color(0xFFE5E5EA);
  static const surfaceContainerHigh = Color(0xFFD1D1D6);
  static const surfaceContainerHighest = Color(0xFFC7C7CC);
  static const onSurfaceVariant = Color(0xFF6E6E73);  // Apple secondary label
  static const outline = Color(0xFFC7C7CC);           // Apple separator
  static const outlineVariant = Color(0xFFE5E5EA);

  // --- Error ---
  static const error = Color(0xFFFF3B30); // Apple system red
  static const onError = Colors.white;
  static const errorContainer = Color(0xFFFFE5E3);
  static const onErrorContainer = Color(0xFF4A0000);

  // --- Phase accent colours ---
  static const phase1 = Color(0xFFFF9500); // Apple system orange — listening/awareness
  static const phase2 = Color(0xFFFF6B00); // deeper orange — first letters
  static const phase3 = Color(0xFF34C759); // Apple system green — new graphemes
  static const phase4 = Color(0xFF5856D6); // Apple system indigo — consolidation
  static const phase5 = Color(0xFFAF52DE); // Apple system purple — alternatives
  static const phase6 = Color(0xFFFF2D55); // Apple system pink — fluency

  static const List<Color> phases = [
    phase1,
    phase2,
    phase3,
    phase4,
    phase5,
    phase6,
  ];

  // Foreground-only companions for phase accents on light surfaces. The
  // existing phase1–phase6 values remain WCAG-compliant for background fills
  // but fall below 4.5:1 as foreground text/icon colours; these darker hues
  // clear ≥4.5:1 against the most-demanding rendered surface (8% phase-colour
  // composited on #F2F2F7). phase4 already clears the threshold and reuses
  // its background value as foreground.
  static const phase1OnLight = Color(0xFFA95400);
  static const phase2OnLight = Color(0xFFC03A00);
  static const phase3OnLight = Color(0xFF007D0A);
  static const phase5OnLight = Color(0xFFA034C7);
  static const phase6OnLight = Color(0xFFD10038);

  static const List<Color> phasesOnLight = [
    phase1OnLight,
    phase2OnLight,
    phase3OnLight,
    phase4,
    phase5OnLight,
    phase6OnLight,
  ];
}
