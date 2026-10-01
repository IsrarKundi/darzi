import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../core/utils/formatters.dart';
import '../../models/booking.dart';

/// Compact payment row: customer + amount + inline one-tap "Remind".
/// (Reminders are the category's killer loop — Easy Khata / KhataBook.)
class PaymentRow extends StatelessWidget {
  final Booking booking;

  const PaymentRow({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguageController>();
    final ur = lang.isUrdu;

    return InkWell(
      onTap: () => Get.snackbar('', 'coming_step2'.tr,
          snackPosition: SnackPosition.BOTTOM),
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSizes.rowMinHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.cardPadding,
          vertical: AppSizes.gapMd,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(booking.customerName, style: AppText.title(ur)),
                  const SizedBox(height: 2),
                  Text(booking.garment, style: AppText.bodySm(ur)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  money('rs'.tr, booking.balance,
                      locale: lang.localeCode),
                  style: AppText.money(ur).copyWith(fontSize: 15),
                ),
                const SizedBox(height: AppSizes.gapSm),
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppSizes.pill),
                  onTap: () => Get.snackbar('', 'coming_step2'.tr,
                      snackPosition: SnackPosition.BOTTOM),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.gapMd,
                        vertical: AppSizes.gapSm),
                    decoration: BoxDecoration(
                      color: AppColors.brand50,
                      borderRadius:
                          BorderRadius.circular(AppSizes.pill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.message_outlined,
                            size: 15, color: AppColors.brand700),
                        const SizedBox(width: AppSizes.gapXs),
                        Text(
                          'remind'.tr,
                          style: AppText.caption(ur,
                                  color: AppColors.brand700)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
