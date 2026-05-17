import '../../domain/model/aspect.dart';
import '../../domain/model/phase.dart';
import '../service/local_curriculum_service.dart';
import '../service/remote_curriculum_service.dart';

class CurriculumRepository {
  CurriculumRepository({
    required RemoteCurriculumService remote,
    required LocalCurriculumService local,
  })  : _remote = remote,
        _local = local;

  final RemoteCurriculumService _remote;
  final LocalCurriculumService _local;

  Future<List<Phase>> getPhases() async {
    try {
      final data = await _remote.fetchPhases();
      return data.map(Phase.fromJson).toList();
    } catch (_) {
      final data = await _local.fetchPhases();
      return data.map(Phase.fromJson).toList();
    }
  }

  Future<List<Aspect>> getAspects(int phaseNumber) async {
    try {
      final data = await _remote.fetchAspects(phaseNumber);
      return data.map(Aspect.fromJson).toList();
    } catch (_) {
      final data = await _local.fetchAspects(phaseNumber);
      return data.map(Aspect.fromJson).toList();
    }
  }
}
