import 'dart:async';

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
