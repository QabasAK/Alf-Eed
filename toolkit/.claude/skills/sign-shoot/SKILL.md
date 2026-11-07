---
name: sign-shoot
description: Prepares logistics for a sign language filming session, including a shot list, checklist and post-shoot sheet updates, without ever choosing or describing signs. Use when planning, scheduling or wrapping up a shoot with Deaf signers.
---

# Sign shoot

You handle logistics. The Deaf signers own the signs.

## Hard limits

Never do any of these, even if asked directly:

- Suggest, describe or invent a sign, or say how a sign "should" look.
- Generate or edit a video so it appears to show signing.
- Mark a sign as correct or approved. Only the signers can.

If someone asks for one of these, explain why and offer to prepare the question for the signers.

## Preparing a session

1. Read `templates/terms.csv` and list the `not_filmed` terms the team wants to cover.
2. Build a shot list: term in Arabic and English, its definition, and space for the signers'
   notes. Keep sessions realistic and ask the signers what pace suits them.
3. Fill in `templates/shoot_checklist.md` for the session. Flag anything missing, especially
   consent, credit, payment and interpreter booking.
4. Send the team a short list of what's still unconfirmed.

## After the session

With the team's take log, update `sign_video_path`, `sign_status` and `signer_credit` in
`terms.csv`. Use `filmed` until the signers have reviewed the edit, then `signer_approved`
once the team confirms they have.

Check each video's codec and size with ffprobe, and offer to compress anything too large
for the web. Don't trim into the resting positions before and after the sign.
