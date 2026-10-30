import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/terms_repository.dart';
import '../models/term.dart';
import '../widgets/animation_placeholder.dart';
import '../widgets/sign_video_placeholder.dart';
import '../theme/app_colors.dart';

class TermDetailScreen extends StatelessWidget {
  final String termId;
  const TermDetailScreen({super.key, required this.termId});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<TermsRepository>();
    final term = repo.getAllTerms().where((t) => t.id == termId).firstOrNull;

    if (term == null) {
      return Scaffold(
        appBar: AppBar(
          leading: _backButton(context),
          title: const Text('Term Not Found'),
        ),
        body: Center(
          child: Text('No term with id "$termId".',
              style: GoogleFonts.inter(color: AppColors.textSecondary)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: _backButton(context),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(term.englishName,
                style: GoogleFonts.inter(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.w700)),
            Text(term.arabicName,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(color: AppColors.blue, fontSize: 13)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: _TermDetailBody(term: term),
      ),
    );
  }

  Widget _backButton(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: AppColors.ink),
        onPressed: () => context.canPop() ? context.pop() : context.go('/lexicon'),
      );
}

class _TermDetailBody extends StatelessWidget {
  final Term term;
  const _TermDetailBody({required this.term});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 800;
    final hPad = isWide ? 60.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Name header ──────────────────────────────────────────────────────
        Container(
          color: AppColors.surface,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: _EnglishNameBlock(term: term)),
                    const SizedBox(width: 32),
                    Expanded(child: _ArabicNameBlock(term: term)),
                  ],
                )
              : Column(
                  children: [
                    _EnglishNameBlock(term: term),
                    const SizedBox(height: 16),
                    _ArabicNameBlock(term: term),
                  ],
                ),
        ),
        const Divider(height: 1, color: AppColors.border),

        // ── Media panels ─────────────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
          child: isWide
              ? SizedBox(
                  height: 320,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: AnimationPlaceholder(animationPath: term.animationPath)),
                      const SizedBox(width: 20),
                      Expanded(child: SignVideoPlaceholder(videoPath: term.signVideoPath)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 240, child: AnimationPlaceholder(animationPath: term.animationPath)),
                    const SizedBox(height: 16),
                    SizedBox(height: 240, child: SignVideoPlaceholder(videoPath: term.signVideoPath)),
                  ],
                ),
        ),

        // ── Definitions ──────────────────────────────────────────────────────
        Container(
          color: AppColors.surface,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _EnglishDefinition(term: term)),
                    const SizedBox(width: 32),
                    Expanded(child: _ArabicDefinition(term: term)),
                  ],
                )
              : Column(
                  children: [
                    _EnglishDefinition(term: term),
                    const SizedBox(height: 24),
                    _ArabicDefinition(term: term),
                  ],
                ),
        ),
        const Divider(height: 1, color: AppColors.border),

        // ── Category + Tags ──────────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
          child: _MetaRow(term: term),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _EnglishNameBlock extends StatelessWidget {
  final Term term;
  const _EnglishNameBlock({required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('English  •  الإنجليزية',
            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,
                color: AppColors.textSecondary, letterSpacing: 0.5)),
        const SizedBox(height: 6),
        Text(term.englishName,
            style: GoogleFonts.inter(
                fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.blue, height: 1.2)),
      ],
    );
  }
}

class _ArabicNameBlock extends StatelessWidget {
  final Term term;
  const _ArabicNameBlock({required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('العربية  •  Arabic',
            textDirection: TextDirection.rtl,
            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,
                color: AppColors.textSecondary, letterSpacing: 0.5)),
        const SizedBox(height: 6),
        Text(term.arabicName,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(
                fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.blue, height: 1.3)),
      ],
    );
  }
}

class _EnglishDefinition extends StatelessWidget {
  final Term term;
  const _EnglishDefinition({required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Definition',
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700,
                color: AppColors.blue, letterSpacing: 0.8)),
        const SizedBox(height: 10),
        Text(term.englishDefinition,
            style: GoogleFonts.inter(
                fontSize: 15, color: AppColors.textPrimary, height: 1.7)),
      ],
    );
  }
}

class _ArabicDefinition extends StatelessWidget {
  final Term term;
  const _ArabicDefinition({required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('التعريف',
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(fontSize: 12, fontWeight: FontWeight.w700,
                color: AppColors.blue, letterSpacing: 0.4)),
        const SizedBox(height: 10),
        Text(term.arabicDefinition,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(
                fontSize: 15, color: AppColors.textPrimary, height: 1.8)),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final Term term;
  const _MetaRow({required this.term});

  Color get _catColor => AppColors.category(term.category);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Category chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _catColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _catColor.withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(term.category.englishLabel,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: _catColor)),
              const SizedBox(width: 6),
              Text('•', style: TextStyle(fontSize: 10, color: _catColor.withValues(alpha: 0.5))),
              const SizedBox(width: 6),
              Text(term.category.arabicLabel,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(fontSize: 12, fontWeight: FontWeight.w600, color: _catColor)),
            ],
          ),
        ),
        // Tags
        ...term.tags.map(
          (tag) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.chipBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(tag,
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
          ),
        ),
      ],
    );
  }
}
