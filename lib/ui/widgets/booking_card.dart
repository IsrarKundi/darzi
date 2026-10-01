import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../core/utils/formatters.dart';
import '../../models/booking.dart';
import 'app_card.dart';
import 'status_chip.dart';

/// Row card for a booking: avatar initial, customer + garment + due date,
/// status chip and price.
class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final ur = Get.find<LanguageController>().isUrdu;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.gapMd),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: AppSizes.iconBox,
              height: AppSizes.iconBox,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.brand50,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Text(
                booking.customerName.characters.first,
                style: AppText.title(ur, color: AppColors.brand700)
                    .copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(width: AppSizes.gapMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.customerName,
                      style: AppText.title(ur, color: AppColors.ink900)),
                  const SizedBox(height: 2),
                  Text('${booking.garment} · ${'due'.tr} ${booking.dueDate}',
                      style: AppText.caption(ur)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatusChip(status: booking.status),
                const SizedBox(height: AppSizes.gapXs + 2),
                Text(money('rs'.tr, booking.price),
                    style: AppText.money(ur)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
