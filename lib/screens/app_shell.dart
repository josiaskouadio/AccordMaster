import 'package:flutter/material.dart';

import '../state/app_state.dart';
import 'home_screen.dart';
import 'learn_screen.dart';
import 'memory_screen.dart';
import 'progress_screen.dart';
import 'quiz_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final AppState state;

  @override
  void initState() {
    super.initState();
    state = AppState();
    state.loadProgress();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final screens = [
          HomeScreen(state: state),
          LearnScreen(state: state),
          QuizScreen(state: state),
          MemoryScreen(state: state),
          ProgressScreen(state: state),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF172124),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.piano, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'ACCORDMASTER',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ],
            ),
            centerTitle: false,
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : screens[state.selectedIndex],
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: const Color(0xFFFFD166),
            selectedIndex: state.selectedIndex,
            onDestinationSelected: state.changeTab,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
              NavigationDestination(icon: Icon(Icons.piano), label: 'Studio'),
              NavigationDestination(icon: Icon(Icons.quiz), label: 'Quiz'),
              NavigationDestination(
                icon: Icon(Icons.psychology),
                label: 'Mémoire',
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart),
                label: 'Progrès',
              ),
            ],
          ),
        );
      },
    );
  }
}
