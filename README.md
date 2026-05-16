# Phonix

A Flutter app that helps children learn to read using the UK **Letters and Sounds** framework (DfES 2007), with a particular focus on supporting parents for whom English is a second language.

## What it does

- Guides children through all 6 phases of the Letters and Sounds programme at their own pace
- Teaches phonemes, graphemes, blending, segmenting and tricky words through structured lessons and games
- Helps non-native English speaking parents understand the method, model correct pronunciation, and support their child at home — with audio guides, teaching scripts and plain-language explanations built into every screen

## Platforms

Android and iOS only.

## Tech

- Flutter / Dart
- Material 3 with an Apple-inspired design system (Inter font, Cupertino icons)

## Project structure

```
lib/
  features/
    learn/       — curriculum phases and lesson flow
    practice/    — adaptive drills
    play/        — standalone games
    library/     — sound chart, word bank, parent guides, glossary
    progress/    — child dashboard and parent progress view
  theme/
    app_colors.dart
    app_theme.dart
  app_shell.dart — bottom navigation scaffold
  main.dart
```

## Related

- `phonics-app-information-architecture.md` — full feature spec and IA document
- `Letters_and_Sounds_-_DFES-00281-2007.pdf` — the underlying curriculum framework
