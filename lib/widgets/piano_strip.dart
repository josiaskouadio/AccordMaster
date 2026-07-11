import 'package:flutter/material.dart';

class PianoStrip extends StatefulWidget {
  const PianoStrip({
    super.key,
    this.compact = false,
    this.onNotePressed,
    this.highlightedNotes = const {},
  });

  final bool compact;
  final ValueChanged<String>? onNotePressed;
  final Set<String> highlightedNotes;

  @override
  State<PianoStrip> createState() => _PianoStripState();
}

class _PianoStripState extends State<PianoStrip> {
  String? _activeNote;

  static const _whiteNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
  static const _blackKeys = <int, String>{
    0: 'C#',
    1: 'D#',
    3: 'F#',
    4: 'G#',
    5: 'A#',
  };

  void _press(String note) {
    setState(() => _activeNote = note);
    widget.onNotePressed?.call(note);
    Future<void>.delayed(const Duration(milliseconds: 220), () {
      if (mounted && _activeNote == note) {
        setState(() => _activeNote = null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 62.0 : 132.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final whiteWidth = constraints.maxWidth / _whiteNotes.length;
        return SizedBox(
          height: height,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final note in _whiteNotes)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Material(
                          color: _activeNote == note
                              ? const Color(0xFFEF476F)
                              : widget.highlightedNotes.contains(note)
                              ? const Color(0xFFFFD166)
                              : const Color(0xFFFFFCF5),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(5),
                          ),
                          child: InkWell(
                            onTap: widget.onNotePressed == null
                                ? null
                                : () => _press(note),
                            child: widget.compact
                                ? null
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 9),
                                      child: Text(
                                        note,
                                        style: const TextStyle(
                                          color: Color(0xFF172124),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              for (final entry in _blackKeys.entries)
                Positioned(
                  left: (entry.key + 1) * whiteWidth - whiteWidth * 0.29,
                  top: 0,
                  width: whiteWidth * 0.58,
                  height: height * 0.61,
                  child: Material(
                    color: _activeNote == entry.value
                        ? const Color(0xFFEF476F)
                        : widget.highlightedNotes.contains(entry.value)
                        ? const Color(0xFFFFD166)
                        : const Color(0xFF172124),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(5),
                    ),
                    child: InkWell(
                      onTap: widget.onNotePressed == null
                          ? null
                          : () => _press(entry.value),
                      child: widget.compact
                          ? null
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 7),
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    color:
                                        widget.highlightedNotes.contains(
                                              entry.value,
                                            ) &&
                                            _activeNote != entry.value
                                        ? const Color(0xFF172124)
                                        : Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
