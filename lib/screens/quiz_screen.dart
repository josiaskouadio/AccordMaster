import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../widgets/piano_strip.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;
    final answered = state.feedback != null;
    final success = state.feedback?.startsWith('Bonne') ?? false;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 28),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'QUIZ EXPRESS',
                    style: TextStyle(
                      color: Color(0xFFEF476F),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Trouve le bon accord',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD166),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${state.stats.currentStreak} série',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF172124),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.keySignature.name.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFFFD166),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                question.prompt,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  height: 1.08,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 17),
              PianoStrip(
                compact: true,
                highlightedNotes: question.keySignature.degrees
                    .map((degree) => degree.note)
                    .toSet(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'CHOISIS UNE RÉPONSE',
          style: TextStyle(
            color: Color(0xFF657477),
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        for (var index = 0; index < question.options.length; index++)
          _AnswerTile(
            index: index,
            option: question.options[index],
            enabled: !answered,
            onAnswer: () => state.answerQuiz(question.options[index]),
            onListen: () => state.playChord(question.options[index]),
          ),
        if (answered) ...[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: success
                  ? const Color(0xFF06A77D)
                  : const Color(0xFFEF476F),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                Icon(success ? Icons.check_rounded : Icons.close_rounded),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    state.feedback!,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 10),
              Text(
                'Prochaine question automatique...',
                style: TextStyle(
                  color: Color(0xFF657477),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.index,
    required this.option,
    required this.enabled,
    required this.onAnswer,
    required this.onListen,
  });

  final int index;
  final String option;
  final bool enabled;
  final VoidCallback onAnswer;
  final VoidCallback onListen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        key: ValueKey('quiz-answer-$index'),
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          onTap: enabled ? onAnswer : null,
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? const Color(0xFFFFD166)
                        : const Color(0xFFE9E6DE),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onListen,
                  tooltip: 'Écouter $option',
                  icon: const Icon(Icons.volume_up_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
