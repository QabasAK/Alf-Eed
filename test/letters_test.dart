import 'package:flutter_test/flutter_test.dart';
import 'package:jslexicon/data/letters.dart';

void main() {
  test('spells a name letter by letter, keeping one space between words', () {
    expect(spellableLetters('  سارة   علي '), ['س', 'ا', 'ر', 'ة', ' ', 'ع', 'ل', 'ي']);
  });

  test('hamza seats and alif maqsura use their base letter', () {
    expect(spellableLetters('أمل'), ['ا', 'م', 'ل']);
    expect(spellableLetters('هدى'), ['ه', 'د', 'ي']);
  });

  test('drops what has no handshape (tashkeel, tatweel, Latin)', () {
    expect(spellableLetters('مُحـمد A'), ['م', 'ح', 'م', 'د', ' ']);
  });

  test('every letter has an asset slug', () {
    expect(letterSlugs.values.toSet().length, letterSlugs.length);
  });
}
