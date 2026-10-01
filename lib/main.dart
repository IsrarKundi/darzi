import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/getx/language_controller.dart';
import 'controllers/getx/navigation_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/translations/app_translations.dart';
import 'ui/screens/app_shell.dart';

/// App entry point. Keeps only: init, dependency injection, GetMaterialApp.
/// All UI lives under ui/, all logic under controllers/.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(LanguageController());
  Get.put(NavigationController());
  runApp(const DarziApp());
}

class DarziApp extends StatelessWidget {
  const DarziApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguageController>();
    // Rebuilds the whole app when language changes (also flips RTL automatically).
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Darzi',
        translations: AppTranslations(),
        locale: lang.locale.value,
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [Locale('en', 'US'), Locale('ur', 'PK')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.build(lang.isUrdu),
        home: const AppShell(),
      ),
    );
  }
}
