import 'package:flutter/material.dart';
import '../models/term.dart';

/// LIU × ألف ايد brand palette: black ink on warm paper, one deep blue accent.
class AppColors {
  AppColors._();

  // Brand
  static const Color blue = Color(0xFF2A44B5);
  static const Color blueDark = Color(0xFF1F3590);
  static const Color blueTint = Color(0xFFE8EBF8);
  static const Color ink = Color(0xFF0B0B0C);
  static const Color graphite = Color(0xFF5E616B);

  // One per field on the الف ايد wall. Engineering keeps the brand blue.
  // All pass 4.5:1 with white text, since the field cards are white on colour.
  static const Color fieldMathematics = Color(0xFFC62F3B);
  static const Color fieldPhysics = Color(0xFF6B3FA0);
  static const Color fieldChemistry = Color(0xFF3F7D20);
  static const Color fieldMedicine = Color(0xFF0B7A8C);
  static const Color fieldLiterature = Color(0xFFA8246B);
  static const Color fieldArchitecture = Color(0xFFB4530F);

  // Surfaces
  static const Color background = Color(0xFFF4F2EE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color stone = Color(0xFFECEAE5);
  static const Color stoneDeep = Color(0xFFDEDBD4);

  // Text & lines
  static const Color textPrimary = ink;
  static const Color textSecondary = Color(0xFF5C5C62);
  static const Color border = Color(0xFFE2DFD9);
  static const Color chipBackground = stone;

  /// Single source of truth for category accents (was duplicated per widget).
  static Color category(TermCategory cat) => switch (cat) {
        TermCategory.engineeringBasics => ink,
        TermCategory.computerEngineering => blue,
        TermCategory.electricalEngineering => graphite,
      };
}
