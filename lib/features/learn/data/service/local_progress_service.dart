import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/model/user_progress.dart';

class LocalProgressService {
  static const _currentPhaseIdKey = 'current_phase_id';

  Future<UserProgress> fetchProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return UserProgress(
      currentPhaseId: prefs.getInt(_currentPhaseIdKey) ?? 1,
    );
  }

  Future<void> saveProgress(UserProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentPhaseIdKey, progress.currentPhaseId);
  }
}
