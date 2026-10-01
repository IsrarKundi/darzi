import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================
// Darzi — Step 1: App shell, 5-tab navigation, Home screen,
// English/Urdu toggle with fully mirrored RTL layout.
// ============================================================

// ---------------- Design tokens (from Figma system) ----------------
class D {
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
  static const warn = Color(0xFFB54708);
  static const warnBg = Color(0xFFFEF3E2);
  static const danger = Color(0xFFB42318);
  static const dangerBg = Color(0xFFFEECEB);
  static const info = Color(0xFF175CD3);
  static const infoBg = Color(0xFFEAF1FE);
  static const ok = Color(0xFF067647);
  static const okBg = Color(0xFFDCFAE6);
}

// ---------------- Strings (English + Urdu) ----------------
class S {
  static const Map<String, Map<String, String>> _t = {
    'appName': {'en': 'Darzi', 'ur': 'درزی'},
    'tagline': {'en': 'Tailor Shop', 'ur': 'درزی شاپ'},
    'nav_home': {'en': 'Home', 'ur': 'ہوم'},
    'nav_bookings': {'en': 'Bookings', 'ur': 'بکنگز'},
    'nav_customers': {'en': 'Customers', 'ur': 'گاہک'},
    'nav_finance': {'en': 'Finance', 'ur': 'حساب کتاب'},
    'nav_more': {'en': 'More', 'ur': 'مزید'},
    'greeting': {'en': 'Assalam-o-Alaikum', 'ur': 'السلام علیکم'},
    'stat_today': {'en': "Today's bookings", 'ur': 'آج کی بکنگیں'},
    'stat_progress': {'en': 'In progress', 'ur': 'جاری کام'},
    'stat_pending': {'en': 'Pending amount', 'ur': 'واجب الادا رقم'},
    'qa_new_booking': {'en': 'New Booking', 'ur': 'نئی بکنگ'},
    'qa_add_customer': {'en': 'Add Customer', 'ur': 'نیا گاہک'},
    'qa_record_payment': {'en': 'Record Payment', 'ur': 'ادائیگی'},
    'today_bookings': {'en': "Today's bookings", 'ur': 'آج کی بکنگیں'},
    'pending_payments': {'en': 'Pending payments', 'ur': 'واجب الادا ادائیگیاں'},
    'remind': {'en': 'Remind', 'ur': 'یاد دہانی'},
    'due': {'en': 'Due', 'ur': 'تاریخ'},
    'advance': {'en': 'Advance', 'ur': 'ایڈوانس'},
    'balance': {'en': 'Balance', 'ur': 'بقایا'},
    'status_cutting': {'en': 'Cutting', 'ur': 'کٹنگ'},
    'status_stitching': {'en': 'Stitching', 'ur': 'سلائی'},
    'status_ready': {'en': 'Ready', 'ur': 'تیار'},
    'status_trial': {'en': 'Trial', 'ur': 'ٹرائل'},
    'coming_step': {'en': 'Coming in Step 2', 'ur': 'مرحلہ 2 میں آئے گا'},
    'coming_next': {'en': 'Available in the next step', 'ur': 'اگلے مرحلے میں دستیاب ہوگا'},
    'rs': {'en': 'Rs', 'ur': 'روپے'},
  };

  final String lang;
  const S(this.lang);
  String get(String key) => _t[key]?[lang] ?? _t[key]?['en'] ?? key;
  bool get isUrdu => lang == 'ur';
}

// ---------------- Sample data (Step 1 seed) ----------------
enum BStatus { cutting, stitching, ready, trial }

class Booking {
  final String customer, garment, due;
  final BStatus status;
  final int price, advance;
  const Booking(this.customer, this.garment, this.status, this.due, this.price, this.advance);
}

const seedBookings = [
  Booking('Ahmed Raza', 'Shalwar Kameez', BStatus.cutting, 'Oct 5', 4500, 2000),
  Booking('Bilal Hussain', 'Waistcoat Set', BStatus.stitching, 'Oct 6', 8000, 4000),
  Booking('Usman Tariq', 'Kurta Pajama', BStatus.ready, 'Oct 4', 3200, 3200),
];

const seedPending = [
  Booking('Ahmed Raza', 'Shalwar Kameez', BStatus.cutting, 'Oct 5', 4500, 2000),
  Booking('Danish Ali', 'Sherwani', BStatus.trial, 'Oct 8', 15000, 5000),
];

String fmtRs(int n) {
  final s = n.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

// Nastaliq heading style for Urdu (falls back to Inter bold for English)
TextStyle duHeading(S s, double urSize, double enSize, Color color) => s.isUrdu
    ? GoogleFonts.notoNastaliqUrdu(
        fontSize: urSize, fontWeight: FontWeight.bold, color: color, height: 2.0)
    : TextStyle(fontSize: enSize, fontWeight: FontWeight.bold, color: color, height: 1.25);

// ---------------- App root ----------------
void main() => runApp(const DarziApp());

class DarziApp extends StatefulWidget {
  const DarziApp({super.key});
  @override
  State<DarziApp> createState() => _DarziAppState();
}

class _DarziAppState extends State<DarziApp> {
  String _lang = 'en';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((p) {
      final l = p.getString('darzi_lang');
      if (l == 'ur' || l == 'en') setState(() => _lang = l!);
    });
  }

  void _toggleLang() async {
    final next = _lang == 'en' ? 'ur' : 'en';
    setState(() => _lang = next);
    (await SharedPreferences.getInstance()).setString('darzi_lang', next);
  }

  ThemeData _theme(bool urdu) {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: D.bg,
      colorScheme: ColorScheme.fromSeed(seedColor: D.brand700, primary: D.brand700),
      appBarTheme: const AppBarTheme(
        backgroundColor: D.bg, elevation: 0, scrolledUnderElevation: 0,
        foregroundColor: D.ink900,
      ),
    );
    final tt = urdu
        ? GoogleFonts.notoSansArabicTextTheme(base.textTheme)
        : GoogleFonts.interTextTheme(base.textTheme);
    return base.copyWith(textTheme: tt);
  }

  @override
  Widget build(BuildContext context) {
    final s = S(_lang);
    final urdu = s.isUrdu;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darzi',
      locale: Locale(_lang),
      supportedLocales: const [Locale('en'), Locale('ur')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: _theme(urdu),
      home: AppShell(s: s, onToggleLang: _toggleLang),
    );
  }
}

// ---------------- App shell: 5-tab navigation ----------------
class AppShell extends StatefulWidget {
  final S s;
  final VoidCallback onToggleLang;
  const AppShell({super.key, required this.s, required this.onToggleLang});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final s = widget.s;
    final pages = [
      HomePage(s: s, onToggleLang: widget.onToggleLang),
      PlaceholderPage(s: s, title: s.get('nav_bookings'), icon: Icons.calendar_month_outlined),
      PlaceholderPage(s: s, title: s.get('nav_customers'), icon: Icons.people_outline),
      PlaceholderPage(s: s, title: s.get('nav_finance'), icon: Icons.account_balance_wallet_outlined),
      PlaceholderPage(s: s, title: s.get('nav_more'), icon: Icons.more_horiz),
    ];
    return Scaffold(
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: D.line)),
        ),
        child: BottomNavigationBar(
          currentIndex: _tab,
          onTap: (i) => setState(() => _tab = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: D.brand700,
          unselectedItemColor: D.ink400,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home), label: s.get('nav_home')),
            BottomNavigationBarItem(icon: const Icon(Icons.calendar_month_outlined), activeIcon: const Icon(Icons.calendar_month), label: s.get('nav_bookings')),
            BottomNavigationBarItem(icon: const Icon(Icons.people_outline), activeIcon: const Icon(Icons.people), label: s.get('nav_customers')),
            BottomNavigationBarItem(icon: const Icon(Icons.account_balance_wallet_outlined), activeIcon: const Icon(Icons.account_balance_wallet), label: s.get('nav_finance')),
            BottomNavigationBarItem(icon: const Icon(Icons.more_horiz), label: s.get('nav_more')),
          ],
        ),
      ),
    );
  }
}

// ---------------- Placeholder for future steps ----------------
class PlaceholderPage extends StatelessWidget {
  final S s;
  final String title;
  final IconData icon;
  const PlaceholderPage({super.key, required this.s, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84, height: 84,
                decoration: BoxDecoration(color: D.brand50, borderRadius: BorderRadius.circular(28)),
                child: Icon(icon, size: 40, color: D.brand700),
              ),
              const SizedBox(height: 20),
              Text(title, style: duHeading(s, 24, 20, D.ink900)),
              const SizedBox(height: 8),
              Text(s.get('coming_next'), textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: D.ink500)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Home ----------------
class HomePage extends StatelessWidget {
  final S s;
  final VoidCallback onToggleLang;
  const HomePage({super.key, required this.s, required this.onToggleLang});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final dateStr = '${months[today.month - 1]} ${today.day}, ${today.year}';

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false, floating: false,
            backgroundColor: D.bg,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.get('appName'), style: duHeading(s, 22, 20, D.brand900)),
                Text(s.get('tagline'), style: const TextStyle(fontSize: 12, color: D.ink500)),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: OutlinedButton(
                  onPressed: onToggleLang,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: D.brand700),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(s.isUrdu ? 'EN' : 'اردو',
                    style: const TextStyle(color: D.brand700, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Greeting
                Text(s.get('greeting'), style: duHeading(s, 26, 24, D.ink900)),
                const SizedBox(height: 2),
                Text(dateStr, style: const TextStyle(fontSize: 13, color: D.ink500)),
                const SizedBox(height: 16),
                // Stats
                Row(children: [
                  _StatCard(s: s, value: '3', label: s.get('stat_today'), color: D.brand700, bg: D.brand50),
                  const SizedBox(width: 10),
                  _StatCard(s: s, value: '5', label: s.get('stat_progress'), color: D.info, bg: D.infoBg),
                  const SizedBox(width: 10),
                  _StatCard(s: s, value: '${s.get('rs')} 7,500', label: s.get('stat_pending'), color: D.warn, bg: D.warnBg),
                ]),
                const SizedBox(height: 20),
                // Quick actions
                Row(children: [
                  _QuickAction(s: s, icon: Icons.add_circle_outline, label: s.get('qa_new_booking')),
                  const SizedBox(width: 10),
                  _QuickAction(s: s, icon: Icons.person_add_outlined, label: s.get('qa_add_customer')),
                  const SizedBox(width: 10),
                  _QuickAction(s: s, icon: Icons.payments_outlined, label: s.get('qa_record_payment')),
                ]),
                const SizedBox(height: 24),
                // Today's bookings
                _SectionTitle(s: s, text: s.get('today_bookings')),
                const SizedBox(height: 10),
                ...seedBookings.map((b) => _BookingCard(s: s, b: b)),
                const SizedBox(height: 20),
                // Pending payments
                _SectionTitle(s: s, text: s.get('pending_payments')),
                const SizedBox(height: 10),
                ...seedPending.map((b) => _PendingCard(s: s, b: b)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final S s; final String text;
  const _SectionTitle({required this.s, required this.text});
  @override
  Widget build(BuildContext context) => Text(text, style: duHeading(s, 19, 16, D.ink900));
}

class _StatCard extends StatelessWidget {
  final S s; final String value, label; final Color color, bg;
  const _StatCard({required this.s, required this.value, required this.label, required this.color, required this.bg});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(color: D.surface, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: D.line)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: D.ink500, height: 1.4)),
      ]),
    ),
  );
}

class _QuickAction extends StatelessWidget {
  final S s; final IconData icon; final String label;
  const _QuickAction({required this.s, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.get('coming_step')), duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        decoration: BoxDecoration(color: D.brand900, borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600, height: 1.5)),
        ]),
      ),
    ),
  );
}

class _StatusChip extends StatelessWidget {
  final S s; final BStatus status;
  const _StatusChip({required this.s, required this.status});
  @override
  Widget build(BuildContext context) {
    late String label; late Color c, bg;
    switch (status) {
      case BStatus.cutting: label = s.get('status_cutting'); c = D.warn; bg = D.warnBg; break;
      case BStatus.stitching: label = s.get('status_stitching'); c = D.info; bg = D.infoBg; break;
      case BStatus.ready: label = s.get('status_ready'); c = D.ok; bg = D.okBg; break;
      case BStatus.trial: label = s.get('status_trial'); c = D.brand700; bg = D.brand50; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: c)),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final S s; final Booking b;
  const _BookingCard({required this.s, required this.b});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: D.surface, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: D.line)),
    child: Row(children: [
      Container(
        width: 46, height: 46,
        decoration: BoxDecoration(color: D.brand50, borderRadius: BorderRadius.circular(14)),
        alignment: Alignment.center,
        child: Text(b.customer.characters.first,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: D.brand700)),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(b.customer, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: D.ink900)),
        const SizedBox(height: 2),
        Text('${b.garment} · ${s.get('due')} ${b.due}',
          style: const TextStyle(fontSize: 12, color: D.ink500)),
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        _StatusChip(s: s, status: b.status),
        const SizedBox(height: 6),
        Text('${s.get('rs')} ${fmtRs(b.price)}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: D.ink900)),
      ]),
    ]),
  );
}

class _PendingCard extends StatelessWidget {
  final S s; final Booking b;
  const _PendingCard({required this.s, required this.b});
  @override
  Widget build(BuildContext context) {
    final bal = b.price - b.advance;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: D.surface, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: D.line)),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(b.customer, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: D.ink900)),
          const SizedBox(height: 2),
          Text('${s.get('balance')}: ${s.get('rs')} ${fmtRs(bal)}',
            style: const TextStyle(fontSize: 13, color: D.danger, fontWeight: FontWeight.w600)),
        ])),
        OutlinedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(s.get('coming_step')), duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: D.brand700),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          ),
          child: Text(s.get('remind'),
            style: const TextStyle(color: D.brand700, fontWeight: FontWeight.w600, fontSize: 12)),
        ),
      ]),
    );
  }
}
