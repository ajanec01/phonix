import '../service/local_progress_service.dart';
import '../../domain/model/user_progress.dart';

class ProgressRepository {
  ProgressRepository({required LocalProgressService local}) : _local = local;
  final LocalProgressService _local;

  Future<UserProgress> getProgress() => _local.fetchProgress();
  Future<void> saveProgress(UserProgress progress) => _local.saveProgress(progress);
}
