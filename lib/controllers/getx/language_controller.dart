import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Owns the app language. Persists with get_storage, notifies the app via
/// GetMaterialApp locale (which also flips RTL automatically for Urdu).
class LanguageController extends GetxController {
  static const _key = 'darzi_lang';
  final _box = GetStorage();

  final locale = const Locale('en', 'US').obs;

  bool get isUrdu => locale.value.languageCode == 'ur';

  /// 'en_US' / 'ur_PK' — for intl formatters (numbers, dates).
  String get localeCode => isUrdu ? 'ur_PK' : 'en_US';

  @override
  void onInit() {
    super.onInit();
    if (_box.read(_key) == 'ur') {
      locale.value = const Locale('ur', 'PK');
    }
  }

  void toggle() {
    locale.value =
        isUrdu ? const Locale('en', 'US') : const Locale('ur', 'PK');
    _box.write(_key, locale.value.languageCode);
  }
}
