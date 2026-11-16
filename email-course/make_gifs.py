"""Turns the sign videos in videos/ into small looping GIFs in gifs/, for the emails.

Name each video after its sign's English name in signs.csv, lower case, with dashes for spaces
and no punctuation: "Thank you" -> videos/thank-you.mp4, "What?" -> videos/what.mp4.
Then run:  python make_gifs.py   (needs ffmpeg), and then  python build_course.py

Each GIF is cropped to 4:3 around the signer, 240 px wide, 10 frames a second, about 100-200 KB.
"""
import os, subprocess
from build_course import HERE, read_csv, slug

VIDEOS, GIFS = os.path.join(HERE, "videos"), os.path.join(HERE, "gifs")
# 32 colours and no dithering: the plain background compresses well and the signer stays clear.
FILTER = ("crop='min(iw,ih*4/3)':ih,fps=10,scale=240:-2:flags=lanczos,"
          "split[a][b];[a]palettegen=max_colors=32:stats_mode=diff[p];[b][p]paletteuse=dither=none:diff_mode=rectangle")


def main():
    os.makedirs(GIFS, exist_ok=True)
    have = {os.path.splitext(f)[0]: f for f in os.listdir(VIDEOS)} if os.path.isdir(VIDEOS) else {}
    missing = []
    for s in read_csv("signs.csv"):
        name = slug(s["english"])
        if name not in have:
            missing.append(f'{s["english"]} (videos/{name}.mp4)')
            continue
        out = os.path.join(GIFS, name + ".gif")
        subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", os.path.join(VIDEOS, have[name]), "-vf", FILTER, out],
                       check=True)
        print(f"{name}.gif  {os.path.getsize(out) // 1024} KB")
    if missing:
        print("No video yet for:\n  " + "\n  ".join(missing))


if __name__ == "__main__":
    main()
