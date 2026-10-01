import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// Standard empty state for tabs whose feature ships in a later step.
class PlaceholderView extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderView({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.gapXxl + 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.brand50,
                borderRadius: BorderRadius.circular(AppSizes.radiusXl + 4),
              ),
              child:
                  Icon(icon, size: 40, color: AppColors.brand700),
            ),
            const SizedBox(height: AppSizes.gapXl),
            Text(title, style: AppText.headingLg(ur)),
            const SizedBox(height: AppSizes.gapSm),
            Text('coming_next'.tr,
                textAlign: TextAlign.center, style: AppText.body(ur)),
          ],
        ),
      ),
    );
  }
}
