"""Cuts the hand drawings out of alphabet screenshots, onto a transparent background.

Each screenshot shows the letter on the left and its handshape on an orange card on the
right. This keeps only the hand (and any motion arrow), so the site's field-coloured
cards show through. Name each screenshot after its letter ("ب.png"), then run
    python tool/cut_letter_drawings.py "C:/path/to/Arabic Alphabet"
and rebuild the site. Output: assets/letters/<slug>.png, 416 px square.
"""

import sys
from pathlib import Path

import numpy as np
from PIL import Image

sys.path.insert(0, str(Path(__file__).resolve().parent))
from make_letter_gifs import GIFS as OUT, SLUGS  # noqa: E402  same letter table and folder

SIZE = 416  # The card's 104 px handshape box at 4x, so it stays sharp on big screens.


def orange_mask(rgb: np.ndarray) -> np.ndarray:
    r, g, b = (rgb[..., i].astype(int) for i in range(3))
    return (r > 200) & (g > 90) & (g < 190) & (b < 120) & (r - g > 50)


def cut(path: Path) -> Image.Image:
    rgb = np.asarray(Image.open(path).convert("RGB"))
    h, w, _ = rgb.shape
    mask = orange_mask(rgb)
    # The orange card is in the right half; the thin coloured bars along the edges are not it.
    mask[:, : w // 2] = False
    mask[: h // 10] = False
    mask[-h // 10 :] = False
    # Rows and columns that are mostly card: the channel logo's few orange pixels don't count.
    rows = np.nonzero(mask.sum(1) > 0.3 * mask.sum(1).max())[0]
    cols = np.nonzero(mask.sum(0) > 0.3 * mask.sum(0).max())[0]
    inset = max(3, (rows[-1] - rows[0]) // 100)  # Skip the card's light edge and shadow.
    top, bottom, left, right = rows[0] + inset, rows[-1] + 1 - inset, cols[0] + inset, cols[-1] + 1 - inset
    card = rgb[top:bottom, left:right].astype(float)
    ch, cw, _ = card.shape

    # Alpha from how far each pixel is from the card's orange: orange vanishes, the drawing stays.
    orange = np.median(card[orange_mask(card.astype(np.uint8))], axis=0)
    dist = np.linalg.norm(card - orange, axis=2)
    alpha = np.clip((dist - 30) / 80, 0, 1)

    # Drop the white corners outside the card's rounded rectangle.
    radius = 0.09 * min(ch, cw)
    yy, xx = np.mgrid[0:ch, 0:cw]
    dx = np.maximum(np.maximum(radius - xx, xx - (cw - 1 - radius)), 0)
    dy = np.maximum(np.maximum(radius - yy, yy - (ch - 1 - radius)), 0)
    alpha[np.hypot(dx, dy) > radius] = 0

    # Edge pixels are half orange: draw them as the black outline, or they leave an orange fringe.
    rgba = np.dstack([card, alpha * 255]).astype(np.uint8)
    fringe = (alpha > 0) & (alpha < 1)
    rgba[fringe, :3] = 0

    img = Image.fromarray(rgba, "RGBA")
    img = img.crop(img.getbbox())
    side = max(img.size)
    square = Image.new("RGBA", (side, side))
    square.paste(img, ((side - img.width) // 2, side - img.height))  # Wrists sit on the bottom edge.
    return square.resize((SIZE, SIZE), Image.LANCZOS)


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8")
    source = Path(sys.argv[1])
    OUT.mkdir(parents=True, exist_ok=True)
    done = []
    for path in sorted(source.glob("*.png")):
        letter = path.stem.strip()
        if letter not in SLUGS:
            print(f"Skipped {path.name}: not a letter in the table")
            continue
        cut(path).save(OUT / f"{SLUGS[letter]}.png", optimize=True)
        done.append(letter)
    # Plain alif has the same handshape as alif with hamza; the screenshots only show the latter.
    if "ا" not in done and "أ" in done:
        (OUT / f"{SLUGS['ا']}.png").write_bytes((OUT / f"{SLUGS['أ']}.png").read_bytes())
        done.append("ا")
    print(f"Cut {len(done)}: {' '.join(done)}")
    missing = [letter for letter in SLUGS if letter not in done]
    if missing:
        print("No drawing for: " + " ".join(missing))


if __name__ == "__main__":
    main()
