import 'package:flutter/material.dart';

import '../state/app_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final stats = state.stats;
    final rate = (stats.successRate * 100).round();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF172124),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TABLEAU DE BORD',
                style: TextStyle(
                  color: Color(0xFFFFD166),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$rate%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      height: 1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'DE RÉUSSITE',
                      style: TextStyle(
                        color: Color(0xFFB4C0C1),
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: stats.successRate,
                  minHeight: 8,
                  color: const Color(0xFF06A77D),
                  backgroundColor: const Color(0xFF344245),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _Metric(
                value: '${stats.correct}',
                label: 'BONNES\nRÉPONSES',
                color: const Color(0xFF06A77D),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _Metric(
                value: '${stats.bestStreak}',
                label: 'MEILLEURE\nSÉRIE',
                color: const Color(0xFFEF476F),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _Metric(
                value: '${stats.memorySessions}',
                label: 'SESSIONS\nMÉMOIRE',
                color: const Color(0xFFFFD166),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Tes badges',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 9),
        _Badge(
          label: 'Premier accord',
          description: 'Réponds à ta première question.',
          active: stats.answered >= 1,
          icon: Icons.music_note_rounded,
        ),
        _Badge(
          label: 'Oreille entraînée',
          description: 'Atteins une série de 5 bonnes réponses.',
          active: stats.bestStreak >= 5,
          icon: Icons.hearing_rounded,
        ),
        _Badge(
          label: 'Mémoire harmonique',
          description: 'Termine une session de mémoire.',
          active: stats.memorySessions >= 1,
          icon: Icons.psychology_rounded,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD166),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            stats.answered == 0
                ? "Commence par quelques questions pour débloquer ton premier badge."
                : "Continue : les séances courtes renforcent mieux ta mémoire.",
            style: const TextStyle(fontWeight: FontWeight.w800, height: 1.3),
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.description,
    required this.active,
    required this.icon,
  });

  final String label;
  final String description;
  final bool active;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: active ? const Color(0xFFFFD166) : const Color(0xFFE4E2DC),
              shape: BoxShape.circle,
            ),
            child: Icon(active ? icon : Icons.lock_rounded),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(color: Color(0xFF657477)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
