import '../../../core/viewmodel/view_model.dart';
import '../data/repository/curriculum_repository.dart';
import 'aspect_state.dart';

class AspectViewModel extends ViewModel<AspectState> {
  AspectViewModel({
    required CurriculumRepository repository,
    required int phaseNumber,
  })  : _repository = repository,
        _phaseNumber = phaseNumber,
        super(AspectStateLoading());

  final CurriculumRepository _repository;
  final int _phaseNumber;

  Future<void> load() async {
    emit(AspectStateLoading());
    try {
      final aspects = await _repository.getAspects(_phaseNumber);
      emit(AspectStateLoaded(aspects: aspects));
    } catch (e) {
      emit(AspectStateError(message: 'Could not load activities. Please try again.'));
    }
  }
}
