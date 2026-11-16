"""Turns the fingerspelling clips in letter-clips/ into the GIFs behind "Sign your name".

Save each letter's clip or photo into letter-clips/, named after the letter ("ب.mp4",
"ب.jpg"); SooSL's own file names work too ("012-ب_id1234.mp4"). Photos become still cards
until proper clips replace them. Then run
    python tool/make_letter_gifs.py      (needs ffmpeg)
and rebuild the site. Letters without a clip keep showing the plain letter card.
"""

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CLIPS = ROOT / "letter-clips"
GIFS = ROOT / "assets" / "letters"

# Same table as lib/data/letters.dart: change both together.
SLUGS = {
    "ا": "alif", "ب": "ba", "ت": "ta", "ث": "tha", "ج": "jim", "ح": "hha", "خ": "kha",
    "د": "dal", "ذ": "dhal", "ر": "ra", "ز": "zay", "س": "sin", "ش": "shin", "ص": "sad",
    "ض": "dad", "ط": "taa", "ظ": "zaa", "ع": "ayn", "غ": "ghayn", "ف": "fa", "ق": "qaf",
    "ك": "kaf", "ل": "lam", "م": "mim", "ن": "nun", "ه": "ha", "و": "waw", "ي": "ya",
    "ة": "ta-marbuta", "ء": "hamza", "أ": "alif-hamza", "إ": "alif-hamza-below",
    "ؤ": "waw-hamza", "ئ": "ya-hamza",
}

# Square crop around the signer, 208 px (the card's 104 px at 2x), 10 frames a second.
# Same palette settings as email-course/make_gifs.py: few colours, no dithering.
FILTER = ("crop='min(iw,ih)':'min(iw,ih)',fps=10,scale=208:208:flags=lanczos,"
          "split[a][b];[a]palettegen=max_colors=32:stats_mode=diff[p];[b][p]paletteuse=dither=none:diff_mode=rectangle")
# Photos have busy backgrounds and skin tones, so they get the full 256 colours.
PHOTO_FILTER = ("crop='min(iw,ih)':'min(iw,ih)',scale=208:208:flags=lanczos,"
                "split[a][b];[a]palettegen[p];[b][p]paletteuse")
VIDEO = {".mp4", ".mov", ".webm"}
PHOTO = {".jpg", ".jpeg", ".png", ".webp"}


def letter_of(clip: Path) -> str | None:
    """The letter a clip shows, from "012-ب_id1234.mp4" or "ب.mp4"."""
    name = re.sub(r"^\d+-", "", clip.stem.split("_id")[0]).strip()
    return name if name in SLUGS else None


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8")  # Windows consoles default to cp1252, which has no Arabic.
    GIFS.mkdir(parents=True, exist_ok=True)
    clips = sorted(f for f in CLIPS.iterdir() if f.suffix.lower() in VIDEO | PHOTO) if CLIPS.is_dir() else []
    done, unknown = set(), []
    for clip in clips:
        letter = letter_of(clip)
        if letter is None:
            unknown.append(clip.name)
            continue
        out = GIFS / f"{SLUGS[letter]}.gif"
        vf = PHOTO_FILTER if clip.suffix.lower() in PHOTO else FILTER
        subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", str(clip), "-vf", vf, str(out)], check=True)
        done.add(letter)
        print(f"{letter}  {out.name}  {out.stat().st_size // 1024} KB")
    if unknown:
        print("Couldn't tell which letter these are (rename them to the letter, e.g. ب.mp4):\n  " + "\n  ".join(unknown))
    missing = [letter for letter in SLUGS if letter not in done and not (GIFS / f"{SLUGS[letter]}.gif").exists()]
    if missing:
        print("No clip yet for: " + " ".join(missing))


if __name__ == "__main__":
    assert letter_of(Path("012-ب_id1234.mp4")) == "ب"
    assert letter_of(Path("ة.mp4")) == "ة"
    assert letter_of(Path("ب.jpg")) == "ب"
    assert letter_of(Path("005-المواسع_id1177.mp4")) is None
    main()
