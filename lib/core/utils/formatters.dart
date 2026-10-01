/// Pure formatting helpers. No widgets, no state.

/// 4500 -> "4,500"
String formatRs(double n) {
  final s = n.toStringAsFixed(0);
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

/// "Rs 4,500" / "روپے 4,500" depending on language.
String money(String rsLabel, double amount) => '$rsLabel ${formatRs(amount)}';

/// DateTime.now() -> "Oct 2, 2026"
String formatDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[d.month - 1]} ${d.day}, ${d.year}';
}
