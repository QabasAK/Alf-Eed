// ─────────────────────────────────────────────────────────────────────────────
// The الف ايد initiative: the fields on the wall and where its links go.
//
// Every field gets its own term count and colour, with a true, nerdy reason
// behind the count. Counts stay small and whole: each term is a sign someone
// has to film. To add a field: append an entry. To launch one: give it a `route`.
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:ui' show Color;

import '../theme/app_colors.dart';

class InitiativeField {
  final int count;
  final Color color;
  final String englishName;
  final String arabicName;
  final String englishJoke;
  final String arabicJoke;

  /// Where the field's lexicon lives. Null means nobody has claimed it yet.
  final String? route;

  const InitiativeField({
    required this.count,
    required this.color,
    required this.englishName,
    required this.arabicName,
    required this.englishJoke,
    required this.arabicJoke,
    this.route,
  });
}

const List<InitiativeField> initiativeFields = [
  InitiativeField(
    count: 42,
    color: AppColors.blue,
    englishName: 'Engineering',
    arabicName: 'الهندسة',
    englishJoke: 'The answer to life, the universe and everything. It also splits nicely into three.',
    arabicJoke: 'جواب الحياة والكون وكل شيء، ويقبل القسمة على ثلاثة أيضاً.',
    route: '/engineering',
  ),
  InitiativeField(
    count: 57,
    color: AppColors.fieldMathematics,
    englishName: 'Mathematics',
    arabicName: 'الرياضيات',
    englishJoke: 'Asked to pick a prime, Grothendieck said 57. It\'s 3 × 19. We\'re honouring the mistake.',
    arabicJoke: 'طُلب من غروتندييك اختيار عدد أولي فقال 57، وهو 3 × 19. ونحن نكرّم هذا الخطأ.',
  ),
  InitiativeField(
    count: 17,
    color: AppColors.fieldPhysics,
    englishName: 'Physics',
    arabicName: 'الفيزياء',
    englishJoke: 'One per particle in the Standard Model. It\'s 61 if you count colours and antiparticles. We did not.',
    arabicJoke: 'مصطلح لكل جسيم في النموذج القياسي. ويصبح العدد 61 إذا حسبت الألوان والجسيمات المضادة، ونحن لم نحسبها.',
  ),
  InitiativeField(
    count: 18,
    color: AppColors.fieldChemistry,
    englishName: 'Chemistry',
    arabicName: 'الكيمياء',
    englishJoke: 'One per column of the periodic table. All 118 elements seemed like a lot of hands.',
    arabicJoke: 'مصطلح لكل عمود في الجدول الدوري. أما العناصر الـ118 كلها فتحتاج إلى أيادٍ كثيرة.',
  ),
  InitiativeField(
    count: 33,
    color: AppColors.fieldMedicine,
    englishName: 'Medicine',
    arabicName: 'الطب',
    englishJoke: 'One per vertebra. Every lexicon needs a backbone.',
    arabicJoke: 'مصطلح لكل فقرة في العمود الفقري. فكل قاموس يحتاج إلى عمود فقري.',
  ),
  InitiativeField(
    count: 28,
    color: AppColors.fieldLiterature,
    englishName: 'Literature',
    arabicName: 'الأدب',
    englishJoke: 'One per letter of the Arabic alphabet. Shahrazad got 1001 nights. We got a deadline.',
    arabicJoke: 'مصطلح لكل حرف من حروف العربية. كان لشهرزاد 1001 ليلة، أما نحن فلدينا موعد تسليم.',
  ),
  InitiativeField(
    count: 10,
    color: AppColors.fieldArchitecture,
    englishName: 'Architecture',
    arabicName: 'العمارة',
    englishJoke: 'Vitruvius wrote ten books on architecture. Everyone still quotes the same three words.',
    arabicJoke: 'كتب فيتروفيوس عشرة كتب في العمارة، وما زال الجميع يقتبس الكلمات الثلاث نفسها.',
  ),
];

/// Served from web/toolkit/. Rebuild it with: python tool/build_toolkit.py
const String toolkitPath = 'toolkit/1000-hands-toolkit.zip';

/// Shown as "Talk to us" and "Fork the site" once set. The GitHub repo is
/// private for now, so a link to it would 404 for visitors.
const String? contactUrl = null;
const String? repoUrl = null;
