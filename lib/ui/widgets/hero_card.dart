import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// The one hero number on Home: "2 orders due today".
/// Tonal green card — the single emphasized element on the screen.
/// Tapping goes to the list behind the number (no dead ends).
class HeroCard extends StatelessWidget {
  final String value;
  final String label;
  final String sub;
  final VoidCallback onTap;

  const HeroCard({
    super.key,
    required this.value,
    required this.label,
    required this.sub,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.radiusXl),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.gapLg),
        decoration: BoxDecoration(
          color: AppColors.brand50,
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
          border: Border.all(color: AppColors.brand100),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: AppText.hero(ur)),
                  const SizedBox(height: AppSizes.gapXs),
                  Text(label,
                      style: AppText.title(ur, color: AppColors.brand900)),
                  const SizedBox(height: AppSizes.gapXs),
                  Text(sub,
                      style: AppText.bodySm(ur, color: AppColors.brand800)),
                ],
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              // arrow_forward auto-mirrors in RTL (matchTextDirection).
              child: const Icon(Icons.arrow_forward,
                  color: AppColors.brand700, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
