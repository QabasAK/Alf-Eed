// The Arabic manual alphabet used for fingerspelling in Jordanian Sign Language.
// Each letter's clip lives at assets/letters/<slug>.gif, made by
// tool/make_letter_gifs.py from clips saved from the JSL dictionary on SooSL.
// That script keeps its own copy of this table: change both together.

/// Letter → asset slug, for every letter that has its own handshape.
const letterSlugs = {
  'ا': 'alif', 'ب': 'ba', 'ت': 'ta', 'ث': 'tha', 'ج': 'jim', 'ح': 'hha', 'خ': 'kha',
  'د': 'dal', 'ذ': 'dhal', 'ر': 'ra', 'ز': 'zay', 'س': 'sin', 'ش': 'shin', 'ص': 'sad',
  'ض': 'dad', 'ط': 'taa', 'ظ': 'zaa', 'ع': 'ayn', 'غ': 'ghayn', 'ف': 'fa', 'ق': 'qaf',
  'ك': 'kaf', 'ل': 'lam', 'م': 'mim', 'ن': 'nun', 'ه': 'ha', 'و': 'waw', 'ي': 'ya',
  'ة': 'ta-marbuta', 'ء': 'hamza', 'أ': 'alif-hamza', 'إ': 'alif-hamza-below',
  'ؤ': 'waw-hamza', 'ئ': 'ya-hamza',
};

/// Letters spelled with another letter's handshape.
// shortcut: madda and alif maqsura borrow their base letter's sign.
// Check each with a Deaf signer, and give one its own clip if JSL has one.
const letterFallbacks = {'آ': 'ا', 'ى': 'ي'};

/// The letters of [name] that can be fingerspelled, in reading order.
/// A space stays as ' ' so names keep their word breaks; anything else is dropped.
List<String> spellableLetters(String name) => [
      for (final ch in name.trim().replaceAll(RegExp(r'\s+'), ' ').split(''))
        if (ch == ' ')
          ' '
        else if (letterSlugs.containsKey(ch))
          ch
        else if (letterFallbacks.containsKey(ch))
          letterFallbacks[ch]!,
    ];
