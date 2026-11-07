import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
import '../data/initiative.dart';
import '../theme/app_colors.dart';
import '../widgets/liu_logo.dart';
import '../widgets/logo_panel.dart';

/// The الف ايد home page: the initiative that the engineering lexicon is
/// the first field of.
class InitiativeScreen extends StatefulWidget {
  const InitiativeScreen({super.key});

  @override
  State<InitiativeScreen> createState() => _InitiativeScreenState();
}

class _InitiativeScreenState extends State<InitiativeScreen> {
  final _fieldsKey = GlobalKey();
  final _universitiesKey = GlobalKey();
  final _toolkitKey = GlobalKey();

  void _scrollTo(GlobalKey key) => Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // The initiative is neutral ink on paper: blue belongs to engineering,
    // and colour on this page only ever means a field.
    return Theme(
      data: theme.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.hovered) ? AppColors.graphite : AppColors.ink,
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _NavBar(
                onFields: () => _scrollTo(_fieldsKey),
                onUniversities: () => _scrollTo(_universitiesKey),
                onToolkit: () => _scrollTo(_toolkitKey),
              ),
              const SizedBox(height: 6, child: _FieldStripes()),
              _Hero(onToolkit: () => _scrollTo(_toolkitKey)),
              _FieldsSection(key: _fieldsKey, onClaim: () => _scrollTo(_toolkitKey)),
              _UniversitiesSection(key: _universitiesKey),
              _ToolkitSection(key: _toolkitKey),
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Shared pieces ─────────────────────────────────────────────────────────────

/// Every field's colour side by side, each as wide as its term count.
class _FieldStripes extends StatelessWidget {
  const _FieldStripes();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final field in initiativeFields)
          Expanded(flex: field.count, child: ColoredBox(color: field.color)),
      ],
    );
  }
}

/// Full-width coloured band with the site's centred 1040px column.
class _Band extends StatelessWidget {
  final Color color;
  final Widget child;
  const _Band({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: isWide ? 72 : 48),
      child: Center(
        // Full width up to the max, so every band's left edge lines up.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String english;
  final String arabic;
  final String body;
  final String arabicBody;
  final Color color;

  const _Heading({
    required this.english,
    required this.arabic,
    required this.body,
    required this.arabicBody,
    this.color = AppColors.ink,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;
    final soft = color == AppColors.ink ? AppColors.textSecondary : Colors.white.withValues(alpha: 0.85);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(english,
              style: GoogleFonts.inter(
                  fontSize: isWide ? 32 : 26, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(arabic,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(fontSize: isWide ? 26 : 22, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 16),
          Text(body, style: GoogleFonts.inter(fontSize: 15, color: soft, height: 1.7)),
          const SizedBox(height: 8),
          Text(arabicBody,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(fontSize: 15, color: soft, height: 1.8)),
        ],
      ),
    );
  }
}

/// Link so the toolkit downloads like a normal file, with a real href.
class _ToolkitButton extends StatelessWidget {
  final String label;
  const _ToolkitButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.base.resolve(toolkitPath),
      target: LinkTarget.blank,
      builder: (context, followLink) => ElevatedButton.icon(
        onPressed: followLink,
        icon: const Icon(Icons.download_rounded, size: 20),
        label: Text(label),
      ),
    );
  }
}

class _ExternalButton extends StatelessWidget {
  final String url;
  final String label;
  final Color color;
  const _ExternalButton({required this.url, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (context, followLink) => OutlinedButton(
        onPressed: followLink,
        style: OutlinedButton.styleFrom(foregroundColor: color, side: BorderSide(color: color)),
        child: Text(label),
      ),
    );
  }
}

// ── Navigation Bar ────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  final VoidCallback onFields;
  final VoidCallback onUniversities;
  final VoidCallback onToolkit;

  const _NavBar({required this.onFields, required this.onUniversities, required this.onToolkit});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: width > 760 ? 40 : 20, vertical: 14),
      child: Row(
        children: [
          const LiuLogo(width: 64, variant: LiuLogoVariant.wordmark, accent: AppColors.ink),
          const Spacer(),
          if (width > 760) ...[
            TextButton(onPressed: onFields, child: const Text('Fields  •  التخصصات')),
            TextButton(onPressed: onUniversities, child: const Text('Universities  •  الجامعات')),
            const SizedBox(width: 12),
          ],
          ElevatedButton(
            onPressed: onToolkit,
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
            child: const Text('Start your own'),
          ),
        ],
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  final VoidCallback onToolkit;
  const _Hero({required this.onToolkit});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    final copy = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A thousand hands,\none field at a time.',
          style: GoogleFonts.inter(
            fontSize: isWide ? 48 : 34,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
            height: 1.08,
            letterSpacing: isWide ? -1.5 : -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'ألف ايد، تخصصاً بعد تخصص',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: isWide ? 26 : 22,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'University subjects run on technical vocabulary. الف ايد builds open, bilingual lexicons '
          'in Jordanian Sign Language, one field at a time. Engineering is first. Yours could be next.',
          style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary, height: 1.7),
        ),
        const SizedBox(height: 8),
        Text(
          'تقوم المواد الجامعية على مصطلحات تخصصية. تبني مبادرة الف ايد معاجم مفتوحة وثنائية اللغة '
          'بلغة الإشارة الأردنية، تخصصاً بعد تخصص. بدأنا بالهندسة، وقد يكون تخصصك التالي.',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(fontSize: 16, color: AppColors.textSecondary, height: 1.8),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/engineering'),
              icon: const Icon(Icons.arrow_forward_rounded, size: 20),
              iconAlignment: IconAlignment.end,
              label: const Text('Engineering lexicon  •  القاموس الهندسي'),
            ),
            OutlinedButton(
              onPressed: onToolkit,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.ink,
                side: const BorderSide(color: AppColors.ink),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: const Text('Start your own  •  ابدأ مبادرتك'),
            ),
          ],
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: isWide ? 80 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: isWide
              ? Row(
                  children: [
                    Expanded(child: copy),
                    const SizedBox(width: 64),
                    const LogoPanel(
                      logoWidth: 220,
                      variant: LiuLogoVariant.wordmark,
                      accent: AppColors.ink,
                      offsetBlock: _FieldStripes(),
                    ),
                  ],
                )
              : copy,
        ),
      ),
    );
  }
}

// ── Fields: every field gets its own number ───────────────────────────────────

class _FieldsSection extends StatelessWidget {
  final VoidCallback onClaim;
  const _FieldsSection({super.key, required this.onClaim});

  @override
  Widget build(BuildContext context) {
    return _Band(
      color: AppColors.ink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Heading(
            english: 'Every field gets its own number.',
            arabic: 'لكل تخصص رقمه الخاص',
            body: 'Engineering got 42. Nobody said everyone has to. Tap a number to find out why.',
            arabicBody: 'للهندسة الرقم 42، ولا أحد قال إن الجميع ملزم به. اضغط على أي رقم لتعرف السبب.',
            color: Colors.white,
          ),
          const SizedBox(height: 40),
          // Full width, or the Wrap shrinks to its cards and has nothing to centre in.
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                for (final field in initiativeFields) _FieldCard(field: field, onClaim: onClaim),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A number on the front and the joke behind it on the back. Tap to flip.
class _FieldCard extends StatefulWidget {
  final InitiativeField field;
  final VoidCallback onClaim;
  const _FieldCard({required this.field, required this.onClaim});

  @override
  State<_FieldCard> createState() => _FieldCardState();
}

class _FieldCardState extends State<_FieldCard> {
  static const double _width = 244;
  static const double _height = 300;

  bool _flipped = false;

  @override
  Widget build(BuildContext context) {
    final field = widget.field;
    return Semantics(
      button: true,
      label: '${field.englishName}: ${field.count}. ${_flipped ? 'Hide' : 'Show'} why',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => setState(() => _flipped = !_flipped),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: _flipped ? math.pi : 0),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            builder: (context, angle, _) {
              final showBack = angle > math.pi / 2;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                child: Container(
                  width: _width,
                  height: _height,
                  padding: const EdgeInsets.all(20),
                  color: field.color,
                  child: showBack
                      // Rotated again so the back doesn't read mirrored.
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: _CardBack(field: field, onClaim: widget.onClaim),
                        )
                      : _CardFront(field: field),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  final InitiativeField field;
  const _CardFront({required this.field});

  @override
  Widget build(BuildContext context) {
    final isLive = field.route != null;
    final soft = Colors.white.withValues(alpha: 0.85);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isLive ? 'LIVE  •  متاح' : 'UNCLAIMED  •  بانتظارك',
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: soft),
        ),
        const Spacer(),
        Text(
          '${field.count}',
          style: GoogleFonts.inter(fontSize: 64, fontWeight: FontWeight.w800, letterSpacing: -2.5, color: Colors.white, height: 1),
        ),
        const Spacer(),
        Text(field.englishName, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
        Align(
          alignment: Alignment.centerRight,
          child: Text(field.arabicName,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
      ],
    );
  }
}

class _CardBack extends StatelessWidget {
  final InitiativeField field;
  final VoidCallback onClaim;
  const _CardBack({required this.field, required this.onClaim});

  @override
  Widget build(BuildContext context) {
    final route = field.route;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scrolls rather than pushing the button off the card if a joke runs long.
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(field.englishJoke, style: GoogleFonts.inter(fontSize: 13, color: Colors.white, height: 1.5)),
                const SizedBox(height: 8),
                Text(field.arabicJoke,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.tajawal(fontSize: 14, color: Colors.white, height: 1.6)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        route != null
            ? ElevatedButton(
                onPressed: () => context.go(route),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: field.color),
                child: const Text('Open it  •  افتح'),
              )
            : OutlinedButton(
                onPressed: onClaim,
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white)),
                child: const Text('Claim it  •  احجزه'),
              ),
      ],
    );
  }
}

// ── University adoption ───────────────────────────────────────────────────────

class _UniversitiesSection extends StatelessWidget {
  const _UniversitiesSection({super.key});

  static const _asks = [
    (Icons.link_rounded, 'Link it', 'اربطه',
        'Put the lexicon on your accessibility or student services page.',
        'أضف القاموس إلى صفحة شؤون الطلبة أو ذوي الإعاقة في جامعتك.'),
    (Icons.school_rounded, 'Teach with it', 'درّس به',
        'One instructor, one course, one semester. That\'s a real start.',
        'مدرّس واحد ومادة واحدة وفصل واحد. هذه بداية حقيقية.'),
    (Icons.volunteer_activism_rounded, 'Back a field', 'ادعم تخصصاً',
        'Lend subject experts and filming space, and fund fair pay for Deaf signers.',
        'وفّر خبراء في التخصص ومكاناً للتصوير، وادعم أجراً عادلاً للمؤدين الصمّ.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Band(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Heading(
            english: 'Bring it to your university.',
            arabic: 'انقله إلى جامعتك',
            body: 'The lexicon does the most good where Deaf students already study. Adopting it can be as small as one link.',
            arabicBody: 'يفيد القاموس أكثر حيث يدرس الطلبة الصمّ فعلاً، وقد يبدأ اعتماده برابط واحد.',
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              for (final (icon, en, ar, body, arBody) in _asks)
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(24),
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: AppColors.ink, size: 32),
                      const SizedBox(height: 16),
                      Text(en, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(ar,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
                      ),
                      const SizedBox(height: 10),
                      Text(body, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(arBody,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.tajawal(fontSize: 13, color: AppColors.textSecondary, height: 1.6)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const _ToolkitButton(label: 'Get the one-page pitch  •  حمّل الصفحة التعريفية'),
              if (contactUrl != null)
                _ExternalButton(url: contactUrl!, label: 'Talk to us  •  تواصل معنا', color: AppColors.ink),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Start your own ────────────────────────────────────────────────────────────

class _ToolkitSection extends StatelessWidget {
  const _ToolkitSection({super.key});

  static const _skills = [
    ('/pick-your-number', 'Find your field\'s number', 'اختر رقم تخصصك'),
    ('/term-list', 'Draft terms and definitions', 'صُغ المصطلحات والتعريفات'),
    ('/concept-video', 'Animate 15-second concept videos', 'أنشئ مقاطع توضيحية قصيرة'),
    ('/sign-shoot', 'Prepare your filming days', 'حضّر أيام التصوير'),
    ('/university-pitch', 'Write the pitch for your dean', 'اكتب العرض لعميد كليتك'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Band(
      color: AppColors.stone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Heading(
            english: 'Start your own.',
            arabic: 'ابدأ مبادرتك',
            body: 'The playbook, the templates and five Claude skills: what you need to get started, in one download. '
                'Claude handles the paperwork and the animations. The signs come from Deaf signers, always.',
            arabicBody: 'الدليل والنماذج وخمس مهارات لـ Claude: ما تحتاجه للبدء في ملف واحد. '
                'يتولى Claude الأوراق والرسوم المتحركة، أما الإشارات فتأتي دائماً من المؤدين الصمّ.',
          ),
          const SizedBox(height: 32),
          const _SkillGrid(skills: _skills),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              const _ToolkitButton(label: 'Download the toolkit  •  حمّل الأدوات'),
              if (repoUrl != null)
                _ExternalButton(url: repoUrl!, label: 'Fork the site  •  انسخ الموقع', color: AppColors.ink),
            ],
          ),
        ],
      ),
    );
  }
}

/// Skill cards in as many columns as fit. Each row stretches to its tallest
/// card, so the cards line up at any width or text size.
class _SkillGrid extends StatelessWidget {
  final List<(String, String, String)> skills;
  const _SkillGrid({required this.skills});

  static const double _minWidth = 195; // Five fit one row of the 1040px column.
  static const double _gap = 16;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final perRow = ((constraints.maxWidth + _gap) / (_minWidth + _gap)).floor().clamp(1, skills.length);
        final width = (constraints.maxWidth - _gap * (perRow - 1)) / perRow;
        return Column(
          spacing: _gap,
          children: [
            for (var i = 0; i < skills.length; i += perRow)
              IntrinsicHeight(
                child: Row(
                  spacing: _gap,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (command, en, ar) in skills.skip(i).take(perRow))
                      Container(
                        width: width,
                        padding: const EdgeInsets.all(16),
                        color: AppColors.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(command,
                                style: GoogleFonts.robotoMono(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.ink)),
                            const SizedBox(height: 8),
                            Text(en, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(ar,
                                  textDirection: TextDirection.rtl,
                                  style: GoogleFonts.tajawal(fontSize: 13, color: AppColors.textSecondary, height: 1.6)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.ink,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 12,
        children: [
          const LiuLogo(width: 44, variant: LiuLogoVariant.wordmark, color: Colors.white, accent: Colors.white),
          Text(
            '1000 Hands  •  الف ايد',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
