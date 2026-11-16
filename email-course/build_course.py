"""Builds the 1000 Hands sign course: a spaced-repetition email course.

Fill in signs.csv (and, if you like, lessons.csv), then run:  python build_course.py

Each lesson teaches 3 new signs. Every sign comes back for review about 1, 3 and 7 weeks
after it was taught. One email goes out a week, and none asks you to recall more than
MAX_REVIEW old signs; reviews that don't fit move to the next week. After the last lesson,
review-only emails carry on until every sign has had all three reviews.

Output: emails/ has a preview of each email (open it in a browser). course-plan.html lists every
email, what it teaches, what it reviews, and what's still missing. apps-script/Code.gs is the
whole course plus sender.gs, ready to paste into Google Apps Script (see SETUP.txt).
"""
import base64, csv, gzip, html, json, os, random, re
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "emails")
UNSUBSCRIBE = "{{UNSUBSCRIBE}}"  # sender.gs swaps in each subscriber's own link
# Where the gifs/ folder is online, ending in "/". Email apps load the GIFs from here, so upload
# gifs/ there before sending. The previews in emails/ use the local gifs/ folder instead.
GIF_BASE = "https://thousand-hands-signs.pages.dev/"
GIFS = "{{GIFS}}/"  # swapped for GIF_BASE in the real emails and for ../gifs/ in the previews
REVIEW_AFTER = (1, 3, 7)  # weeks after a sign is taught (later if an email is already full)
MAX_REVIEW = 6  # most old signs one email asks you to recall

INK, PAPER, GRAPHITE, STONE_DEEP, RED = "#0B0B0C", "#F4F2EE", "#5E616B", "#DEDBD4", "#C62828"
FIELDS = [(42, "#2A44B5"), (57, "#C62F3B"), (17, "#6B3FA0"), (18, "#3F7D20"),
          (33, "#0B7A8C"), (28, "#A8246B"), (10, "#B4530F")]
FONT = "Arial,Helvetica,sans-serif"
CONTACT = "liu.thousandhands@gmail.com"


def read_csv(name):
    with open(os.path.join(HERE, name), encoding="utf-8-sig", newline="") as f:
        return [{k: (v or "").strip() for k, v in row.items()} for row in csv.DictReader(f)]


def slug(english):
    """'Thank you' -> 'thank-you': the sign's file name in videos/ and gifs/."""
    return re.sub(r"[^a-z0-9]+", "-", english.lower()).strip("-")


def gif(sign):
    """The sign's GIF address, or None if gifs/ doesn't have it yet."""
    name = slug(sign["english"]) + ".gif"
    return GIFS + name if os.path.exists(os.path.join(HERE, "gifs", name)) else None


def gif_link(sign, alt):
    """The GIF, linked to the sign's full video."""
    img = (f'<img src="{gif(sign)}" width="150" alt="{esc(alt)}" style="display:block;width:100%;max-width:150px;'
           f'height:auto;margin:0 auto;border-radius:6px;border:0">')
    return f'<a href="{esc(sign["video_url"])}">{img}</a>' if sign["video_url"] else img


def schedule(lessons, sizes):
    """Returns [(week, lesson_number or None, [(lesson taught, weeks ago), ...])] in send order.

    One email a week. Each email reviews at most MAX_REVIEW signs (sizes[lesson] signs per lesson),
    the most overdue first; the rest wait for next week's email. A sign's next review is counted
    from when it was actually reviewed, so a late review never squeezes the gap after it.
    After the last lesson, review-only emails go out on the weeks something is due.
    """
    n = len(lessons)
    waiting = [(w + REVIEW_AFTER[0], 0, w) for w in lessons]  # (due week, review number, lesson)
    emails, week = [], 1
    while week <= n or waiting:
        waiting.sort()
        picked, count = [], 0
        for item in list(waiting):
            due, k, taught = item
            if due > week or count + sizes[taught] > MAX_REVIEW:
                continue
            waiting.remove(item)
            picked.append((taught, week - taught))
            count += sizes[taught]
            if k + 1 < len(REVIEW_AFTER):
                waiting.append((week + REVIEW_AFTER[k + 1] - REVIEW_AFTER[k], k + 1, taught))
        if week <= n or picked:
            emails.append((week, week if week <= n else None, sorted(picked, key=lambda r: r[1])))
        week += 1
    return emails


# ── HTML (email-safe: tables and inline styles only) ─────────────────────────

def esc(s):
    return html.escape(s)


def missing(label):
    return (f'<span style="color:{RED};border:1px dashed {RED};padding:1px 5px;font-size:12px">'
            f'[{label}]</span>')


def stripe(height=5):
    cells = "".join(f'<td width="{c}" height="{height}" style="background:{col};font-size:0;line-height:0">&nbsp;</td>'
                    for c, col in FIELDS)
    return f'<table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse"><tr>{cells}</tr></table>'


def watch_button(url, label="▶ Watch"):
    if not url:
        return missing("ADD VIDEO LINK")
    return (f'<a href="{esc(url)}" style="display:inline-block;background:{INK};color:#fff;text-decoration:none;'
            f'font-weight:bold;font-size:13px;padding:7px 14px;border-radius:6px">{label}</a>')


def credits(signs):
    """One 'Signs from ...' line for the whole email, naming each source once."""
    names = []
    for s in signs:
        if not s["creator"]:
            name = missing("ADD CREDIT")
        elif s["creator_url"]:
            name = f'<a href="{esc(s["creator_url"])}" style="color:{GRAPHITE}">{esc(s["creator"])}</a>'
        else:
            name = esc(s["creator"])
        if name not in names:
            names.append(name)
    return f'<div style="font-size:12px;color:{GRAPHITE};margin-top:8px">Signs from {", ".join(names)}</div>'


def grid(cells, per_row=3):
    """Lays cells out side by side, per_row to a row (tables, so it holds up in email apps)."""
    rows = []
    for i in range(0, len(cells), per_row):
        row = cells[i:i + per_row]
        row += ['<td width="33%"></td>'] * (per_row - len(row))
        rows.append(f'<tr>{"".join(row)}</tr>')
    return f'<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:6px">{"".join(rows)}</table>'


def section(title, title_ar, body):
    return (f'<tr><td style="padding:18px 28px 0"><div style="font-size:11px;font-weight:bold;letter-spacing:2px;'
            f'color:{GRAPHITE}">{title} &nbsp;<span dir="rtl" style="letter-spacing:0;font-size:13px">{title_ar}</span>'
            f'</div>{body}</td></tr>')


def email_html(subject, preview, heading, heading_ar, intro, new, reviews, note):
    parts = []
    if new:
        tiles = [f'<td width="33%" valign="top" style="padding:4px"><table width="100%" cellpadding="0" cellspacing="0" '
                 f'style="border:1px solid {STONE_DEEP};border-radius:8px"><tr><td align="center" style="padding:8px 6px 12px">'
                 + (f'{gif_link(s, "Sign for " + s["english"])}<div style="font-size:16px;font-weight:bold;margin-top:8px">'
                    if gif(s) else '<div style="font-size:16px;font-weight:bold;margin-top:4px">')
                 + f'{esc(s["english"])}</div><div dir="rtl" style="font-size:15px;margin-top:2px">{esc(s["arabic"])}</div>'
                 + ('' if gif(s) else f'<div style="margin-top:10px">{watch_button(s["video_url"])}</div>')
                 + '</td></tr></table></td>' for s in new]
        parts.append(section("NEW SIGNS", "إشارات جديدة", grid(tiles) + credits(new)))
    if reviews:
        # The alt text is just the number, so a blocked image doesn't give the answer away.
        tiles = [f'<td width="33%" valign="top" align="center" style="padding:4px">{gif_link(s, f"Sign {i}")}'
                 f'<div style="font-size:14px;font-weight:bold;margin-top:4px">{i}</div></td>'
                 if gif(s) else
                 f'<td width="33%" style="padding:4px"><a href="{esc(s["video_url"])}" style="display:block;'
                 f'border:1px solid {INK};border-radius:6px;padding:8px 0;text-align:center;color:{INK};'
                 f'text-decoration:none;font-size:14px;font-weight:bold">{i} &nbsp;▶</a></td>'
                 if s["video_url"] else f'<td width="33%" style="padding:4px">{missing("ADD VIDEO LINK")}</td>'
                 for i, (s, _) in enumerate(reviews, 1)]
        parts.append(section("DO YOU REMEMBER?", "هل تتذكر؟",
                             f'<div style="font-size:14px;margin-top:6px">Watch each one and say what it means. '
                             f'Answers at the bottom.</div>{grid(tiles)}'))
    parts.append(f'<tr><td style="padding:18px 28px 0"><div style="background:{PAPER};border-radius:8px;padding:14px 16px">'
                 f'<div style="font-size:11px;font-weight:bold;letter-spacing:2px;color:{GRAPHITE}">DEAF CULTURE &nbsp;'
                 f'<span dir="rtl" style="letter-spacing:0;font-size:13px">ثقافة الصم</span></div>'
                 f'<div style="font-size:14px;margin-top:6px;line-height:1.5">'
                 f'{esc(note) if note else missing("ADD A NOTE, CHECKED BY A DEAF ADVISOR")}</div></div></td></tr>')
    if reviews:
        # Same grid as the review buttons, so each answer sits where its question did.
        answers = grid([f'<td width="33%" valign="top" style="padding:4px;font-size:13px;line-height:1.4">'
                        f'<b>{i}</b> {esc(s["english"])}<br><span dir="rtl">{esc(s["arabic"])}</span></td>'
                        for i, (s, _) in enumerate(reviews, 1)])
        # A gap first, so the answers aren't on screen while you test yourself.
        parts.append(f'<tr><td style="height:90px;font-size:12px;color:{GRAPHITE};text-align:center;'
                     f'vertical-align:bottom">↓ answers ↓</td></tr>')
        parts.append(f'<tr><td style="padding:6px 28px 0;color:{GRAPHITE}">{answers}</td></tr>')

    return f"""<!doctype html><html><head><meta charset="utf-8"><title>{esc(subject)}</title></head>
<body style="margin:0;background:{PAPER};font-family:{FONT};color:{INK}">
<div style="display:none;max-height:0;overflow:hidden">{esc(preview)}</div>
<table width="100%" cellpadding="0" cellspacing="0" style="background:{PAPER}"><tr><td align="center" style="padding:24px 12px">
<table width="560" cellpadding="0" cellspacing="0" style="max-width:560px;width:100%;background:#fff;border-radius:10px;overflow:hidden">
  <tr><td>{stripe()}</td></tr>
  <tr><td style="padding:16px 28px 0;font-size:12px;color:{GRAPHITE}"><b style="color:{INK}">1000 Hands · الف ايد</b>
    &nbsp;·&nbsp; Learn Jordanian Sign Language in 5 minutes</td></tr>
  <tr><td style="padding:14px 28px 0"><div style="font-size:24px;font-weight:900;line-height:1.2">{esc(heading)}
    &nbsp;<span dir="rtl" style="font-size:19px;font-weight:bold">{esc(heading_ar)}</span></div>
    <div style="font-size:14px;margin-top:8px;line-height:1.5">{intro}</div></td></tr>
  {"".join(parts)}
  <tr><td style="padding:24px 28px 20px;font-size:12px;color:{GRAPHITE};line-height:1.5">
    Questions, or want to sign for us? Reply, or write to <a href="mailto:{CONTACT}" style="color:{INK}">{CONTACT}</a>.<br>
    <a href="{UNSUBSCRIBE}" style="color:{GRAPHITE}">Unsubscribe</a>
  </td></tr>
  <tr><td>{stripe(4)}</td></tr>
</table></td></tr></table></body></html>"""



# ── Build ────────────────────────────────────────────────────────────────────

def main():
    signs = read_csv("signs.csv")
    notes = {int(r["lesson"]): r["culture_note"] for r in read_csv("lessons.csv") if r["lesson"]}
    by_lesson = defaultdict(list)
    for s in signs:
        by_lesson[int(s["lesson"])].append(s)
    lessons = sorted(by_lesson)
    assert lessons == list(range(1, len(lessons) + 1)), "lesson numbers in signs.csv must run 1, 2, 3, ... with no gaps"

    os.makedirs(OUT, exist_ok=True)
    for f in os.listdir(OUT):
        os.remove(os.path.join(OUT, f))

    plan, prev_week, todo, sends = [], 0, set(), []
    emails = schedule(lessons, {n: len(by_lesson[n]) for n in lessons})
    for i, (week, lesson, due) in enumerate(emails, 1):
        reviews = [(s, gap) for taught, gap in due for s in by_lesson[taught]]
        # Mixed up so the order doesn't give the answers away; seeded so rebuilds don't change it.
        random.Random(i).shuffle(reviews)
        if lesson:
            new, first = by_lesson[lesson], by_lesson[lesson][0]
            heading, heading_ar = f"Lesson {lesson} · {first['theme']}", first["theme_ar"]
            count = {3: "Three", 4: "Four"}.get(len(new), str(len(new)))
            subject = f"Lesson {lesson}: {first['theme']} · {len(new)} signs, 5 minutes"
            preview = f"{count} new signs" + (f", and {len(reviews)} to review." if reviews else ".")
            intro = f"{count} new signs this week. Watch each one a few times and copy it with your hands."
            name = f"{i:02d}-lesson-{lesson}"
        else:
            new = []
            heading, heading_ar = "Review week", "أسبوع المراجعة"
            subject = f"Review: keep {len(reviews)} signs fresh"
            preview = "No new signs this time. Just a quick test of what you know."
            intro = "No new signs this time. Spacing out your practice like this is what makes signs stick."
            name = f"{i:02d}-review"
        note = notes.get(lesson, "") if lesson else ""
        body = email_html(subject, preview, heading, heading_ar, intro, new, reviews, note)
        open(os.path.join(OUT, name + ".html"), "w", encoding="utf-8").write(
            body.replace(UNSUBSCRIBE, "#").replace(GIFS, "../gifs/"))
        sends.append({"day": (week - 1) * 7, "subject": subject, "html": body.replace(GIFS, GIF_BASE)})

        for s in new:
            if not s["video_url"]:
                todo.add((lesson, f"Video link: {s['english']}"))
            if not s["creator"]:
                todo.add((lesson, f"Credit: {s['english']}"))
        if not note and lesson:
            todo.add((lesson, "Deaf culture note"))
        if GIFS in body and not GIF_BASE:
            todo.add((0, "Upload gifs/ online and set GIF_BASE in build_course.py"))
        review_desc = ", ".join(f"lesson {t} ({g} wk ago)" for t, g in due) or "—"
        plan.append((i, week, week - prev_week, name, subject,
                     ", ".join(s["english"] for s in new) or "—", review_desc))
        prev_week = week

    rows = "".join(
        f'<tr><td>{i}</td><td>{w}</td><td>{"at signup" if i == 1 else f"{g} week" + ("s" if g > 1 else "")}</td>'
        f'<td><a href="emails/{n}.html">{esc(subj)}</a></td><td>{esc(new)}</td><td>{esc(rev)}</td></tr>'
        for i, w, g, n, subj, new, rev in plan)
    todo_html = "".join(f"<li>{f'Lesson {n}' if n else 'All emails'}: {esc(t)}</li>" for n, t in sorted(todo)) or "<li>Nothing. Ready to paste into Apps Script.</li>"
    open(os.path.join(HERE, "course-plan.html"), "w", encoding="utf-8").write(f"""<!doctype html><html><head>
<meta charset="utf-8"><title>Sign course plan</title><style>
body{{font-family:{FONT};background:{PAPER};color:{INK};margin:0;padding:28px}} h1{{margin:0 0 4px}}
table{{border-collapse:collapse;background:#fff;width:100%;margin-top:16px}} td,th{{border:1px solid {STONE_DEEP};padding:7px 9px;
text-align:left;font-size:14px;vertical-align:top}} th{{background:{INK};color:#fff}} .sub{{color:{GRAPHITE}}}
</style></head><body><h1>1000 Hands sign course</h1>
<div class="sub">{len(emails)} emails over {emails[-1][0]} weeks · {len(signs)} signs · each sign reviewed
{", ".join(str(g) for g in REVIEW_AFTER)} weeks after it's taught</div>
<table><tr><th>#</th><th>Week</th><th>Wait before it</th><th>Email (click to preview)</th><th>New signs</th><th>Reviews</th></tr>
{rows}</table><h2>Still missing ({len(todo)})</h2><ul>{todo_html}</ul></body></html>""")
    os.makedirs(os.path.join(HERE, "apps-script"), exist_ok=True)
    sender = open(os.path.join(HERE, "sender.gs"), encoding="utf-8").read()
    # The emails are gzipped and base64'd: the same HTML styling repeats in every email, so this
    # makes Code.gs about a tenth the size. Apps Script unzips it each time the script runs.
    packed = base64.b64encode(gzip.compress(json.dumps(sends, ensure_ascii=False).encode("utf-8"), mtime=0))
    lines = "\n".join(f"  '{packed[i:i + 100].decode()}' +" for i in range(0, len(packed), 100))
    open(os.path.join(HERE, "apps-script", "Code.gs"), "w", encoding="utf-8").write(
        "// Generated by build_course.py. Don't edit here: change signs.csv, lessons.csv or sender.gs and rebuild.\n"
        "// EMAILS is every email in the course (day, subject, html), compressed. Preview them in emails/.\n\n"
        f"const EMAILS = JSON.parse(Utilities.ungzip(Utilities.newBlob(Utilities.base64Decode(\n{lines}\n  ''),\n"
        "  'application/x-gzip')).getDataAsString('UTF-8'));\n\n"
        f"{sender}")
    print(f"{len(emails)} emails over {emails[-1][0]} weeks; {len(todo)} items still missing. Open course-plan.html.")


if __name__ == "__main__":
    main()
