import 'package:shared_preferences/shared_preferences.dart';

import '../models/progress_stats.dart';

class ProgressStorage {
  static const _answered = 'progress_answered';
  static const _correct = 'progress_correct';
  static const _currentStreak = 'progress_current_streak';
  static const _bestStreak = 'progress_best_streak';
  static const _memorySessions = 'progress_memory_sessions';

  Future<ProgressStats> load() async {
    final prefs = await SharedPreferences.getInstance();
    return ProgressStats.fromMap({
      'answered': prefs.getInt(_answered) ?? 0,
      'correct': prefs.getInt(_correct) ?? 0,
      'currentStreak': prefs.getInt(_currentStreak) ?? 0,
      'bestStreak': prefs.getInt(_bestStreak) ?? 0,
      'memorySessions': prefs.getInt(_memorySessions) ?? 0,
    });
  }

  Future<void> save(ProgressStats stats) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_answered, stats.answered);
    await prefs.setInt(_correct, stats.correct);
    await prefs.setInt(_currentStreak, stats.currentStreak);
    await prefs.setInt(_bestStreak, stats.bestStreak);
    await prefs.setInt(_memorySessions, stats.memorySessions);
  }
}
