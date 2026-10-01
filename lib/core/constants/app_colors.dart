import 'package:flutter/material.dart';

/// Design-system colors (from Figma). Single source of truth — no hex
/// literals anywhere else in the codebase.
class AppColors {
  AppColors._();

  static const brand900 = Color(0xFF0A2E29);
  static const brand800 = Color(0xFF0A4A40);
  static const brand700 = Color(0xFF0B5F4F);
  static const brand600 = Color(0xFF0E7C66);
  static const brand50 = Color(0xFFEAF6F1);

  static const bg = Color(0xFFF5F8F7);
  static const surface = Colors.white;

  static const ink900 = Color(0xFF101828);
  static const ink700 = Color(0xFF344054);
  static const ink500 = Color(0xFF667085);
  static const ink400 = Color(0xFF98A2B3);

  static const line = Color(0xFFE4E7EC);

  static const ok = Color(0xFF067647);
  static const okBg = Color(0xFFDCFAE6);
  static const warn = Color(0xFFB54708);
  static const warnBg = Color(0xFFFEF3E2);
  static const danger = Color(0xFFB42318);
  static const dangerBg = Color(0xFFFEECEB);
  static const info = Color(0xFF175CD3);
  static const infoBg = Color(0xFFEAF1FE);
}
