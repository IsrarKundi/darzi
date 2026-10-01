import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/home_controller.dart';
import '../../controllers/getx/language_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../core/utils/formatters.dart';
import '../widgets/booking_card.dart';
import '../widgets/language_toggle_button.dart';
import '../widgets/pending_payment_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_card.dart';

/// Home tab: greeting, stats, quick actions, today's bookings,
/// pending payments. Dumb view — data comes from HomeController.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguageController>();
    final home = Get.put(HomeController());

    return Obx(() {
      final ur = lang.isUrdu;
      return SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.bg,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('app_name'.tr,
                      style: AppText.headingLg(ur)
                          .copyWith(color: AppColors.brand900)),
                  Text('app_tagline'.tr, style: AppText.caption(ur)),
                ],
              ),
              actions: const [LanguageToggleButton()],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.pagePadding,
                AppSizes.gapSm,
                AppSizes.pagePadding,
                AppSizes.gapXxl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text('greeting'.tr, style: AppText.display(ur)),
                  const SizedBox(height: 2),
                  Text(formatDate(DateTime.now()),
                      style: AppText.bodySm(ur)),
                  const SizedBox(height: AppSizes.gapLg),
                  Row(
                    children: [
                      StatCard(
                        value: '${home.bookings.length}',
                        label: 'stat_today'.tr,
                        accent: AppColors.brand700,
                        accentBg: AppColors.brand50,
                      ),
                      const SizedBox(width: AppSizes.gapMd),
                      StatCard(
                        value: '${home.inProgressCount}',
                        label: 'stat_progress'.tr,
                        accent: AppColors.info,
                        accentBg: AppColors.infoBg,
                      ),
                      const SizedBox(width: AppSizes.gapMd),
                      StatCard(
                        value: money('rs'.tr, home.pendingTotal),
                        label: 'stat_pending'.tr,
                        accent: AppColors.warn,
                        accentBg: AppColors.warnBg,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.gapXl),
                  Row(
                    children: [
                      QuickActionButton(
                          icon: Icons.add_circle_outline,
                          label: 'qa_new_booking'.tr),
                      const SizedBox(width: AppSizes.gapMd),
                      QuickActionButton(
                          icon: Icons.person_add_outlined,
                          label: 'qa_add_customer'.tr),
                      const SizedBox(width: AppSizes.gapMd),
                      QuickActionButton(
                          icon: Icons.payments_outlined,
                          label: 'qa_record_payment'.tr),
                    ],
                  ),
                  const SizedBox(height: AppSizes.gapXxl),
                  SectionHeader(text: 'today_bookings'.tr),
                  const SizedBox(height: AppSizes.gapMd),
                  ...home.bookings
                      .map((b) => BookingCard(booking: b)),
                  const SizedBox(height: AppSizes.gapXl),
                  SectionHeader(text: 'pending_payments'.tr),
                  const SizedBox(height: AppSizes.gapMd),
                  ...home.pendingPayments
                      .map((b) => PendingPaymentCard(booking: b)),
                ]),
              ),
            ),
          ],
        ),
      );
    });
  }
}
