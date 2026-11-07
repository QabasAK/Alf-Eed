"""
"Prime number" (عدد أولي): a worked example of the What -> Why -> Where format.
Copy this file to scenes/<term_id>_scene.py and replace the captions and visuals.

Render:  manim -ql prime_number_scene.py PrimeNumberExplainer
         manim -qh prime_number_scene.py PrimeNumberExplainer   (final 1080p60)
"""

from manim import *

# Pango spaces letters badly at small font sizes: render text 4x larger and
# scale it back down so the kerning stays even.
_TEXT_SCALE = 4


def T(text: str, font_size: float = 24, **kwargs) -> Text:
    return Text(text, font_size=font_size * _TEXT_SCALE, **kwargs).scale(1 / _TEXT_SCALE)


ACCENT = "#90CAF9"  # one accent colour per term
GOOD, BAD = "#A5D6A7", "#EF9A9A"


def dot_grid(rows: int, cols: int, centre, gap: float = 0.34, color=ACCENT) -> VGroup:
    """rows x cols dots: a number that fills a rectangle has those two factors."""
    dots = VGroup(*[Dot(radius=0.11, color=color) for _ in range(rows * cols)])
    return dots.arrange_in_grid(rows=rows, cols=cols, buff=gap - 0.22).move_to(centre)


class PrimeNumberExplainer(Scene):
    def construct(self):
        # ── Layout constants ───────────────────────────────────────────
        sep_y = -1.75
        text_y = sep_y - 0.88
        divider = Line([-6.8, sep_y, 0], [6.8, sep_y, 0], color=DARK_GREY, stroke_width=1.2)

        def caption(ar_text: str, en_text: str) -> VGroup:
            a = T(ar_text, font="Arial", font_size=20, color=WHITE)
            e = T(en_text, font_size=13, color=LIGHT_GREY)
            return VGroup(a, e).arrange(DOWN, buff=0.12).move_to([0, text_y, 0])

        cap1 = caption(
            "ما هو العدد الأولي؟ عدد لا يقبل القسمة إلا على 1 وعلى نفسه",
            "What?  A whole number that only divides evenly by 1 and itself",
        )
        cap2 = caption(
            "لماذا يهمّ؟ كل عدد صحيح أكبر من 1 يتكوّن من أعداد أولية",
            "Why it matters?  Every whole number above 1 is built from primes",
        )
        cap3 = caption(
            "أين يُستخدم؟ مثال: أعداد أولية ضخمة تحمي مدفوعاتك عبر الإنترنت",
            "Where?  Example: huge primes help protect your online payments",
        )

        # ── 1 What: 6 fills a rectangle, 7 can't ───────────────────────
        six = dot_grid(2, 3, [-3.0, 0.75, 0])
        six_t = T("6 = 2 × 3", font_size=18, color=WHITE).move_to([-3.0, -0.2, 0])
        six_v = T("✕ not prime: it fills a rectangle", font_size=12, color=BAD).move_to([-3.0, -0.75, 0])
        seven = dot_grid(1, 7, [3.0, 0.75, 0], color=GOOD)
        seven_t = T("7", font_size=18, color=WHITE).move_to([3.0, -0.2, 0])
        seven_v = T("✓ prime: only a single row works", font_size=12, color=GOOD).move_to([3.0, -0.75, 0])

        self.play(FadeIn(divider), FadeIn(cap1), run_time=0.5)
        self.play(LaggedStart(*[GrowFromCenter(d) for d in six], lag_ratio=0.1), run_time=0.7)
        self.play(FadeIn(six_t), FadeIn(six_v), run_time=0.4)
        self.play(LaggedStart(*[GrowFromCenter(d) for d in seven], lag_ratio=0.1), run_time=0.8)
        self.play(FadeIn(seven_t), FadeIn(seven_v), run_time=0.4)
        self.wait(1.7)
        what = VGroup(six, six_t, six_v, seven, seven_t, seven_v)

        # ── 2 Why: every number breaks down into primes ────────────────
        rows = VGroup(
            T("12  =  2 × 2 × 3", font_size=22, color=WHITE),
            T("35  =  5 × 7", font_size=22, color=WHITE),
            T("57  =  3 × 19", font_size=22, color=ACCENT),
        ).arrange(DOWN, buff=0.34).move_to([0, 0.75, 0])
        note = T("Grothendieck's famous \"prime\" isn't one", font_size=12, color=GREY_B).move_to([0, -0.85, 0])

        self.play(FadeOut(what), FadeOut(cap1), FadeIn(cap2), run_time=0.5)
        self.play(LaggedStart(*[FadeIn(r, shift=UP * 0.15) for r in rows], lag_ratio=0.5), run_time=1.3)
        self.play(FadeIn(note), run_time=0.4)
        self.wait(2.0)

        # ── 3 Where: easy to multiply, very hard to undo ───────────────
        left = T("p × q", font_size=26, color=GOOD).move_to([-3.2, 0.7, 0])
        left_t = T("Multiplying is instant", font_size=12, color=GOOD).move_to([-3.2, 0.05, 0])
        right = T("? × ?", font_size=26, color=BAD).move_to([3.2, 0.7, 0])
        right_t = T("Splitting a huge result back is very hard", font_size=12, color=BAD).move_to([3.2, 0.05, 0])
        arrow = Arrow([-1.5, 0.7, 0], [1.5, 0.7, 0], color=ACCENT, buff=0)
        msg = T("Encryption such as RSA relies on that gap", font_size=12, color=LIGHT_GREY).move_to([0, -0.85, 0])

        self.play(FadeOut(rows), FadeOut(note), FadeOut(cap2), FadeIn(cap3), run_time=0.5)
        self.play(FadeIn(left), FadeIn(left_t), run_time=0.4)
        self.play(GrowArrow(arrow), run_time=0.5)
        self.play(FadeIn(right), FadeIn(right_t), run_time=0.4)
        self.play(FadeIn(msg), run_time=0.4)
        self.wait(2.2)
