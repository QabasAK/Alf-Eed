---
name: term-list
description: Drafts a field's core term list and bilingual Arabic and English definitions into templates/terms.csv. Use when a team needs to choose lexicon terms, write definitions, or add terms to their sheet.
---

# Term list

Work in `templates/terms.csv`. Ask for the field, the number and the audience if you don't
already have them.

## Choosing terms

- Pick what students meet first and use most, in their first year or two.
- Split evenly into categories where possible. Engineering uses 14 in each of 3.
- Prefer concepts over names and acronyms: a concept can be animated, and a name can be
  fingerspelled.
- Show the proposed list with a one-line reason per term and get approval before writing
  definitions.

## Writing definitions

- Two or three plain sentences in each language. Write the Arabic properly rather than
  translating word for word.
- Use the common Arabic term for the field in Jordan. If usage is split, name the options
  in your reply and pick one.
- Include the unit or formula when it's the term's identity.
- Set `arabic_status` to `needs_review` on every definition you write. Only a human subject
  expert changes it.

## Filling in the sheet

- `id`: lowercase snake case, unique.
- `tags`: semicolon separated, in both languages, covering what someone might search for.
- `animation_path`: `assets/animations/<category>/<id>.mp4`.
- `sign_video_path`, `sign_status`, `signer_credit`: leave these as they are. New rows get
  `not_filmed`. They belong to the Deaf signers.
