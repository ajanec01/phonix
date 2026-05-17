import '../domain/model/phase.dart';

sealed class LearnState {}

class LearnStateLoading extends LearnState {}

class LearnStateLoaded extends LearnState {
  LearnStateLoaded({required this.phases, required this.currentPhase});
  final List<Phase> phases;
  final Phase? currentPhase;
}

class LearnStateError extends LearnState {
  LearnStateError({required this.message});
  final String message;
}
