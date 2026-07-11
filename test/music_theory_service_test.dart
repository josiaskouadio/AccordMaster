import 'dart:math';

import 'package:accord_master/models/key_signature.dart';
import 'package:accord_master/services/music_theory_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final service = MusicTheoryService();

  test('genere les accords de Do majeur', () {
    final key = service.buildKey('C', KeyMode.major);

    expect(key.degrees.map((degree) => degree.chord).toList(), [
      'C',
      'Dm',
      'Em',
      'F',
      'G',
      'Am',
      'Bdim',
    ]);
  });

  test('genere les accords de La mineur naturel', () {
    final key = service.buildKey('A', KeyMode.minor);

    expect(key.degrees.map((degree) => degree.chord).toList(), [
      'Am',
      'Bdim',
      'C',
      'Dm',
      'Em',
      'F',
      'G',
    ]);
  });

  test('cree une question avec la bonne reponse dans les options', () {
    final key = service.buildKey('G', KeyMode.major);
    final question = service.questionFor(key, 2);

    expect(question.options, contains(question.answer));
    expect(question.options.length, 4);
  });

  test('varie les tonalites et les degres du quiz', () {
    final catalog = service.buildCatalog();
    final random = Random(42);
    final questions = <String>{};
    final tonalites = <String>{};
    final degres = <int>{};
    var previous = service.randomQuestion(catalog, random);
    questions.add('${previous.keySignature.name}-${previous.degree.position}');
    tonalites.add(previous.keySignature.name);
    degres.add(previous.degree.position);

    for (var index = 0; index < 20; index++) {
      final next = service.randomQuestion(catalog, random, previous: previous);
      expect(
        '${next.keySignature.name}-${next.degree.position}',
        isNot('${previous.keySignature.name}-${previous.degree.position}'),
      );
      questions.add('${next.keySignature.name}-${next.degree.position}');
      tonalites.add(next.keySignature.name);
      degres.add(next.degree.position);
      previous = next;
    }

    expect(questions.length, greaterThan(10));
    expect(tonalites.length, greaterThan(5));
    expect(degres.length, greaterThan(3));
  });

  test('limite le quiz aux tonalites majeures', () {
    final catalog = service
        .buildCatalog()
        .where((key) => key.mode == KeyMode.major)
        .toList();
    final random = Random(7);

    for (var index = 0; index < 30; index++) {
      final question = service.randomQuestion(catalog, random);
      expect(question.keySignature.mode, KeyMode.major);
    }
  });
}
