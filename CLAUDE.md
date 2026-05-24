# Phonix — Development Guide

## Architecture

Layered MVVM, following the official Flutter app architecture guide.

### Layers

**View** (`view/`)
StatelessWidget or StatefulWidget. UI rendering only: layout, sizing, conditional display based on state. No business logic. Listens to ViewModel via `ListenableBuilder`.

**ViewModel** (`viewmodel/`)
Extends `ViewModel<S>`. Owns and emits UI state as a `ChangeNotifier` with a cached last value. Triggers use cases or repository calls in response to user actions. No Flutter widget imports.

**Use Case** (`domain/usecase/`)
Single `call()` method. Only add one when the repository response requires transformation before reaching the ViewModel. Omit if repo data maps directly to UI state.

**Repository** (`data/repository/`)
Fetches from one or more services, converts responses to domain models. Abstracts the data source from the rest of the app.

**Service** (`data/service/`)
Raw data access — network, local storage, or static data. No domain knowledge.

**Domain Models** (`domain/model/`)
Plain Dart classes. No Flutter imports.

### ViewModel base class

Lives at `lib/core/viewmodel/view_model.dart`.

```dart
import 'package:flutter/foundation.dart';

abstract class ViewModel<S> extends ChangeNotifier {
  ViewModel(S initialState) : _state = initialState;

  S _state;
  S get state => _state;

  void emit(S newState) {
    _state = newState;
    notifyListeners();
  }
}
```

### ListenableBuilder pattern in views

`viewModel.state` is always typed — no force-unwrap needed:

```dart
ListenableBuilder(
  listenable: viewModel,
  builder: (context, _) {
    final state = viewModel.state;
    // build UI from state
  },
)
```

### Feature folder structure

```
lib/features/<feature>/
  view/             — screens and widgets
  viewmodel/        — ViewModel subclasses
  domain/
    model/          — domain model classes
    usecase/        — use cases (add only when needed)
  data/
    repository/     — repository classes
    service/        — raw data source classes
```

### Dependency rules

- View → ViewModel only. Never import repos or services directly in a view.
- ViewModel → use cases or repositories. Never import Flutter widgets.
- Repository → services only. Returns domain models, never raw responses.
- Domain models → no Flutter dependencies.

## State management

`ChangeNotifier`-based ViewModel (see above). No Riverpod, Provider, or Bloc.

## Design system

Material 3 with an Apple-inspired skin. Always use `AppColors.*` constants — never hardcode colours. Cupertino icons throughout. Theme defined in `lib/theme/`.

## File structure

One public class per file. Private helper classes (`_ClassName`) may live in the same file as their parent. Never place two independently navigable screens or two exported classes in one file.

## Accessibility

Every interactive element must have:
- A `Semantics` widget or `semanticLabel` describing its action
- Support for keyboard/switch navigation (never use bare `GestureDetector` without `Semantics`)
- Sufficient colour contrast — WCAG AA minimum (4.5:1 for normal text, 3:1 for large text)

## Testing

Target 100% test coverage on all new and modified code. Every PR must include:
- Unit tests for any new or changed ViewModel (test all state transitions via `addListener`)
- Unit tests for any new or changed Repository
- Widget tests for any new or changed widget
- Integration tests for any new or changed Service

Run `flutter test --coverage` before opening a PR.

## Reference documents

These live in `docs/` and must be read before writing any Phase 1 issue or touching Phase 1 content:
- `docs/Letters_and_Sounds_-_DFES-00281-2007.pdf` — the UK Letters and Sounds framework this app is based on
- `docs/phonics-app-information-architecture.html` — full feature specification and screen-by-screen breakdown

## Agent rules

These rules apply to all automated agents working on this repository.

**Branching**
- Always branch from `main`: `feat/issue-N-short-title` for features, `fix/issue-N-short-title` for bug fixes
- Never push directly to `main`
- Never force-push

**Pull requests**
- Every PR must link its sub-issue and the Phase 1 epic in the body
- Open PRs as drafts; only the `phonix-pr-reviewer` routine marks them ready for review
- Write a clear test plan in the PR body

**Issues**
- `phonix-issue-creator` creates one sub-issue at a time from `EPIC_PHASE1.md`, only after the previous sub-issue is closed
- Every sub-issue must have: context, acceptance criteria, and a definition of done
- Read the reference documents before writing any Phase 1 issue

**Colour palette tasks**
- When a task says "propose 2–3 alternatives as separate branches", create each branch from `main` independently — do not build branches on top of each other
- Name them: `palette/option-a-<approach>`, `palette/option-b-<approach>`, `palette/option-c-<approach>`

**Loop behaviour (issue-creator ↔ issue-validator, implementer ↔ pr-reviewer)**
- If the other agent raises concerns, address every point before re-requesting review
- After 3 rounds of unresolved disagreement, label the item `escalated` and post a summary for the user

**Never**
- Skip tests
- Hardcode colours (use `AppColors.*`)
- Import Flutter widgets in a ViewModel
- Import repositories or services directly in a View
