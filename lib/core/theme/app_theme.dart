import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// App theme. `isUrdu` switches the base font family; headings are handled
/// per-widget via AppText (Nastaliq for Urdu).
class AppTheme {
  AppTheme._();

  static ThemeData build(bool isUrdu) {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brand700,
        primary: AppColors.brand700,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.ink900,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
    final textTheme = isUrdu
        ? GoogleFonts.notoSansArabicTextTheme(base.textTheme)
        : GoogleFonts.interTextTheme(base.textTheme);
    return base.copyWith(textTheme: textTheme);
  }
}
