import 'package:flutter/material.dart';

import '../models/chord_degree.dart';

class DegreeCard extends StatelessWidget {
  const DegreeCard({super.key, required this.degree, required this.onPlay});

  final ChordDegree degree;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          onTap: onPlay,
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    degree.symbol,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        degree.chord,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF16343A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${degree.note} - ${degree.role}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                IconButton.filled(
                  onPressed: onPlay,
                  tooltip: 'Ecouter ${degree.chord}',
                  icon: const Icon(Icons.volume_up_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
