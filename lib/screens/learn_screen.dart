import 'package:flutter/material.dart';

import '../models/key_signature.dart';
import '../state/app_state.dart';
import '../widgets/degree_card.dart';
import '../widgets/piano_strip.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key, required this.state});

  final AppState state;

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  KeyMode get _mode => widget.state.selectedKey.mode;

  void _selectMode(KeyMode mode) {
    if (mode == _mode) return;
    widget.state.selectKey(widget.state.keysByMode(mode).first);
  }

  Future<void> _playNote(String note) async {
    await widget.state.playNote(note);
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final key = state.selectedKey;
    final scaleNotes = key.degrees.map((degree) => degree.note).toSet();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 28),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STUDIO DES TONALITÉS',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFFEF476F),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Écoute. Joue.\nMémorise.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFF172124),
                      fontWeight: FontWeight.w900,
                      height: 0.98,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD166),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.graphic_eq_rounded, size: 28),
            ),
          ],
        ),
        const SizedBox(height: 22),
        SegmentedButton<KeyMode>(
          segments: const [
            ButtonSegment(value: KeyMode.major, label: Text('Majeur')),
            ButtonSegment(value: KeyMode.minor, label: Text('Mineur')),
          ],
          selected: {_mode},
          showSelectedIcon: false,
          onSelectionChanged: (selection) => _selectMode(selection.first),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.keysByMode(_mode).length,
            separatorBuilder: (context, index) => const SizedBox(width: 7),
            itemBuilder: (context, index) {
              final candidate = state.keysByMode(_mode)[index];
              final selected = candidate.name == key.name;
              return _KeyButton(
                keySignature: candidate,
                selected: selected,
                onTap: () => state.selectKey(candidate),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF172124),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TONALITÉ ACTIVE',
                        style: TextStyle(
                          color: Color(0xFF97A6A8),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        key.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => state.playChord(key.degrees.first.chord),
                    tooltip: 'Ecouter la tonique',
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD166),
                      foregroundColor: const Color(0xFF172124),
                    ),
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              PianoStrip(
                onNotePressed: _playNote,
                highlightedNotes: scaleNotes,
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    color: Color(0xFFFFD166),
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Touche une note pour l'écouter",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xFFBCC7C8), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Text(
                'Les 7 degrés',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'TOUCHE POUR ÉCOUTER',
                maxLines: 2,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF657477),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        for (final degree in key.degrees)
          DegreeCard(
            degree: degree,
            onPlay: () => state.playChord(degree.chord),
          ),
      ],
    );
  }
}

class _KeyButton extends StatelessWidget {
  const _KeyButton({
    required this.keySignature,
    required this.selected,
    required this.onTap,
  });

  final KeySignature keySignature;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFEF476F) : Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(
          width: 52,
          child: Center(
            child: Text(
              keySignature.tonic,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF172124),
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
