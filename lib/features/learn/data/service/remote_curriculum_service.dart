import 'curriculum_service.dart';

// Stub — replace with HTTP implementation when CMS is available.
class RemoteCurriculumService implements CurriculumService {
  @override
  Future<List<Map<String, dynamic>>> fetchPhases() =>
      Future.error(UnimplementedError());

  @override
  Future<List<Map<String, dynamic>>> fetchAspects(int phaseNumber) =>
      Future.error(UnimplementedError());
}
