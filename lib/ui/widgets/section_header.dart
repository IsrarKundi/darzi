import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_text.dart';

/// Consistent section heading used above lists on Home.
class SectionHeader extends StatelessWidget {
  final String text;

  const SectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Text(text, style: AppText.headingMd(ur));
  }
}
