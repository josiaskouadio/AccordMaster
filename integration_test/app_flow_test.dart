import 'package:accord_master/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('le quiz passe automatiquement à la question suivante', (
    tester,
  ) async {
    await tester.pumpWidget(const AccordMasterApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Quiz').first);
    await tester.pumpAndSettle();
    expect(find.text('QUIZ EXPRESS'), findsOneWidget);
    final initialQuestion = tester
        .widget<Text>(find.textContaining('Quel est le degré'))
        .data!;

    await tester.tap(find.byKey(const ValueKey('quiz-answer-0')));
    await tester.pump(const Duration(milliseconds: 1600));
    expect(find.text(initialQuestion), findsNothing);
    expect(find.text('QUIZ EXPRESS'), findsOneWidget);
  });
}
