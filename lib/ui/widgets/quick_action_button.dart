import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// Big thumb-friendly action on Home (64dp). One `filled` primary per
/// screen (New Booking); the rest tonal. Icon + always-visible label.
/// Tapping shows a "coming in step N" snackbar until built.
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool filled;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    final bg = filled ? AppColors.brand700 : AppColors.brand50;
    final fg = filled ? Colors.white : AppColors.brand900;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        onTap: () => Get.snackbar('', 'coming_step2'.tr,
            snackPosition: SnackPosition.BOTTOM),
        child: Container(
          height: AppSizes.actionHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.gapSm),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            border: filled
                ? null
                : Border.all(color: AppColors.brand100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: 24),
              const SizedBox(height: AppSizes.gapXs),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    AppText.button(ur, color: fg).copyWith(height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
