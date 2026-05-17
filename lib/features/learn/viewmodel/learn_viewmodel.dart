import '../../../core/viewmodel/view_model.dart';
import '../data/repository/curriculum_repository.dart';
import '../data/repository/progress_repository.dart';
import 'learn_state.dart';

class LearnViewModel extends ViewModel<LearnState> {
  LearnViewModel({
    required CurriculumRepository curriculumRepository,
    required ProgressRepository progressRepository,
  })  : _curriculumRepository = curriculumRepository,
        _progressRepository = progressRepository,
        super(LearnStateLoading());

  final CurriculumRepository _curriculumRepository;
  final ProgressRepository _progressRepository;

  Future<void> load() async {
    emit(LearnStateLoading());
    try {
      final phases = await _curriculumRepository.getPhases();
      final progress = await _progressRepository.getProgress();
      final currentPhase = phases.firstWhere(
        (p) => p.id == progress.currentPhaseId,
        orElse: () => phases.first,
      );
      emit(LearnStateLoaded(phases: phases, currentPhase: currentPhase));
    } catch (e) {
      emit(LearnStateError(message: 'Could not load content. Please try again.'));
    }
  }
}
