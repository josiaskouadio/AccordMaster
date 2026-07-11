import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:accord_master/main.dart';

void main() {
  testWidgets("AccordMaster affiche l'accueil", (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const AccordMasterApp());
    await tester.pump();

    expect(find.text('ACCORDMASTER'), findsOneWidget);
    expect(find.text('Studio'), findsOneWidget);
    expect(find.text('Quiz'), findsWidgets);
  });
}
