/// Spacing / sizing scale. Single source of truth — no magic numbers
/// for padding, gaps, radii, or control heights in UI code.
///
/// Rhythm: 16dp page margins, 8dp base unit, 28dp between home sections.
/// Touch: 48dp minimum target everywhere, 64dp for the primary actions.
class AppSizes {
  AppSizes._();

  // Padding
  static const double pagePadding = 16.0;
  static const double cardPadding = 16.0;
  static const double sectionPadding = 12.0;

  // Gaps
  static const double gapXs = 4.0;
  static const double gapSm = 8.0;
  static const double gapMd = 12.0;
  static const double gapLg = 16.0;
  static const double gapXl = 20.0;
  static const double gapXxl = 24.0;
  static const double sectionGap = 28.0;

  // Radii — soft craft shapes, not enterprise rectangles
  static const double radiusSm = 10.0;
  static const double radiusMd = 14.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double cardRadius = 20.0;
  static const double pill = 999.0;

  // Control heights
  static const double buttonHeight = 48.0;
  static const double actionHeight = 64.0;
  static const double rowMinHeight = 72.0;
  static const double inputHeight = 52.0;
  static const double iconBox = 46.0;
  static const double navLabelSize = 11.0;
}
