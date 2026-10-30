import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/term.dart';
import '../theme/app_colors.dart';

/// The three discipline cards at the top of the lexicon. Tapping a card
/// filters to it; tapping the selected card again goes back to all terms.
class CategoryCards extends StatelessWidget {
  final TermCategory? selected; // null = all
  final Map<TermCategory, int> counts;
  final ValueChanged<TermCategory?> onSelected;

  const CategoryCards({
    super.key,
    required this.selected,
    required this.counts,
    required this.onSelected,
  });

  static IconData iconFor(TermCategory cat) => switch (cat) {
        TermCategory.engineeringBasics => Icons.architecture_rounded,
        TermCategory.computerEngineering => Icons.memory_rounded,
        TermCategory.electricalEngineering => Icons.electric_bolt_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final cards = [
      for (final cat in TermCategory.values)
        _CategoryCard(
          category: cat,
          count: counts[cat] ?? 0,
          isSelected: selected == cat,
          onTap: () => onSelected(selected == cat ? null : cat),
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 640) {
          return Column(
            children: [
              for (final card in cards) ...[card, const SizedBox(height: 10)],
            ],
          );
        }
        return Row(
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              if (i > 0) const SizedBox(width: 14),
              Expanded(child: cards[i]),
            ],
          ],
        );
      },
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final TermCategory category;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.isSelected;
    final fg = selected ? Colors.white : AppColors.ink;
    final bg = selected
        ? AppColors.blue
        : (_hovered ? AppColors.stoneDeep : AppColors.stone);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Icon(CategoryCards.iconFor(widget.category),
                  size: 34, color: selected ? Colors.white : AppColors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.category.englishLabel,
                        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: fg)),
                    Text(widget.category.arabicLabel,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w700, color: fg)),
                    const SizedBox(height: 4),
                    Text('${widget.count} terms',
                        style: GoogleFonts.inter(
                            fontSize: 12, color: fg.withValues(alpha: selected ? 0.8 : 0.6))),
                  ],
                ),
              ),
              Icon(selected ? Icons.close_rounded : Icons.chevron_right_rounded, color: fg, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
