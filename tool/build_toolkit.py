"""Packs toolkit/ into the zip behind the site's download button.

Run from anywhere, then rebuild the site:  python tool/build_toolkit.py
"""

import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / "toolkit"
OUTPUT = ROOT / "web" / "toolkit" / "1000-hands-toolkit.zip"
FOLDER = "1000-hands-toolkit"


def main() -> None:
    OUTPUT.parent.mkdir(exist_ok=True)
    files = sorted(p for p in SOURCE.rglob("*") if p.is_file() and "__pycache__" not in p.parts)
    with zipfile.ZipFile(OUTPUT, "w", zipfile.ZIP_DEFLATED) as archive:
        for path in files:
            archive.write(path, f"{FOLDER}/{path.relative_to(SOURCE).as_posix()}")
    print(f"{OUTPUT.relative_to(ROOT)}: {len(files)} files, {OUTPUT.stat().st_size / 1024:.1f} KB")


if __name__ == "__main__":
    main()
