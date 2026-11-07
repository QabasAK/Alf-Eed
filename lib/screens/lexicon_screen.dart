import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/terms_repository.dart';
import '../models/term.dart';
import '../widgets/category_cards.dart';
import '../widgets/search_bar.dart';
import '../widgets/term_row.dart';
import '../theme/app_colors.dart';

const double _maxContentWidth = 1040;

class LexiconScreen extends StatefulWidget {
  const LexiconScreen({super.key});

  @override
  State<LexiconScreen> createState() => _LexiconScreenState();
}

class _LexiconScreenState extends State<LexiconScreen> {
  String _query = '';
  TermCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<TermsRepository>();
    final all = repo.getAllTerms();

    // Stable numbering 01–42: grouped by category, alphabetical within each.
    // Numbers don't change when searching or filtering.
    final ordered = [
      for (final cat in TermCategory.values) ...all.where((t) => t.category == cat),
    ];
    final numberOf = {for (var i = 0; i < ordered.length; i++) ordered[i].id: i + 1};

    final matchIds = repo.searchTerms(_query).map((t) => t.id).toSet();
    final matches = ordered.where((t) => matchIds.contains(t.id)).toList();
    final counts = {
      for (final cat in TermCategory.values) cat: matches.where((t) => t.category == cat).length,
    };
    final visibleCategories = _selectedCategory == null
        ? TermCategory.values.where((c) => counts[c]! > 0).toList()
        : [_selectedCategory!];

    final width = MediaQuery.sizeOf(context).width;
    final minPad = width > 760 ? 40.0 : 16.0;
    final hPad = math.max(minPad, (width - _maxContentWidth) / 2);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.ink),
          onPressed: () => context.go('/engineering'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Engineering Lexicon',
                style: GoogleFonts.inter(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.w700)),
            Text('قاموس المصطلحات الهندسية',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(color: AppColors.blue, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // ── Header: headline + search ────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surface,
              padding: EdgeInsets.fromLTRB(hPad, 40, hPad, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THE LEXICON  /  القاموس',
                    style: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 2, color: AppColors.graphite),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${all.length} terms. Three disciplines.',
                    style: GoogleFonts.inter(
                      fontSize: width > 760 ? 40 : 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                      letterSpacing: -1,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${all.length} مصطلحاً في ثلاثة تخصصات',
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.tajawal(
                        fontSize: width > 760 ? 24 : 20, fontWeight: FontWeight.w800, color: AppColors.blue),
                  ),
                  const SizedBox(height: 24),
                  LexiconSearchBar(onChanged: (v) => setState(() => _query = v)),
                ],
              ),
            ),
          ),

          // ── Discipline cards ─────────────────────────────────────────────
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPad, 24, hPad, 8),
            sliver: SliverToBoxAdapter(
              child: CategoryCards(
                selected: _selectedCategory,
                counts: counts,
                onSelected: (cat) => setState(() => _selectedCategory = cat),
              ),
            ),
          ),

          // ── Term list, grouped by discipline ─────────────────────────────
          if (visibleCategories.every((c) => counts[c] == 0))
            SliverFillRemaining(hasScrollBody: false, child: _EmptyState(query: _query))
          else
            for (final cat in visibleCategories) ...[
              SliverPadding(
                padding: EdgeInsets.fromLTRB(hPad, 28, hPad, 12),
                sliver: SliverToBoxAdapter(child: _SectionHeader(category: cat, count: counts[cat]!)),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 520,
                    mainAxisExtent: 64,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 8,
                  ),
                  delegate: SliverChildListDelegate([
                    for (final t in matches.where((t) => t.category == cat))
                      TermRow(term: t, number: numberOf[t.id]!),
                  ]),
                ),
              ),
            ],

          const SliverToBoxAdapter(child: SizedBox(height: 56)),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final TermCategory category;
  final int count;
  const _SectionHeader({required this.category, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Wrap drops the Arabic label to its own line on narrow screens.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 4,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category.englishLabel.toUpperCase(),
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.6, color: AppColors.ink),
                ),
                const SizedBox(width: 10),
                Text('$count',
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.blue)),
              ],
            ),
            Text(
              category.arabicLabel,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(height: 2, color: AppColors.ink),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String query;
  const _EmptyState({required this.query});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded, size: 56, color: AppColors.stoneDeep),
          const SizedBox(height: 16),
          Text(
            'No results for "$query"',
            style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'لا نتائج لـ "$query"',
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(fontSize: 15, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
