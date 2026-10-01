import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// Small metric card used on Home (bookings today, in progress, pending Rs).
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color accent;
  final Color accentBg;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.accent,
    required this.accentBg,
  });

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.cardPadding,
          horizontal: AppSizes.gapSm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.gapMd,
                vertical: AppSizes.gapXs + 2,
              ),
              decoration: BoxDecoration(
                color: accentBg,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Text(
                value,
                style: AppText.money(ur, color: accent).copyWith(fontSize: 15),
              ),
            ),
            const SizedBox(height: AppSizes.gapSm),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppText.caption(ur).copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
