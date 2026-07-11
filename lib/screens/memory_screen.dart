import 'package:flutter/material.dart';

import '../state/app_state.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key, required this.state});

  final AppState state;

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  final _controllers = List.generate(7, (_) => TextEditingController());
  List<bool>? _results;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _check() async {
    final answers = _controllers.map((controller) => controller.text).toList();
    final results = await widget.state.checkMemory(answers);
    if (mounted) setState(() => _results = results);
  }

  void _clear() {
    for (final controller in _controllers) {
      controller.clear();
    }
    setState(() => _results = null);
  }

  @override
  Widget build(BuildContext context) {
    final key = widget.state.selectedKey;
    final score = _results?.where((result) => result).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD166),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MODE MÉMOIRE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reconstruis la tonalité',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.psychology_rounded, size: 42),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF172124),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TONALITÉ À COMPLÉTER',
                      style: TextStyle(
                        color: Color(0xFF95A3A5),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      key.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              if (score != null)
                Text(
                  '$score/7',
                  style: const TextStyle(
                    color: Color(0xFF06A77D),
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        for (var index = 0; index < key.degrees.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: _controllers[index],
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 48,
                  alignment: Alignment.center,
                  child: Text(
                    key.degrees[index].symbol,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                labelText: 'Accord du degré ${key.degrees[index].symbol}',
                hintText: 'Ex. C, Dm ou Bdim',
                suffixIcon: _results == null
                    ? null
                    : Icon(
                        _results![index] ? Icons.check_circle : Icons.cancel,
                        color: _results![index]
                            ? const Color(0xFF06A77D)
                            : const Color(0xFFEF476F),
                      ),
                helperText: _results == null
                    ? null
                    : 'Réponse : ${key.degrees[index].chord}',
              ),
            ),
          ),
        const SizedBox(height: 6),
        FilledButton.icon(
          onPressed: _check,
          icon: const Icon(Icons.fact_check_rounded),
          label: const Text('Vérifier mes réponses'),
        ),
        TextButton.icon(
          onPressed: _clear,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Recommencer'),
        ),
      ],
    );
  }
}
