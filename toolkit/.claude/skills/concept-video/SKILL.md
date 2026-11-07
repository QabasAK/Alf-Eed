---
name: concept-video
description: Creates a short captioned Manim concept video for a lexicon term in the What, Why, Where format with Arabic and English captions. Use when asked to make, animate, render or fix a term's concept video.
---

# Concept video

Each term gets one silent video of about 15 seconds that explains the concept. It sits next
to the sign and never replaces it, so **never draw hands or depict a sign**.

Start from `scene_template.py` in this folder, which is a working example (prime number).
Copy it to `scenes/<term_id>_scene.py` and replace the content.

## The format

Three beats, each with its own caption and visual:

1. **What** is it? Show the thing itself.
2. **Why** does it matter? Show what goes wrong, or what it makes possible.
3. **Where** is it used? One everyday example that a first-year student already knows.

Write and show the three captions before animating anything. Getting these right is most of
the work.

## House style

- Black background, 1920 × 1080, 60 fps, no audio.
- Visuals sit above the divider line. The caption band sits below it: Arabic on top in white,
  English under it in light grey.
- Arabic starts `ما هو…؟` then `لماذا يهمّ؟` then `أين يُستخدم؟ مثال:`. English starts `What?`
  then `Why it matters?` then `Where?  Example:`.
- One accent colour per term. Green means good and red means bad, always paired with a label
  or a mark like ✓ or ✕, because colour alone isn't enough.
- Text never overlaps anything. Check by eye; nothing warns you.
- Hold each beat long enough to read. Viewers read everything, so roughly 4 to 5 seconds per
  beat is the minimum. Don't rush to hit 15 seconds.

## Rendering

```bash
manim -ql scenes/prime_number_scene.py PrimeNumberExplainer
manim -qh scenes/prime_number_scene.py PrimeNumberExplainer
```

The first is a quick draft and the second is the final 1080p60. Then copy the MP4 from
`media/videos/` to the term's `animation_path` and update `terms.csv`.

## Traps we hit

- **Don't name a scene file after a Python module.** A file called `signal.py` or `array.py`
  in the folder you run from breaks Manim's imports with a baffling `NameError`. That's why
  the template uses a `_scene.py` suffix.
- **Small text spaces badly.** Pango renders small letters unevenly. The template's `T()`
  helper renders text four times larger and scales it down. Always use it.
- **Arabic needs a font with Arabic glyphs.** The template names Arial. Pick another on a
  system without it, and look at the rendered frame: broken Arabic doesn't raise an error.

## Before you call it done

Extract a frame from each beat with ffmpeg and look at them. Check for clipped text, overlaps
and Arabic shaping. Facts in the video should match the term's definition in `terms.csv`, and
the Arabic captions need the same human review as the definitions.
