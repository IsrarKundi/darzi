import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// Big dark-green action tile on Home. Tapping shows a "coming in step N"
/// snackbar until the feature is built.
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        onTap: () => Get.snackbar('', 'coming_step2'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.ink900,
            colorText: Colors.white,
            margin: const EdgeInsets.all(AppSizes.gapLg)),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.gapLg,
            horizontal: AppSizes.gapXs,
          ),
          decoration: BoxDecoration(
            color: AppColors.brand900,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(height: AppSizes.gapSm),
              Text(label,
                  textAlign: TextAlign.center,
                  style: AppText.button(ur).copyWith(height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}
