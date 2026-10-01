import 'package:flutter/material.dart';

/// Design-system colors. Single source of truth — no hex literals anywhere
/// else in the codebase.
///
/// Discipline (from UX research): one strong brand color (deep green) for
/// primary actions only; warm-tinted neutrals everywhere else; saturated
/// colors reserved for semantic meaning (overdue / paid / warnings) and
/// always paired with an icon + text label, never color alone.
class AppColors {
  AppColors._();

  // Brand — primary actions, active states. Nothing else gets this green.
  static const brand900 = Color(0xFF0A2E29);
  static const brand800 = Color(0xFF0A4A40);
  static const brand700 = Color(0xFF0B5F4F);
  static const brand600 = Color(0xFF0E7C66);
  static const brand100 = Color(0xFFD7EBE2);
  static const brand50 = Color(0xFFEAF6F1);

  // Warm neutrals — paper background, warm ink. This is what makes the app
  // feel like a tailor's shop instead of a bank.
  static const bg = Color(0xFFFAF7F1);
  static const surface = Colors.white;
  static const surfaceWarm = Color(0xFFF4EEE1);

  static const ink900 = Color(0xFF1C1917);
  static const ink700 = Color(0xFF44403C);
  static const ink500 = Color(0xFF78716C);
  static const ink400 = Color(0xFFA8A29E);

  static const line = Color(0xFFE9E2D4);

  // Semantic — meaning only, always with icon + text.
  static const ok = Color(0xFF067647);
  static const okBg = Color(0xFFDCFAE6);
  static const warn = Color(0xFFB54708);
  static const warnBg = Color(0xFFFEF3E2);
  static const danger = Color(0xFFB42318);
  static const dangerBg = Color(0xFFFEECEB);
  static const info = Color(0xFF175CD3);
  static const infoBg = Color(0xFFEAF1FE);
}
