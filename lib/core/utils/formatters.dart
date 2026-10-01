import 'package:intl/intl.dart';

/// Pure formatting helpers. No widgets, no state.
///
/// Rule: never hand-roll number/date formats — everything goes through
/// `intl` with the active locale. ur-PK defaults to European digits (0-9)
/// per CLDR; digits always flow LTR inside RTL layouts.

/// 4500 -> "4,500" (locale-aware grouping)
String formatRs(double n, {String? locale}) =>
    NumberFormat.decimalPattern(locale).format(n);

/// "Rs 4,500" / "روپے 4,500" depending on language.
String money(String rsLabel, double amount, {String? locale}) =>
    '$rsLabel ${formatRs(amount, locale: locale)}';

/// DateTime -> "Oct 2, 2026" / "2 اکتوبر، 2026" depending on locale.
String formatDate(DateTime d, String locale) =>
    DateFormat.yMMMd(locale).format(d);
