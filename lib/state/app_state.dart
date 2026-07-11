import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/key_signature.dart';
import '../models/progress_stats.dart';
import '../models/quiz_question.dart';
import '../services/music_theory_service.dart';
import '../services/note_audio_service.dart';
import '../services/progress_storage.dart';

class AppState extends ChangeNotifier {
  AppState({
    MusicTheoryService? musicTheoryService,
    ProgressStorage? progressStorage,
    NoteAudioService? noteAudioService,
    Random? random,
  }) : _musicTheoryService = musicTheoryService ?? MusicTheoryService(),
       _progressStorage = progressStorage ?? ProgressStorage(),
       _noteAudioService = noteAudioService ?? NoteAudioService(),
       _random = random ?? Random() {
    keys = _musicTheoryService.buildCatalog();
    selectedKey = keys.first;
    currentQuestion = _musicTheoryService.randomQuestion(
      keys.where((key) => key.mode == KeyMode.major).toList(),
      _random,
    );
  }

  final MusicTheoryService _musicTheoryService;
  final ProgressStorage _progressStorage;
  final NoteAudioService _noteAudioService;
  final Random _random;

  late final List<KeySignature> keys;
  late KeySignature selectedKey;
  late QuizQuestion currentQuestion;
  ProgressStats stats = const ProgressStats();
  int selectedIndex = 0;
  String? feedback;
  bool isLoading = true;
  int _quizTransition = 0;
  bool _isDisposed = false;

  List<KeySignature> keysByMode(KeyMode mode) {
    return keys.where((key) => key.mode == mode).toList();
  }

  Future<void> loadProgress() async {
    stats = await _progressStorage.load();
    isLoading = false;
    notifyListeners();
  }

  void changeTab(int index) {
    _quizTransition++;
    selectedIndex = index;
    feedback = null;
    notifyListeners();
  }

  void selectKey(KeySignature key) {
    selectedKey = key;
    notifyListeners();
  }

  Future<void> playNote(String note) => _noteAudioService.playNote(note);

  Future<void> playChord(String chord) => _noteAudioService.playChord(chord);

  Future<void> answerQuiz(String answer) async {
    if (feedback != null) return;

    final isCorrect = answer == currentQuestion.answer;
    stats = stats.recordAnswer(isCorrect: isCorrect);
    feedback = isCorrect
        ? 'Bonne réponse : ${currentQuestion.answer}'
        : 'Erreur : la bonne réponse était ${currentQuestion.answer}';
    notifyListeners();

    final transition = ++_quizTransition;
    unawaited(_progressStorage.save(stats));
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (_isDisposed || transition != _quizTransition || feedback == null) {
      return;
    }
    nextQuestion();
  }

  void nextQuestion() {
    _quizTransition++;
    currentQuestion = _musicTheoryService.randomQuestion(
      keys.where((key) => key.mode == KeyMode.major).toList(),
      _random,
      previous: currentQuestion,
    );
    feedback = null;
    notifyListeners();
  }

  Future<List<bool>> checkMemory(List<String> answers) async {
    final results = <bool>[];
    for (var index = 0; index < selectedKey.degrees.length; index++) {
      final expected = selectedKey.degrees[index].chord.toLowerCase().trim();
      final given = answers[index].toLowerCase().trim();
      results.add(expected == given);
    }
    stats = stats.recordMemorySession();
    await _progressStorage.save(stats);
    notifyListeners();
    return results;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _quizTransition++;
    unawaited(_noteAudioService.dispose());
    super.dispose();
  }
}
