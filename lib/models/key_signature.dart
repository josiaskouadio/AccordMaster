import 'chord_degree.dart';

enum KeyMode { major, minor }

class KeySignature {
  const KeySignature({
    required this.name,
    required this.tonic,
    required this.mode,
    required this.degrees,
  });

  final String name;
  final String tonic;
  final KeyMode mode;
  final List<ChordDegree> degrees;

  String get modeLabel => mode == KeyMode.major ? 'Majeur' : 'Mineur naturel';
}
