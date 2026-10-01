import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../core/utils/formatters.dart';
import '../../models/booking.dart';

/// Compact 3-level order row (NOT a card): customer → garment/due → status.
/// Whole row is tappable. Lives inside a section card with dividers.
///
/// The status chip is caller-configured so one row serves due-today,
/// overdue, ready-for-pickup and upcoming sections. [trailing] replaces
/// the balance amount on the right when given (e.g. a Deliver button).
class OrderRow extends StatelessWidget {
  final Booking booking;
  final String chipLabel;
  final Color chipColor;
  final Color chipBg;
  final Widget? trailing;

  const OrderRow({
    super.key,
    required this.booking,
    required this.chipLabel,
    required this.chipColor,
    required this.chipBg,
    this.trailing,
  });

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
            Container(
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(color: chipColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSizes.gapMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(booking.customerName, style: AppText.title(ur)),
                  const SizedBox(height: 2),
                  Text(
                    '${booking.garment} · ${'due'.tr} ${booking.dueDate}',
                    style: AppText.bodySm(ur),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: chipBg,
                    borderRadius:
                        BorderRadius.circular(AppSizes.pill),
                  ),
                  child: Text(
                    chipLabel,
                    style: AppText.caption(ur, color: chipColor)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: AppSizes.gapXs),
                trailing ??
                    // Digits are an LTR run even in RTL — formatRs handles it.
                    Text(
                      money('rs'.tr, booking.balance,
                          locale: lang.localeCode),
                      style: AppText.money(ur).copyWith(fontSize: 14),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
