import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../models/term.dart';
import '../theme/app_colors.dart';

/// One line in the lexicon list: number, English name, Arabic name, media
/// indicators. Tapping opens the term page.
class TermRow extends StatefulWidget {
  final Term term;
  final int number;

  const TermRow({super.key, required this.term, required this.number});

  @override
  State<TermRow> createState() => _TermRowState();
}

class _TermRowState extends State<TermRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final term = widget.term;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/term/${term.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _hovered ? AppColors.blue : AppColors.border,
              width: _hovered ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  widget.number.toString().padLeft(2, '0'),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _hovered ? AppColors.blue : AppColors.graphite,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              Expanded(
                // Side by side when there's room, stacked (English over Arabic) on phones.
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final english = Text(
                      term.englishName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink, height: 1.2),
                    );
                    final arabic = Text(
                      term.arabicName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.tajawal(
                          fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink, height: 1.2),
                    );
                    if (constraints.maxWidth < 300) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [english, arabic],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: english),
                        const SizedBox(width: 12),
                        Flexible(child: arabic),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Media available for this term (blue = ready)
              if (term.signVideoPath != null)
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.sign_language_rounded, size: 16, color: AppColors.blue),
                ),
              if (term.animationPath != null)
                const Icon(Icons.play_circle_outline_rounded, size: 16, color: AppColors.blue),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right_rounded,
                  size: 20, color: _hovered ? AppColors.blue : AppColors.graphite),
            ],
          ),
        ),
      ),
    );
  }
}
