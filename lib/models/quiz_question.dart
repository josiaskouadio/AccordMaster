import 'chord_degree.dart';
import 'key_signature.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.keySignature,
    required this.degree,
    required this.options,
  });

  final KeySignature keySignature;
  final ChordDegree degree;
  final List<String> options;

  String get prompt =>
      'Quel est le degré ${degree.symbol} en ${keySignature.name} ?';

  String get answer => degree.chord;
}
