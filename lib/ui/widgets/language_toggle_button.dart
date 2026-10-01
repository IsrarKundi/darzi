import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// EN | اردو pill in the app bar. Toggles the whole app's language + RTL.
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguageController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.gapMd),
        child: OutlinedButton(
          onPressed: lang.toggle,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.brand700),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.pill),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.gapLg,
              vertical: AppSizes.gapSm,
            ),
          ),
          child: Text(
            lang.isUrdu ? 'EN' : 'اردو',
            style: AppText.body(false, color: AppColors.brand700)
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
