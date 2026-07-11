import 'dart:math';

import '../models/chord_degree.dart';
import '../models/key_signature.dart';
import '../models/quiz_question.dart';

class MusicTheoryService {
  static const List<String> _chromatic = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  static const List<String> _tonics = [
    'C',
    'G',
    'D',
    'A',
    'E',
    'B',
    'F#',
    'F',
    'A#',
    'D#',
    'G#',
    'C#',
  ];

  static const List<int> _majorIntervals = [0, 2, 4, 5, 7, 9, 11];
  static const List<int> _minorIntervals = [0, 2, 3, 5, 7, 8, 10];
  static const List<String> _majorSymbols = [
    'I',
    'ii',
    'iii',
    'IV',
    'V',
    'vi',
    'vii',
  ];
  static const List<String> _minorSymbols = [
    'i',
    'ii',
    'III',
    'iv',
    'v',
    'VI',
    'VII',
  ];
  static const List<String> _majorQualities = [
    '',
    'm',
    'm',
    '',
    '',
    'm',
    'dim',
  ];
  static const List<String> _minorQualities = [
    'm',
    'dim',
    '',
    'm',
    'm',
    '',
    '',
  ];
  static const List<String> _roles = [
    'Tonique',
    'Sus-tonique',
    'Médiante',
    'Sous-dominante',
    'Dominante',
    'Sus-dominante',
    'Sensible',
  ];

  List<KeySignature> buildCatalog() {
    return [
      for (final tonic in _tonics) buildKey(tonic, KeyMode.major),
      for (final tonic in _tonics) buildKey(tonic, KeyMode.minor),
    ];
  }

  KeySignature buildKey(String tonic, KeyMode mode) {
    final tonicIndex = _chromatic.indexOf(tonic);
    if (tonicIndex == -1) {
      throw ArgumentError('Unknown tonic: $tonic');
    }

    final intervals = mode == KeyMode.major ? _majorIntervals : _minorIntervals;
    final symbols = mode == KeyMode.major ? _majorSymbols : _minorSymbols;
    final qualities = mode == KeyMode.major ? _majorQualities : _minorQualities;

    final degrees = <ChordDegree>[];
    for (var index = 0; index < intervals.length; index++) {
      final note =
          _chromatic[(tonicIndex + intervals[index]) % _chromatic.length];
      degrees.add(
        ChordDegree(
          position: index + 1,
          symbol: symbols[index],
          note: note,
          chord: '$note${qualities[index]}',
          role: _roles[index],
        ),
      );
    }

    return KeySignature(
      name: '$tonic ${mode == KeyMode.major ? 'majeur' : 'mineur'}',
      tonic: tonic,
      mode: mode,
      degrees: degrees,
    );
  }

  QuizQuestion questionFor(KeySignature key, int seed) {
    final degree = key.degrees[seed % key.degrees.length];
    final allChords =
        buildCatalog()
            .expand((signature) => signature.degrees)
            .map((degree) => degree.chord)
            .toSet()
            .where((chord) => chord != degree.chord)
            .toList()
          ..sort();

    final options = <String>{degree.chord};
    var cursor = seed * 3;
    while (options.length < 4) {
      options.add(allChords[cursor % allChords.length]);
      cursor += 5;
    }

    final sortedOptions = options.toList()
      ..sort(
        (a, b) => ((a.codeUnitAt(0) + seed) % 7).compareTo(
          (b.codeUnitAt(0) + seed) % 7,
        ),
      );

    return QuizQuestion(
      keySignature: key,
      degree: degree,
      options: sortedOptions,
    );
  }

  QuizQuestion randomQuestion(
    List<KeySignature> catalog,
    Random random, {
    QuizQuestion? previous,
  }) {
    if (catalog.isEmpty) {
      throw ArgumentError('The key catalog cannot be empty.');
    }

    late QuizQuestion candidate;
    for (var attempt = 0; attempt < 12; attempt++) {
      final key = catalog[random.nextInt(catalog.length)];
      candidate = questionFor(key, random.nextInt(1 << 31));
      final repeatsPrevious =
          previous != null &&
          candidate.keySignature.name == previous.keySignature.name &&
          candidate.degree.position == previous.degree.position;
      if (!repeatsPrevious) return candidate;
    }

    return candidate;
  }
}
