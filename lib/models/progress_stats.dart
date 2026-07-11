class ProgressStats {
  const ProgressStats({
    this.answered = 0,
    this.correct = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.memorySessions = 0,
  });

  final int answered;
  final int correct;
  final int currentStreak;
  final int bestStreak;
  final int memorySessions;

  double get successRate => answered == 0 ? 0 : correct / answered;

  ProgressStats recordAnswer({required bool isCorrect}) {
    final nextStreak = isCorrect ? currentStreak + 1 : 0;
    return ProgressStats(
      answered: answered + 1,
      correct: correct + (isCorrect ? 1 : 0),
      currentStreak: nextStreak,
      bestStreak: nextStreak > bestStreak ? nextStreak : bestStreak,
      memorySessions: memorySessions,
    );
  }

  ProgressStats recordMemorySession() {
    return ProgressStats(
      answered: answered,
      correct: correct,
      currentStreak: currentStreak,
      bestStreak: bestStreak,
      memorySessions: memorySessions + 1,
    );
  }

  Map<String, int> toMap() => {
    'answered': answered,
    'correct': correct,
    'currentStreak': currentStreak,
    'bestStreak': bestStreak,
    'memorySessions': memorySessions,
  };

  factory ProgressStats.fromMap(Map<String, int> map) {
    return ProgressStats(
      answered: map['answered'] ?? 0,
      correct: map['correct'] ?? 0,
      currentStreak: map['currentStreak'] ?? 0,
      bestStreak: map['bestStreak'] ?? 0,
      memorySessions: map['memorySessions'] ?? 0,
    );
  }
}
