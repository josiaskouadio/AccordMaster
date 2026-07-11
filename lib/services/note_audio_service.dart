import 'package:audioplayers/audioplayers.dart';

class NoteAudioService {
  List<AudioPlayer>? _players;
  int _playerIndex = 0;

  List<AudioPlayer> get _availablePlayers =>
      _players ??= List.generate(4, (_) => AudioPlayer());

  static const Map<String, String> _files = {
    'C': 'C4.wav',
    'C#': 'Cs4.wav',
    'D': 'D4.wav',
    'D#': 'Ds4.wav',
    'E': 'E4.wav',
    'F': 'F4.wav',
    'F#': 'Fs4.wav',
    'G': 'G4.wav',
    'G#': 'Gs4.wav',
    'A': 'A4.wav',
    'A#': 'As4.wav',
    'B': 'B4.wav',
  };

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

  Future<void> playNote(String note) async {
    final file = _files[note];
    if (file == null) return;

    final players = _availablePlayers;
    final player = players[_playerIndex];
    _playerIndex = (_playerIndex + 1) % players.length;
    await player.stop();
    await player.play(AssetSource('audio/$file'));
  }

  Future<void> playChord(String chord) async {
    final root = chord.length > 1 && chord[1] == '#'
        ? chord.substring(0, 2)
        : chord.substring(0, 1);
    final rootIndex = _chromatic.indexOf(root);
    if (rootIndex == -1) return;

    final intervals = chord.endsWith('dim')
        ? const [0, 3, 6]
        : chord.endsWith('m')
        ? const [0, 3, 7]
        : const [0, 4, 7];

    await Future.wait([
      for (final interval in intervals)
        playNote(_chromatic[(rootIndex + interval) % _chromatic.length]),
    ]);
  }

  Future<void> dispose() async {
    for (final player in _players ?? const <AudioPlayer>[]) {
      await player.dispose();
    }
  }
}
