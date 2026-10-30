import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// How much of the LIU × ألف ايد lockup to show.
enum LiuLogoVariant {
  /// Block "LIU" mark only — avatars, app icons, tight spaces.
  mark,

  /// Mark over the Arabic wordmark and blue rule — nav bars.
  wordmark,

  /// Wordmark plus the "Jordanian Sign Language / Engineering Lexicon" caption.
  full,
}

/// The LIU brand lockup, drawn in code so it stays sharp at any size.
///
/// [width] sets the whole lockup width; everything else scales from it.
/// Pass [color]/[accent] = white to place it on the blue or ink backgrounds.
class LiuLogo extends StatelessWidget {
  final double width;
  final LiuLogoVariant variant;
  final Color color;
  final Color accent;

  const LiuLogo({
    super.key,
    required this.width,
    this.variant = LiuLogoVariant.full,
    this.color = AppColors.ink,
    this.accent = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final mark = SizedBox(
      width: width,
      height: width * _LiuMarkPainter.aspect,
      child: CustomPaint(painter: _LiuMarkPainter(color: color, accent: accent)),
    );
    if (variant == LiuLogoVariant.mark) return mark;

    return Semantics(
      label: 'LIU — ألف ايد',
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            mark,
            SizedBox(height: width * 0.03),
            // FittedBox stretches the Arabic wordmark to the mark's width.
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'الف ايد',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  color: color,
                  height: 1.0,
                ),
              ),
            ),
            SizedBox(height: width * 0.03),
            Container(height: width * 0.055, color: accent),
            if (variant == LiuLogoVariant.full) ...[
              SizedBox(height: width * 0.06),
              Text(
                'Jordanian Sign Language\nEngineering Lexicon',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: (width * 0.075).clamp(8.0, 15.0),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                  height: 1.35,
                  color: color.withValues(alpha: 0.75),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Paints the geometric "LIU" glyphs on a 14 × 8 unit grid.
/// The tittle of the "i" is the only accent-coloured block.
class _LiuMarkPainter extends CustomPainter {
  static const double _cols = 14;
  static const double _rows = 8;
  static const double aspect = _rows / _cols;

  final Color color;
  final Color accent;

  const _LiuMarkPainter({required this.color, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final u = size.width / _cols;
    Rect r(double l, double t, double rr, double b) =>
        Rect.fromLTRB(l * u, t * u, rr * u, b * u);

    // Overlapping rects in one path: drawing them separately leaves
    // anti-aliasing seams where blocks meet.
    final glyphs = Path()
      // L
      ..addRect(r(0, 0, 2, 8))
      ..addRect(r(0, 6, 4, 8))
      // i (stem)
      ..addRect(r(5, 3, 7, 8))
      // U (short left arm, tall right arm)
      ..addRect(r(8, 3, 10, 8))
      ..addRect(r(8, 6, 14, 8))
      ..addRect(r(12, 0, 14, 8));
    canvas.drawPath(glyphs, Paint()..color = color);
    // i (tittle) — the only accent block
    canvas.drawRect(r(5, 0, 7, 2), Paint()..color = accent);
  }

  @override
  bool shouldRepaint(_LiuMarkPainter old) => old.color != color || old.accent != accent;
}
