import 'package:flutter/material.dart';
import '../models/term.dart';

/// LIU × ألف ايد brand palette: black ink on warm paper, one electric blue accent.
class AppColors {
  AppColors._();

  // Brand
  static const Color blue = Color(0xFF1E3CFF);
  static const Color blueDark = Color(0xFF142AD1);
  static const Color blueTint = Color(0xFFE9ECFF);
  static const Color ink = Color(0xFF0B0B0C);
  static const Color graphite = Color(0xFF5E616B);

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
