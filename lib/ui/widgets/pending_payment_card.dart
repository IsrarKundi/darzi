import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../core/utils/formatters.dart';
import '../../models/booking.dart';
import 'app_card.dart';

/// Pending-payment row: customer, balance, and a Remind button.
class PendingPaymentCard extends StatelessWidget {
  final Booking booking;

  const PendingPaymentCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.gapMd),
      child: AppCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.customerName,
                      style: AppText.title(ur, color: AppColors.ink900)),
                  const SizedBox(height: 2),
                  Text(
                    '${'balance'.tr}: ${money('rs'.tr, booking.balance)}',
                    style: AppText.body(ur, color: AppColors.danger)
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => Get.snackbar('', 'coming_step2'.tr,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.ink900,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(AppSizes.gapLg)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.brand700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.pill),
                ),
              ),
              child: Text('remind'.tr,
                  style: AppText.caption(ur, color: AppColors.brand700)
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
