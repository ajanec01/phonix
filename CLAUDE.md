# Phonix — Development Guide

## Architecture

Layered MVVM, following the official Flutter app architecture guide.

### Layers

**View** (`view/`)
StatelessWidget or StatefulWidget. UI rendering only: layout, sizing, conditional display based on state. No business logic. Listens to ViewModel via `StreamBuilder` with `initialData: viewModel.state`.

**ViewModel** (`viewmodel/`)
Extends `ViewModel<S>`. Owns and emits UI state via a broadcast stream with a cached last value. Triggers use cases or repository calls in response to user actions. No Flutter widget imports.

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
abstract class ViewModel<S> {
  ViewModel(S initialState) : _state = initialState;

  S _state;
  S get state => _state;

  final _controller = StreamController<S>.broadcast();
  Stream<S> get stream => _controller.stream;

  void emit(S newState) {
    _state = newState;
    _controller.add(newState);
  }

  void dispose() => _controller.close();
}
```

### StreamBuilder pattern in views

Always pass `initialData: viewModel.state` so the view renders immediately with the cached state:

```dart
StreamBuilder<MyState>(
  stream: viewModel.stream,
  initialData: viewModel.state,
  builder: (context, snapshot) {
    final state = snapshot.requireData;
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

Custom stream-based ViewModel (see above). No Riverpod, Provider, or Bloc.

## Design system

Material 3 with an Apple-inspired skin. Always use `AppColors.*` constants — never hardcode colours. Cupertino icons throughout. Theme defined in `lib/theme/`.
