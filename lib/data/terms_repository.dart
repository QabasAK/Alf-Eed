import '../models/term.dart';
import 'core_terms.dart';
import 'sample_terms.dart';

/// Abstract interface for the terms data source.
/// Swap this implementation (e.g. for a REST API or SQLite) without
/// touching any screen or widget code.
abstract class TermsRepository {
  List<Term> getAllTerms();
  List<Term> getTermsByCategory(TermCategory category);

  /// Returns terms where [query] matches the English name, Arabic name,
  /// English definition, Arabic definition, or any tag (case-insensitive).
  List<Term> searchTerms(String query);
}

/// Local implementation backed by a hardcoded list in sample_terms.dart,
/// limited to the 42 ids in core_terms.dart.
class LocalTermsRepository implements TermsRepository {
  const LocalTermsRepository();

  List<Term> get _sorted =>
      sampleTerms.where((t) => coreTermIds.contains(t.id)).toList()
        ..sort((a, b) => a.englishName.compareTo(b.englishName));

  @override
  List<Term> getAllTerms() => _sorted;

  @override
  List<Term> getTermsByCategory(TermCategory category) => _sorted
      .where((t) => t.category == category)
      .toList();

  @override
  List<Term> searchTerms(String query) {
    if (query.trim().isEmpty) return _sorted;
    final q = query.trim().toLowerCase();
    return _sorted.where((t) {
      return t.englishName.toLowerCase().contains(q) ||
          t.arabicName.contains(q) ||
          t.englishDefinition.toLowerCase().contains(q) ||
          t.arabicDefinition.contains(q) ||
          t.tags.any((tag) => tag.toLowerCase().contains(q));
    }).toList();
  }
}
