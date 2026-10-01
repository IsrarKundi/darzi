import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../models/booking.dart';

/// Pill showing a booking's status with the right color per status.
class StatusChip extends StatelessWidget {
  final BookingStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color color;
    late final Color bg;
    switch (status) {
      case BookingStatus.cutting:
        label = 'status_cutting'.tr;
        color = AppColors.warn;
        bg = AppColors.warnBg;
        break;
      case BookingStatus.stitching:
        label = 'status_stitching'.tr;
        color = AppColors.info;
        bg = AppColors.infoBg;
        break;
      case BookingStatus.trial:
        label = 'status_trial'.tr;
        color = AppColors.brand700;
        bg = AppColors.brand50;
        break;
      case BookingStatus.ready:
        label = 'status_ready'.tr;
        color = AppColors.ok;
        bg = AppColors.okBg;
        break;
      case BookingStatus.delivered:
        label = 'status_delivered'.tr;
        color = AppColors.ink500;
        bg = AppColors.bg;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.gapMd,
        vertical: AppSizes.gapXs + 1,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSizes.pill),
      ),
      child: Text(label,
          style: AppText.caption(false, color: color)
              .copyWith(fontWeight: FontWeight.w700)),
    );
  }
}
