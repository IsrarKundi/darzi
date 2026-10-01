import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography scale. Single source of truth — no ad-hoc TextStyles in UI.
/// Pass `isUrdu` (from LanguageController) so Urdu gets Nastaliq headings
/// and Noto Sans Arabic body, English gets Inter.
class AppText {
  AppText._();

  // ---------- Headings ----------
  static TextStyle display(bool ur) => _heading(ur, 30, 28, AppColors.ink900);
  static TextStyle headingLg(bool ur) => _heading(ur, 24, 22, AppColors.ink900);
  static TextStyle headingMd(bool ur) => _heading(ur, 20, 18, AppColors.ink900);
  static TextStyle headingSm(bool ur) => _heading(ur, 18, 16, AppColors.ink900);

  static TextStyle _heading(bool ur, double urSize, double enSize, Color color) {
    return ur
        ? GoogleFonts.notoNastaliqUrdu(
            fontSize: urSize, fontWeight: FontWeight.w700, color: color, height: 2.0)
        : GoogleFonts.inter(
            fontSize: enSize, fontWeight: FontWeight.w700, color: color, height: 1.3);
  }

  // ---------- UI / body text ----------
  static TextStyle title(bool ur, {Color color = AppColors.ink900}) =>
      _ui(ur, 16, FontWeight.w600, color, 1.4);

  static TextStyle bodyLg(bool ur, {Color color = AppColors.ink700}) =>
      _ui(ur, 15, FontWeight.w400, color, 1.5);

  static TextStyle body(bool ur, {Color color = AppColors.ink700}) =>
      _ui(ur, 14, FontWeight.w400, color, 1.5);

  static TextStyle bodySm(bool ur, {Color color = AppColors.ink500}) =>
      _ui(ur, 13, FontWeight.w400, color, 1.45);

  static TextStyle caption(bool ur, {Color color = AppColors.ink500}) =>
      _ui(ur, 12, FontWeight.w400, color, 1.4);

  static TextStyle button(bool ur, {Color color = Colors.white}) =>
      _ui(ur, 14, FontWeight.w600, color, 1.4);

  static TextStyle money(bool ur, {Color color = AppColors.ink900}) =>
      _ui(ur, 15, FontWeight.w700, color, 1.4);

  /// Big hero number (e.g. "2" orders due today). Uses the body font even in
  /// Urdu — digits are LTR runs and look wrong in Nastaliq.
  static TextStyle hero(bool ur) =>
      _ui(ur, 46, FontWeight.w800, AppColors.ink900, 1.15);

  static TextStyle _ui(bool ur, double size, FontWeight weight, Color color, double height) {
    return ur
        ? GoogleFonts.notoSansArabic(
            fontSize: size, fontWeight: weight, color: color, height: height)
        : GoogleFonts.inter(
            fontSize: size, fontWeight: weight, color: color, height: height);
  }
}
