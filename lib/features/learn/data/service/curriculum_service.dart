abstract class CurriculumService {
  Future<List<Map<String, dynamic>>> fetchPhases();
  Future<List<Map<String, dynamic>>> fetchAspects(int phaseNumber);
}
