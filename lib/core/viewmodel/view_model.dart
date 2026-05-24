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
