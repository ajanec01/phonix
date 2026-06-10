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

  // Foreground-only companions for phase accents on light surfaces. Derived by
  // applying a uniform L* offset in CIELCH (D65) to every original phase hue,
  // including phase4. Issue #25 named −25 L* as the target offset; in-gamut
  // sRGB conversion at the boundary leaves phase1 (4.29:1) and phase3 (4.23:1)
  // below the 4.5:1 floor on the 8% phase-on-#F2F2F7 surface, so the actual
  // uniform offset applied is −28 L* — the smallest integer uniform shift that
  // clears every threshold across all six phases on every rendered surface.
  static const phase1OnLight = Color(0xFFA74E00);
  static const phase2OnLight = Color(0xFFA51A00);
  static const phase3OnLight = Color(0xFF007A0E);
  static const phase4OnLight = Color(0xFF001889);
  static const phase5OnLight = Color(0xFF600090);
  static const phase6OnLight = Color(0xFFA40019);

  static const List<Color> phasesOnLight = [
    phase1OnLight,
    phase2OnLight,
    phase3OnLight,
    phase4OnLight,
    phase5OnLight,
    phase6OnLight,
  ];

  // ===========================================================================
  // Dark mode — Option B: Warm dark
  // ---------------------------------------------------------------------------
  // Surface base is a warm near-black (#161412 page, #1F1D1B scaffold,
  // #2A2826 card face) — a few hue points toward yellow-orange so the
  // overall feel is "lamp-lit room" rather than "void". Phase accents are
  // de-saturated and warm-shifted so they read as softer at night without
  // sacrificing the original hue identity. Every phasesOnDark token clears
  // 4.5:1 against #2A2826 and its own 8% tinted background.
  // ===========================================================================
  static const surfaceDark = Color(0xFF161412);
  static const onSurfaceDark = Color(0xFFF5F2EE);
  static const surfaceContainerLowestDark = Color(0xFF2A2826);
  static const surfaceContainerLowDark = Color(0xFF1F1D1B);
  static const surfaceContainerDark = Color(0xFF2A2826);
  static const surfaceContainerHighDark = Color(0xFF34322F);
  static const surfaceContainerHighestDark = Color(0xFF403D39);
  static const onSurfaceVariantDark = Color(0xFFA39A8E);
  static const outlineDark = Color(0xFF3F3C38);
  static const outlineVariantDark = Color(0xFF2A2826);

  // Phase accents — warm-shifted, de-saturated versions of the original
  // hues. Used both as the 8% tint background source (phasesDark) and as
  // the foreground text/icon colour (phasesOnDark). Each value clears
  // 4.5:1 against surfaceContainerLowestDark (#2A2826) and against its own
  // tinted background.
  static const phase1Dark = Color(0xFFFFB870); // soft warm orange
  static const phase2Dark = Color(0xFFFF9866); // warm deep orange
  static const phase3Dark = Color(0xFFA4DEAC); // warm soft green
  static const phase4Dark = Color(0xFFB6B3FF); // warm indigo
  static const phase5Dark = Color(0xFFE1A7E7); // warm purple
  static const phase6Dark = Color(0xFFFFA0AB); // warm pink

  static const List<Color> phasesDark = [
    phase1Dark,
    phase2Dark,
    phase3Dark,
    phase4Dark,
    phase5Dark,
    phase6Dark,
  ];

  static const phase1OnDark = phase1Dark;
  static const phase2OnDark = phase2Dark;
  static const phase3OnDark = phase3Dark;
  static const phase4OnDark = phase4Dark;
  static const phase5OnDark = phase5Dark;
  static const phase6OnDark = phase6Dark;

  static const List<Color> phasesOnDark = [
    phase1OnDark,
    phase2OnDark,
    phase3OnDark,
    phase4OnDark,
    phase5OnDark,
    phase6OnDark,
  ];
}
