"""Builds the 1000 Hands sign course: a spaced-repetition email course.

Fill in signs.csv (and, if you like, lessons.csv), then run:  python build_course.py

Each email teaches ONE new sign, and one goes out every SEND_EVERY days. Every sign comes back
for a quick check REVIEW_AFTER emails later (about 1, 2 and 5 weeks). No email checks more than
MAX_REVIEW old signs; checks that don't fit move to the next email. After the last sign,
practice-only emails carry on until every sign has had all its checks.

A check shows the word and asks you to sign it, then shows the GIF lower down to compare.

Output: emails/ has a preview of each email (open it in a browser). course-plan.html lists every
email, what it teaches, what it checks, and what's still missing. apps-script/Code.gs is the
whole course plus sender.gs, ready to paste into Google Apps Script (see SETUP.txt).
"""
import base64, csv, gzip, html, json, os, re
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "emails")
UNSUBSCRIBE = "{{UNSUBSCRIBE}}"  # sender.gs swaps in each subscriber's own link
# Where the gifs/ folder is online, ending in "/". Email apps load the GIFs from here, so upload
# gifs/ there before sending. The previews in emails/ use the local gifs/ folder instead.
GIF_BASE = "https://thousand-hands-signs.pages.dev/"
GIFS = "{{GIFS}}/"  # swapped for GIF_BASE in the real emails and for ../gifs/ in the previews
SEND_EVERY = 3  # days between emails
REVIEW_AFTER = (2, 5, 12)  # emails after a sign is taught (later if an email is already full)
MAX_REVIEW = 2  # most old signs one email asks you to recall
MAX_PRACTICE = 3  # same, for the practice-only emails after the last sign

# The 1000 Hands site (Alf-Eed, lib/theme/app_colors.dart): white page, ink type, field stripes.
INK, GRAPHITE, HAIRLINE, SOFT, RED = "#0B0B0C", "#5C5C62", "#E5E5E5", "#F6F6F6", "#C62828"
FIELDS = [(42, "#2A44B5"), (57, "#C62F3B"), (17, "#6B3FA0"), (18, "#3F7D20"),
          (33, "#0B7A8C"), (28, "#A8246B"), (10, "#B4530F")]
FONT = "Inter,Tajawal,Arial,Helvetica,sans-serif"
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


def gif_link(sign, width):
    """The GIF (240 px wide, so never shown bigger), linked to the sign's full video."""
    if not gif(sign):
        return watch_button(sign["video_url"])
    img = (f'<img src="{gif(sign)}" width="{width}" alt="Sign for {esc(sign["english"])}" style="display:block;'
           f'width:100%;max-width:{width}px;height:auto;margin:0 auto;border-radius:10px;border:0">')
    return f'<a href="{esc(sign["video_url"])}">{img}</a>' if sign["video_url"] else img


def schedule(n):
    """Returns [(slot, sign index or None, [signs to check])] in send order; slot k goes out on day (k-1)*SEND_EVERY.

    Sign i is taught in slot i. Each email checks at most MAX_REVIEW old signs, the most overdue
    first (MAX_PRACTICE once there are no new signs); the rest wait for the next email. A sign's next check is counted from when it was
    actually checked, so a late check never squeezes the gap after it.
    """
    waiting = [(i + REVIEW_AFTER[0], 0, i) for i in range(1, n + 1)]  # (due slot, check number, sign)
    emails, slot = [], 1
    while slot <= n or waiting:
        waiting.sort()
        picked = []
        for item in list(waiting):
            due, k, taught = item
            if due > slot or len(picked) >= (MAX_REVIEW if slot <= n else MAX_PRACTICE):
                continue
            waiting.remove(item)
            picked.append(taught)
            if k + 1 < len(REVIEW_AFTER):
                waiting.append((slot + REVIEW_AFTER[k + 1] - REVIEW_AFTER[k], k + 1, taught))
        if slot <= n or picked:
            emails.append((slot, slot if slot <= n else None, picked))
        slot += 1
    return emails


# ── HTML (email-safe: tables and inline styles only, one column so it reads well on a phone) ──

def esc(s):
    return html.escape(s)


def missing(label):
    return (f'<span style="color:{RED};border:1px dashed {RED};padding:1px 5px;font-size:12px">'
            f'[{label}]</span>')


def stripe(height=6):
    cells = "".join(f'<td width="{c}" height="{height}" style="background:{col};font-size:0;line-height:0">&nbsp;</td>'
                    for c, col in FIELDS)
    return f'<table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse"><tr>{cells}</tr></table>'


def watch_button(url, label="▶ Watch the sign"):
    if not url:
        return missing("ADD VIDEO LINK")
    return (f'<a href="{esc(url)}" style="display:inline-block;background:{INK};color:#fff;text-decoration:none;'
            f'font-weight:bold;font-size:14px;padding:10px 20px;border-radius:999px">{label}</a>')


def label(en, ar):
    return (f'<div style="font-size:11px;font-weight:bold;letter-spacing:2px;color:{GRAPHITE}">{en} &nbsp;'
            f'<span dir="rtl" style="letter-spacing:0;font-size:13px">{ar}</span></div>')


def row(content, top=28):
    return f'<tr><td style="padding:{top}px 24px 0">{content}</td></tr>'


def credit(sign):
    if not sign["creator"]:
        return missing("ADD CREDIT")
    if sign["creator_url"]:
        return f'<a href="{esc(sign["creator_url"])}" style="color:{GRAPHITE}">{esc(sign["creator"])}</a>'
    return esc(sign["creator"])


def title(kicker, english, arabic):
    return (f'<div style="font-size:12px;color:{GRAPHITE}">{kicker}</div>'
            f'<div style="font-size:34px;font-weight:900;line-height:1.1;margin-top:6px">{esc(english)}</div>'
            f'<div dir="rtl" style="font-size:26px;font-weight:bold;margin-top:2px;text-align:left">{esc(arabic)}</div>')


def email_html(subject, preview, kicker, new, checks, note):
    if new:
        parts = [row(title(kicker, new["english"], new["arabic"])
                     + f'<div style="margin-top:18px;text-align:center">{gif_link(new, 240)}</div>'
                     f'<div style="font-size:15px;line-height:1.5;margin-top:16px">Watch it a few times, then copy it '
                     f'with your hands. Say the word as you sign it.</div>', 20)]
    else:
        parts = [row(title(kicker, "Practice day", "يوم المراجعة")
                     + f'<div style="font-size:15px;line-height:1.5;margin-top:12px">No new sign today. Coming back to '
                     f'a sign just as you start to forget it is what makes it stick.</div>', 20)]
    if checks:
        # Active recall: the word first, the GIF further down to compare against.
        asks = "".join(f'<div style="font-size:22px;font-weight:900;margin-top:10px">{esc(s["english"])} &nbsp;'
                       f'<span dir="rtl" style="font-size:19px;font-weight:bold">{esc(s["arabic"])}</span></div>'
                       for s in checks)
        parts.append(row(f'<div style="border-top:1px solid {HAIRLINE};padding-top:24px">{label("QUICK CHECK", "اختبر نفسك")}'
                         f'<div style="font-size:15px;line-height:1.5;margin-top:8px">Can you sign '
                         f'{"this" if len(checks) == 1 else "these"} from memory? Try first, then scroll down to check.'
                         f'</div>{asks}</div>'))
    if note:
        parts.append(row(f'<div style="background:{SOFT};border-radius:12px;padding:16px 18px">{label("DEAF CULTURE", "ثقافة الصم")}'
                         f'<div style="font-size:14px;margin-top:8px;line-height:1.55">{esc(note)}</div></div>'))
    if checks:
        # A gap first, so the answers aren't on screen while you try.
        parts.append(f'<tr><td style="height:140px;font-size:12px;color:{GRAPHITE};text-align:center;'
                     f'vertical-align:bottom">↓ check yourself ↓</td></tr>')
        parts += [row(f'<div style="text-align:center">{gif_link(s, 200)}<div style="font-size:14px;font-weight:bold;'
                      f'margin-top:6px">{esc(s["english"])} · <span dir="rtl">{esc(s["arabic"])}</span></div></div>', 16)
                  for s in checks]

    first = new or checks[0]
    return f"""<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{esc(subject)}</title></head>
<body style="margin:0;background:#fff;font-family:{FONT};color:{INK}">
<div style="display:none;max-height:0;overflow:hidden">{esc(preview)}</div>
<table width="100%" cellpadding="0" cellspacing="0" style="background:#fff"><tr><td align="center">
<table width="480" cellpadding="0" cellspacing="0" style="max-width:480px;width:100%;background:#fff">
  <tr><td>{stripe()}</td></tr>
  <tr><td style="padding:16px 24px 0;font-size:15px;font-weight:900">1000 Hands &nbsp;<span dir="rtl">الف ايد</span></td></tr>
  {"".join(parts)}
  <tr><td style="padding:36px 24px 24px;font-size:12px;color:{GRAPHITE};line-height:1.6">
    Signs from {credit(first)}. Tap a sign to watch the full video.<br>
    Questions, or want to sign for us? Just reply, or write to <a href="mailto:{CONTACT}" style="color:{GRAPHITE}">{CONTACT}</a>.<br>
    <a href="{UNSUBSCRIBE}" style="color:{GRAPHITE}">Unsubscribe</a>
  </td></tr>
  <tr><td>{stripe(4)}</td></tr>
</table></td></tr></table></body></html>"""



# ── Build ────────────────────────────────────────────────────────────────────

def main():
    signs = read_csv("signs.csv")
    notes = {int(r["lesson"]): r["culture_note"] for r in read_csv("lessons.csv") if r["lesson"]}
    order = [int(s["lesson"]) for s in signs]
    assert order == sorted(order), "signs.csv must be in lesson order"

    os.makedirs(OUT, exist_ok=True)
    for f in os.listdir(OUT):
        os.remove(os.path.join(OUT, f))

    plan, todo, sends = [], set(), []
    emails = schedule(len(signs))
    for i, (slot, taught, due) in enumerate(emails, 1):
        day = (slot - 1) * SEND_EVERY
        checks = [signs[t - 1] for t in due]
        new = signs[taught - 1] if taught else None
        note = ""
        if new:
            # Each theme's culture note comes with its first sign.
            if taught == 1 or signs[taught - 2]["lesson"] != new["lesson"]:
                note = notes.get(int(new["lesson"]), "")
            kicker = f"Sign {taught} of {len(signs)} · {esc(new['theme'])}"
            subject = f"{new['english']} · {new['arabic']} (sign {taught} of {len(signs)})"
            preview = "One new sign, one minute." + (" Plus a quick check." if checks else "")
            name = f"{i:02d}-sign-{taught}-{slug(new['english'])}"
            if not new["video_url"]:
                todo.add((taught, f"Video link: {new['english']}"))
            if not new["creator"]:
                todo.add((taught, f"Credit: {new['english']}"))
        else:
            kicker = f"Day {day + 1}"
            subject = f"Practice day: can you still sign {checks[0]['english']}?"
            preview = "No new sign today. Just a one-minute check."
            name = f"{i:02d}-practice"
        body = email_html(subject, preview, kicker, new, checks, note)
        open(os.path.join(OUT, name + ".html"), "w", encoding="utf-8").write(
            body.replace(UNSUBSCRIBE, "#").replace(GIFS, "../gifs/"))
        sends.append({"day": day, "subject": subject, "html": body.replace(GIFS, GIF_BASE)})
        plan.append((i, day, name, subject, new["english"] if new else "—",
                     ", ".join(s["english"] for s in checks) or "—"))

    rows = "".join(
        f'<tr><td>{i}</td><td>{"at signup" if d == 0 else d}</td>'
        f'<td><a href="emails/{n}.html">{esc(subj)}</a></td><td>{esc(new)}</td><td>{esc(rev)}</td></tr>'
        for i, d, n, subj, new, rev in plan)
    todo_html = "".join(f"<li>Sign {n}: {esc(t)}</li>" for n, t in sorted(todo)) or "<li>Nothing. Ready to paste into Apps Script.</li>"
    open(os.path.join(HERE, "course-plan.html"), "w", encoding="utf-8").write(f"""<!doctype html><html><head>
<meta charset="utf-8"><title>Sign course plan</title><style>
body{{font-family:{FONT};background:#fff;color:{INK};margin:0;padding:28px}} h1{{margin:0 0 4px}}
table{{border-collapse:collapse;background:#fff;width:100%;margin-top:16px}} td,th{{border:1px solid {HAIRLINE};padding:7px 9px;
text-align:left;font-size:14px;vertical-align:top}} th{{background:{INK};color:#fff}} .sub{{color:{GRAPHITE}}}
</style></head><body><h1>1000 Hands sign course</h1>
<div class="sub">{len(emails)} emails, one every {SEND_EVERY} days, over {plan[-1][1]} days · {len(signs)} signs, one per email ·
each sign checked {", ".join(str(g) for g in REVIEW_AFTER)} emails after it's taught</div>
<table><tr><th>#</th><th>Day</th><th>Email (click to preview)</th><th>New sign</th><th>Quick check</th></tr>
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
    print(f"{len(emails)} emails over {plan[-1][1]} days; {len(todo)} items still missing. Open course-plan.html.")


if __name__ == "__main__":
    main()
