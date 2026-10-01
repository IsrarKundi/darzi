import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';

/// One dashboard stat: status dot + label, big count, pending amount.
/// Tappable — used for the In Progress / Ready / Delivered overview.
class StatusStatCard extends StatelessWidget {
  final String label;
  final int count;
  final String amount;
  final Color dotColor;
  final VoidCallback? onTap;

  const StatusStatCard({
    super.key,
    required this.label,
    required this.count,
    required this.amount,
    required this.dotColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.gapMd),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: dotColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: AppSizes.gapXs),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption(ur, color: AppColors.ink700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.gapSm),
              Text('$count', style: AppText.headingLg(ur)),
              const SizedBox(height: 2),
              Text(
                amount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.caption(ur),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
