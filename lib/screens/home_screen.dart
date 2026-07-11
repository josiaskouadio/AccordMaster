import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../widgets/piano_strip.dart';
import '../widgets/section_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.state});

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
              const Row(
                children: [
                  Text(
                    'ENTRAÎNEMENT HARMONIQUE',
                    style: TextStyle(
                      color: Color(0xFFFFD166),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.graphic_eq_rounded, color: Color(0xFFEF476F)),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Apprends les degrés\nd'accords par l'écoute.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  height: 1.02,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 9),
              const Text(
                'Joue une note maintenant, puis poursuis dans le Studio.',
                style: TextStyle(color: Color(0xFFB8C3C4), height: 1.35),
              ),
              const SizedBox(height: 16),
              PianoStrip(onNotePressed: state.playNote),
              const SizedBox(height: 8),
              const Text(
                'CLAVIER INTERACTIF',
                style: TextStyle(
                  color: Color(0xFF89999B),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _StatTile(
                label: 'RÉUSSITE',
                value: '$rate%',
                color: const Color(0xFF06A77D),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StatTile(
                label: 'MEILLEURE SÉRIE',
                value: '${stats.bestStreak}',
                color: const Color(0xFFEF476F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Choisis ton exercice',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 9),
        SectionCard(
          title: 'Studio',
          subtitle: 'Explore les tonalités et écoute chaque accord.',
          icon: Icons.piano_rounded,
          accent: const Color(0xFFEF476F),
          onTap: () => state.changeTab(1),
        ),
        SectionCard(
          title: 'Quiz',
          subtitle: 'Retrouve rapidement le bon degré.',
          icon: Icons.bolt_rounded,
          accent: const Color(0xFFFFA62B),
          onTap: () => state.changeTab(2),
        ),
        SectionCard(
          title: 'Mémoire',
          subtitle: "Reconstruis les sept accords sans aide.",
          icon: Icons.psychology_rounded,
          accent: const Color(0xFF06A77D),
          onTap: () => state.changeTab(3),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
