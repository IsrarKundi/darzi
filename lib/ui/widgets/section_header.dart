import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// Section heading with optional count badge and "see all" action.
class SectionHeader extends StatelessWidget {
  final String text;
  final int? count;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.text,
    this.count,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Row(
      children: [
        Text(text, style: AppText.headingSm(ur)),
        if (count != null) ...[
          const SizedBox(width: AppSizes.gapSm),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceWarm,
              borderRadius: BorderRadius.circular(AppSizes.pill),
            ),
            child: Text(
              '$count',
              style: AppText.caption(ur, color: AppColors.ink700)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
        const Spacer(),
        if (onSeeAll != null)
          InkWell(
            borderRadius: BorderRadius.circular(AppSizes.pill),
            onTap: onSeeAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.gapSm,
                  vertical: AppSizes.gapXs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'see_all'.tr,
                    style: AppText.button(ur, color: AppColors.brand700),
                  ),
                  const SizedBox(width: 2),
                  // Auto-mirrors in RTL.
                  const Icon(Icons.arrow_forward,
                      size: 16, color: AppColors.brand700),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
