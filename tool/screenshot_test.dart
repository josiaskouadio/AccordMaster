import 'package:accord_master/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final textFonts = FontLoader('AppRoboto')
      ..addFont(rootBundle.load('assets/fonts/roboto-regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/roboto-medium.ttf'))
      ..addFont(rootBundle.load('assets/fonts/roboto-bold.ttf'))
      ..addFont(rootBundle.load('assets/fonts/roboto-black.ttf'));
    final iconFont = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('assets/fonts/materialicons-regular.otf'));
    await Future.wait([textFonts.load(), iconFont.load()]);
  });

  testWidgets('génère les captures des écrans principaux', (tester) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const AccordMasterApp());
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../docs/captures/01_accueil.png'),
    );

    await _captureTab(tester, 'Studio', '02_studio.png');
    await _captureTab(tester, 'Quiz', '03_quiz.png');
    await _captureTab(tester, 'Mémoire', '04_memoire.png');
    await _captureTab(tester, 'Progrès', '05_progres.png');
  });
}

Future<void> _captureTab(
  WidgetTester tester,
  String label,
  String fileName,
) async {
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('../docs/captures/$fileName'),
  );
}
