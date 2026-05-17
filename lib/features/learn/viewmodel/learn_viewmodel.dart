import '../../../core/viewmodel/view_model.dart';
import '../data/repository/curriculum_repository.dart';
import 'learn_state.dart';

class LearnViewModel extends ViewModel<LearnState> {
  LearnViewModel({required CurriculumRepository repository})
      : _repository = repository,
        super(LearnStateLoading());

  final CurriculumRepository _repository;

  Future<void> load() async {
    emit(LearnStateLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final phases = await _repository.getPhases();
      emit(LearnStateLoaded(phases: phases));
    } catch (e) {
      emit(LearnStateError(message: 'Could not load content. Please try again.'));
    }
  }
}
