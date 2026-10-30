import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jslexicon/main.dart';
import 'package:jslexicon/data/core_terms.dart';
import 'package:jslexicon/data/terms_repository.dart';
import 'package:jslexicon/models/term.dart';

void main() {
  testWidgets('App smoke test — home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<TermsRepository>(
        create: (_) => const LocalTermsRepository(),
        child: const JslLexiconApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Why 42 terms?'), findsOneWidget);
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
