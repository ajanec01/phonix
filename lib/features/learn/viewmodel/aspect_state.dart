import '../domain/model/aspect.dart';

sealed class AspectState {}

class AspectStateLoading extends AspectState {}

class AspectStateLoaded extends AspectState {
  AspectStateLoaded({required this.aspects});
  final List<Aspect> aspects;
}

class AspectStateError extends AspectState {
  AspectStateError({required this.message});
  final String message;
}
