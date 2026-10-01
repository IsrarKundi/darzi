# Darzi — Project Rules

This file is the source of truth for how this codebase is organized.
Read it before writing any code in this repo.

## 1. Package-first rule
Do NOT write custom code when a well-maintained package exists for the job.
Current approved packages:
- `get` — state management, navigation, i18n (`.tr`), snackbars
- `get_storage` — lightweight local persistence (language, settings)
- `google_fonts` — Inter (EN), Noto Sans Arabic (UR body), Noto Nastaliq Urdu (UR headings)
- `flutter_localizations` — RTL mirroring via locale (automatic, do not hand-roll RTL)
- `intl` — ALL number/date formatting via locale (`NumberFormat`/`DateFormat`).
  Never hand-roll commas, date parts, or digit handling.

Before adding any new package: check it is maintained, null-safe, and actually
needed. Prefer the smallest package that solves the problem.

## 2. Consistency rules (non-negotiable)
- **Colors:** only `AppColors` (`core/constants/app_colors.dart`). No hex literals in UI code.
- **Text:** only `AppText` (`core/constants/app_text.dart`). No ad-hoc `TextStyle`s.
  Every user-facing string goes through GetX i18n (`'some_key'.tr`) with EN + UR
  entries in `AppTranslations`. No hardcoded UI strings.
- **Sizes:** only `AppSizes` (`core/constants/app_sizes.dart`) for padding, gaps,
  radii, heights. Cards and buttons must share the same metrics app-wide.
- **Cards:** use the theme `Card` (outlined, 20dp, zero elevation — set in
  `AppTheme`). Do not invent new card containers or add shadows.

## 3. Folder structure
```
lib/
  main.dart                      # minimal: init, DI, GetMaterialApp. No UI logic.
  core/
    constants/                   # app_colors, app_text, app_sizes (single source of truth)
    theme/                       # AppTheme.build(isUrdu)
    translations/                # AppTranslations (GetX Translations), EN + UR
    utils/                       # formatters, helpers (pure functions only)
  models/                        # ONE file per model. Each model has fromJson/toJson
                                 # (written now so API parsing later is trivial).
  controllers/
    getx/                        # GetX controllers only. All business logic lives here.
    api_services/                # API layer (empty until backend exists).
  ui/
    screens/                     # ONE file per screen, max ~500 lines each.
    widgets/                     # reusable components. Prefer composing over new widgets.
```

## 4. GetX conventions
- Controllers extend `GetxController`, registered once with `Get.put` at app start
  (or in the screen that owns them — never twice).
- Screens are `StatelessWidget` + `Obx`/`GetView`. No `StatefulWidget` unless a
  framework API forces it.
- Navigation via `NavigationController`, never `Navigator.push` directly.
- Language via `LanguageController`; toggle persists with `get_storage`.

## 5. UI/UX rules
- Mobile-first. RTL is automatic from the `ur` locale — verify EVERY screen in
  both EN and UR before calling a step done.
- **Home is a morning briefing, not a dashboard.** Order: slim header →
  one hero number → quick actions → due today → overdue → pending payments.
  No walls of metrics, no charts on home, compact rows (not cards) for lists.
- **One primary CTA per screen.** Home's is New Booking (the single `filled`
  quick action). Every KPI number must tap through to its list; every row to
  its detail. No dead ends.
- **Touch:** 48dp minimum target everywhere; 64dp for primary actions
  (`AppSizes.actionHeight`). Icon + always-visible text label pairs — never
  icon-only mystery navigation.
- **Warm craft, not corporate:** warm paper background (`AppColors.bg`),
  tonal/outlined cards (theme `CardTheme`, no elevation), 20dp card radii,
  stadium buttons/chips. Brand green is for primary actions only; saturated
  colors are semantic (overdue/paid/warn) and always paired with icon + text.
- **Urdu typography:** Nastaliq headings (`AppText` handles it, 2.0 line
  height); Noto Sans Arabic body; **digits/amounts always in the body font**
  (never Nastaliq) and always LTR runs. Urdu body ≥ 13sp, no fixed-height
  text containers.
- **Numbers/dates:** NEVER hand-roll — all through `intl` (`formatters.dart`)
  with `LanguageController.localeCode`. ur-PK defaults to European digits.
- **RTL construction:** only directional APIs (`EdgeInsetsDirectional`,
  `AlignmentDirectional`, `TextAlign.start`, `BorderRadiusDirectional`,
  `Icons.adaptive.*` / auto-mirroring `Icons.arrow_forward`). Grep-ban:
  `.left`/`.right`, `TextAlign.left/right`, `Icons.arrow_back` (non-adaptive),
  physical `Positioned`/`Alignment`. Direction comes from the locale — never
  a hardcoded root `Directionality`.
- Urdu headings use Nastaliq (`AppText` handles this); Urdu body uses Noto Sans Arabic.
- Placeholders for not-yet-built features use `PlaceholderView`, never dead buttons
  that do nothing silently — quick actions show a "coming in step N" snackbar.
- Sample/seed data lives in controllers (e.g. `HomeController`), never in widgets.

## 6. Scaling notes
- When API arrives: add `ApiService` classes under `controllers/api_services/`,
  models already have `fromJson`. Controllers call services, screens stay dumb.
- When a screen approaches 500 lines: extract a widget, do not grow the file.
