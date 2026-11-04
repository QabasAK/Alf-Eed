import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
import '../theme/app_colors.dart';
import '../widgets/liu_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _NavBar(onExploreTap: () => context.go('/lexicon')),
            _HeroSection(onExploreTap: () => context.go('/lexicon')),
            const _Why42Section(),
            const _InfoSection(),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

// ── Navigation Bar ────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  final VoidCallback onExploreTap;
  const _NavBar({required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 760;
    // The label + primary button only fit comfortably on wider screens.
    final showExtras = width > 900;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 20, vertical: 14),
      child: Row(
        children: [
          const LiuLogo(width: 64, variant: LiuLogoVariant.wordmark),
          const SizedBox(width: 14),
          if (showExtras)
            Text(
              '1000 Hands',
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          const Spacer(),
          TextButton(
            onPressed: onExploreTap,
            child: const Text('Lexicon  •  القاموس'),
          ),
          if (showExtras) ...[
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: onExploreTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              child: const Text('Explore terms'),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Hero Section ──────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final VoidCallback onExploreTap;
  const _HeroSection({required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    final exploreButton = ElevatedButton.icon(
      onPressed: onExploreTap,
      icon: const Icon(Icons.arrow_forward_rounded, size: 20),
      iconAlignment: IconAlignment.end,
      label: const Text('Explore Lexicon  •  استكشف القاموس'),
    );

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 80 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Left: text + button ──────────────────────────────
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _HeroText(),
                          const SizedBox(height: 32),
                          exploreButton,
                        ],
                      ),
                    ),
                    const SizedBox(width: 64),
                    // ── Right: logo panel ────────────────────────────────
                    const _LogoPanel(logoWidth: 220),
                  ],
                )
              // Narrow screens fall back to a single column
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: _LogoPanel(logoWidth: 150)),
                    const SizedBox(height: 36),
                    const _HeroText(),
                    const SizedBox(height: 32),
                    exploreButton,
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Engineering, in\nJordanian Sign Language.',
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
          'قاموس لغة الإشارة الأردنية للهندسة',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: isWide ? 26 : 22,
            fontWeight: FontWeight.w800,
            color: AppColors.blue,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bridging engineering knowledge and Jordanian Sign Language through a bilingual, accessible lexicon.',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'تجسير المعرفة الهندسية ولغة الإشارة الأردنية من خلال معجم ثنائي اللغة وشامل للجميع.',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}

/// Stone panel holding the full logo lockup, echoing the brand board's
/// offset grey blocks.
class _LogoPanel extends StatelessWidget {
  final double logoWidth;
  const _LogoPanel({required this.logoWidth});

  @override
  Widget build(BuildContext context) {
    final pad = logoWidth * 0.28;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Decorative offset block
        Positioned(
          right: -pad * 0.35,
          bottom: -pad * 0.35,
          width: pad * 1.6,
          height: pad * 1.6,
          child: Container(color: AppColors.blue),
        ),
        Container(
          padding: EdgeInsets.all(pad),
          color: AppColors.stone,
          child: LiuLogo(width: logoWidth),
        ),
      ],
    );
  }
}

// ── Why 42 Section ────────────────────────────────────────────────────────────

class _Why42Section extends StatelessWidget {
  const _Why42Section();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    final cover = _BookCover(width: isWide ? 220 : 170);

    final copy = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why 42 terms?',
          style: GoogleFonts.inter(
            fontSize: isWide ? 32 : 26,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'لماذا 42 مصطلحاً؟',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: isWide ? 26 : 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Container(width: 48, height: 4, color: Colors.white),
        const SizedBox(height: 16),
        Text(
          'In The Hitchhiker\'s Guide to the Galaxy, 42 is the answer to life, '
          'the universe and everything. We made it our answer too: 42 core terms, '
          '14 each from engineering basics, computer engineering and electrical '
          'engineering, chosen because students meet them first and use them most.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.88),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'في رواية «دليل المسافر إلى المجرة» الرقم 42 هو جواب سؤال الحياة والكون '
          'وكل شيء، واعتمدناه جوابنا أيضاً: 42 مصطلحاً أساسياً، 14 من كل من أساسيات '
          'الهندسة وهندسة الحاسوب والهندسة الكهربائية، اخترناها لأنها أول ما يواجهه '
          'الطالب وأكثر ما يستخدمه.',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.85),
            height: 1.8,
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      color: AppColors.blue,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 72 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    cover,
                    const SizedBox(width: 56),
                    Expanded(child: copy),
                  ],
                )
              else ...[
                cover,
                const SizedBox(height: 32),
                copy,
              ],
              const SizedBox(height: 56),
              const _FameTimeline(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The novel's cover (images/hitchhikers_guide_cover.jpg) dressed as a
/// physical book: spine shading, a soft sheen, a drop shadow, and two
/// brand stickers — "42" on the top corner, "Don't Panic" on the bottom.
class _BookCover extends StatelessWidget {
  final double width;
  const _BookCover({required this.width});

  static const double _aspect = 826 / 550; // cover image height / width
  static final Uri _bookPage = Uri.parse(
    'https://en.wikipedia.org/wiki/The_Hitchhiker%27s_Guide_to_the_Galaxy_(novel)',
  );

  @override
  Widget build(BuildContext context) {
    final s = width / 220; // scale factor; the design is drawn at 220 wide
    final height = width * _aspect;
    const radius = BorderRadius.only(
      topLeft: Radius.circular(2),
      bottomLeft: Radius.circular(2),
      topRight: Radius.circular(6),
      bottomRight: Radius.circular(6),
    );

    final book = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 28 * s,
            offset: Offset(12 * s, 18 * s),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'images/hitchhikers_guide_cover.jpg',
              fit: BoxFit.cover,
              semanticLabel: 'Cover of The Hitchhiker\'s Guide to the Galaxy by Douglas Adams',
            ),
            // Spine: dark fold with a thin highlight just past it.
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: width * 0.09,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.45),
                      Colors.black.withValues(alpha: 0.10),
                      Colors.white.withValues(alpha: 0.18),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.55, 0.7, 1],
                  ),
                ),
              ),
            ),
            // Soft sheen across the top-left, like light on a glossy cover.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                  colors: [Colors.white.withValues(alpha: 0.14), Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Padding leaves room for the stickers that hang off the edges.
    final dressedBook = Padding(
      padding: EdgeInsets.fromLTRB(10 * s, 0, 28 * s, 16 * s),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          book,
          // On the right edge, below the title, so it covers none of the lettering.
          Positioned(
            top: height * 0.5,
            right: -26 * s,
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                width: 64 * s,
                height: 64 * s,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3 * s),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10 * s,
                      offset: Offset(0, 4 * s),
                    ),
                  ],
                ),
                child: Text(
                  '42',
                  style: GoogleFonts.inter(
                    fontSize: 26 * s,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1 * s,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -10 * s,
            left: -10 * s,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 6 * s),
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(4 * s),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8 * s,
                      offset: Offset(0, 3 * s),
                    ),
                  ],
                ),
                child: Text(
                  'DON\'T PANIC',
                  style: GoogleFonts.inter(
                    fontSize: 11 * s,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.6 * s,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dressedBook,
        Padding(
          padding: EdgeInsets.fromLTRB(10 * s, 8 * s, 0, 0),
          child: SizedBox(
            width: width,
            child: Link(
              uri: _bookPage,
              target: LinkTarget.blank,
              builder: (context, followLink) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: followLink,
                  child: Text(
                    'Cover of The Hitchhiker\'s Guide to the Galaxy by Douglas Adams. '
                    '© the respective rights holders.',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.5,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// How a radio comedy turned 42 into a world-famous in-joke.
class _FameTimeline extends StatelessWidget {
  const _FameTimeline();

  static const _milestones = [
    ('1978', 'Radio', 'Starts life as a BBC Radio 4 comedy series.',
        'يبدأ كمسلسل إذاعي كوميدي على BBC Radio 4.'),
    ('1979', 'Novel', 'The book version becomes a bestseller.',
        'تصدر الرواية وتصبح من الأكثر مبيعاً.'),
    ('1981', 'Television', 'Adapted into a BBC TV series.',
        'تتحول إلى مسلسل تلفزيوني على BBC.'),
    ('1984', 'Game', 'An Infocom text adventure, co-written by Adams.',
        'لعبة مغامرات نصية من Infocom شارك آدامز في كتابتها.'),
    ('2005', 'Film', 'A Hollywood feature film brings it to a new generation.',
        'فيلم سينمائي يعرّف بها جيلاً جديداً.'),
    ('25 May', 'Towel Day', 'Fans worldwide celebrate Adams every year since 2001.',
        'يحتفي المعجبون حول العالم بآدامز كل عام منذ 2001.'),
  ];

  @override
  Widget build(BuildContext context) {
    final white70 = Colors.white.withValues(alpha: 0.75);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wrap drops the Arabic label to its own line on narrow screens.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 4,
          children: [
            Text(
              'HOW IT BECAME SO FAMOUS',
              style: GoogleFonts.inter(
                  fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 2, color: Colors.white),
            ),
            Text(
              'كيف اشتهرت',
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 24,
          children: [
            for (final (year, title, en, ar) in _milestones)
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 2, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(year,
                        style: GoogleFonts.inter(
                            fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
                    Text(title,
                        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(en, style: GoogleFonts.inter(fontSize: 12, color: white70, height: 1.5)),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(ar,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.tajawal(fontSize: 12, color: white70, height: 1.6)),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Along the way, 42 became a running joke among programmers and scientists: Google\'s '
          'calculator famously answered "the answer to life, the universe and everything" with 42. '
          'Adams later said there was no hidden meaning: he simply wanted an ordinary, smallish number.',
          style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withValues(alpha: 0.88), height: 1.7),
        ),
        const SizedBox(height: 8),
        Text(
          'ومع الوقت أصبح الرقم 42 نكتة متداولة بين المبرمجين والعلماء، حتى إن آلة Google الحاسبة '
          'كانت تجيب عن «جواب الحياة والكون وكل شيء» بالرقم 42. وقال آدامز لاحقاً إنه لا يحمل معنى '
          'خفياً، بل أراد رقماً عادياً صغيراً فحسب.',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(fontSize: 14, color: Colors.white.withValues(alpha: 0.85), height: 1.8),
        ),
      ],
    );
  }
}

// ── Info Section ──────────────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  const _InfoSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 800;
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 64,
      ),
      child: Column(
        children: [
          Text(
            'ABOUT THE PROJECT  /  عن المشروع',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _InfoCard(
                icon: Icons.menu_book_rounded,
                english: 'Bilingual Definitions',
                arabic: 'تعريفات ثنائية اللغة',
                description: 'Every term includes full English and Arabic definitions displayed simultaneously.',
                arabicDescription: 'كل مصطلح يتضمن تعريفاً كاملاً بالإنجليزية والعربية معاً.',
              ),
              _InfoCard(
                icon: Icons.sign_language_rounded,
                english: 'JSL Sign Videos',
                arabic: 'مقاطع الإشارة',
                description: 'Sign demonstrations in authentic Jordanian Sign Language.',
                arabicDescription: 'توضيحات الإشارة بلغة الإشارة الأردنية الأصيلة.',
              ),
              _InfoCard(
                icon: Icons.animation_rounded,
                english: 'Concept Animations',
                arabic: 'رسوم توضيحية',
                description: 'Manim-generated animations that visually explain each engineering concept.',
                arabicDescription: 'رسوم متحركة توضح كل مفهوم هندسي بصرياً.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String english;
  final String arabic;
  final String description;
  final String arabicDescription;

  const _InfoCard({
    required this.icon,
    required this.english,
    required this.arabic,
    required this.description,
    required this.arabicDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.blue, size: 32),
          const SizedBox(height: 16),
          Text(english,
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerRight,
            child: Text(arabic,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
          ),
          const SizedBox(height: 10),
          Text(description,
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(arabicDescription,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(fontSize: 13, color: AppColors.textSecondary, height: 1.6)),
          ),
        ],
      ),
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
          const LiuLogo(
            width: 44,
            variant: LiuLogoVariant.wordmark,
            color: Colors.white,
          ),
          Text(
            'A project by 1000 Hands  •  قاموس لغة الإشارة الأردنية للهندسة',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
