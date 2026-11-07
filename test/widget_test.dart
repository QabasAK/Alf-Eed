import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jslexicon/main.dart';
import 'package:jslexicon/data/core_terms.dart';
import 'package:jslexicon/data/initiative.dart';
import 'package:jslexicon/data/terms_repository.dart';
import 'package:jslexicon/models/term.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Provider<TermsRepository>(
        create: (_) => const LocalTermsRepository(),
        child: const JslLexiconApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('App smoke test — initiative home renders', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.text('Every field gets its own number.'), findsOneWidget);
  });

  testWidgets('Tapping a number flips its card to the joke', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.textContaining('Grothendieck'), findsNothing);

    await tester.ensureVisible(find.text('57'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('57'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Grothendieck'), findsOneWidget);
    expect(find.text('Claim it  •  احجزه'), findsOneWidget);
  });

  testWidgets('The engineering card leads to the old home', (WidgetTester tester) async {
    await pumpApp(tester);
    await tester.ensureVisible(find.text('42'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('42'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open it  •  افتح'));
    await tester.pumpAndSettle();
    expect(find.text('Why 42 terms?'), findsOneWidget);
  });

  test('Every field has its own number and colour', () {
    expect(initiativeFields.map((f) => f.count).toSet(), hasLength(initiativeFields.length));
    expect(initiativeFields.map((f) => f.color).toSet(), hasLength(initiativeFields.length));
  });

  test('Lexicon has exactly 42 core terms, 14 per category', () {
    final terms = const LocalTermsRepository().getAllTerms();

    // Catches a typo'd id in core_terms.dart silently dropping a term.
    expect(terms.map((t) => t.id).toSet(), coreTermIds);
    expect(terms, hasLength(42));
    for (final cat in TermCategory.values) {
      expect(terms.where((t) => t.category == cat), hasLength(14), reason: cat.englishLabel);
    }
  });
}
