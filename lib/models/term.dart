/// Represents a single engineering term in the JSL lexicon.
class Term {
  final String id;
  final String englishName;
  final String arabicName;
  final String englishDefinition;
  final String arabicDefinition;
  final TermCategory category;

  /// Path to a Manim-generated concept animation asset (nullable until produced).
  final String? animationPath;

  /// Path to the recorded JSL sign video asset (nullable until recorded).
  final String? signVideoPath;

  final List<String> tags;

  const Term({
    required this.id,
    required this.englishName,
    required this.arabicName,
    required this.englishDefinition,
    required this.arabicDefinition,
    required this.category,
    this.animationPath,
    this.signVideoPath,
    required this.tags,
  });
}

enum TermCategory {
  engineeringBasics,
  computerEngineering,
  electricalEngineering;

  String get englishLabel => switch (this) {
        engineeringBasics => 'Engineering Basics',
        computerEngineering => 'Computer Engineering',
        electricalEngineering => 'Electrical Engineering',
      };

  String get arabicLabel => switch (this) {
        engineeringBasics => 'أساسيات الهندسة',
        computerEngineering => 'هندسة الحاسوب',
        electricalEngineering => 'الهندسة الكهربائية',
      };
}
