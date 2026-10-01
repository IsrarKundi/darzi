import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/home_controller.dart';
import '../../controllers/getx/language_controller.dart';
import '../../controllers/getx/navigation_controller.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text.dart';
import '../../core/utils/formatters.dart';
import '../widgets/hero_card.dart';
import '../widgets/language_toggle_button.dart';
import '../widgets/order_row.dart';
import '../widgets/payment_row.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/section_header.dart';

/// Home tab — the morning briefing, not a dashboard.
/// Order: greeting → hero number → quick actions → due today →
/// overdue → pending payments. Dumb view; data from HomeController.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguageController>();
    final nav = Get.find<NavigationController>();
    final home = Get.put(HomeController());

    return Obx(() {
      final ur = lang.isUrdu;
      final locale = lang.localeCode;
      final dueToday = home.dueTodayOrders;
      final overdue = home.overdueOrders;
      final payments = home.pendingPayments;

      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.pagePadding,
            AppSizes.gapLg,
            AppSizes.pagePadding,
            AppSizes.gapXxl,
          ),
          children: [
            // Slim header: greeting + date. No hero banners.
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('greeting'.tr, style: AppText.display(ur)),
                      const SizedBox(height: 2),
                      Text(formatDate(DateTime.now(), locale),
                          style: AppText.bodySm(ur)),
                    ],
                  ),
                ),
                const LanguageToggleButton(),
              ],
            ),
            const SizedBox(height: AppSizes.gapLg),

            // One hero number — the answer to "what needs me today?"
            HeroCard(
              value: '${dueToday.length}',
              label: 'hero_due_today'.tr,
              sub: 'hero_sub'.trParams({
                'overdue': '${overdue.length}',
                'amount': money('rs'.tr, home.toCollectTotal,
                    locale: locale),
              }),
              onTap: () => nav.goTo(1),
            ),
            const SizedBox(height: AppSizes.gapLg),

            // Primary actions, thumb-sized. One filled primary per screen.
            Row(
              children: [
                QuickActionButton(
                  icon: Icons.add_circle_outline,
                  label: 'qa_new_booking'.tr,
                  filled: true,
                ),
                const SizedBox(width: AppSizes.gapMd),
                QuickActionButton(
                  icon: Icons.payments_outlined,
                  label: 'qa_record_payment'.tr,
                ),
                const SizedBox(width: AppSizes.gapMd),
                QuickActionButton(
                  icon: Icons.person_add_outlined,
                  label: 'qa_add_customer'.tr,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sectionGap),

            // Due today — compact rows, not cards.
            SectionHeader(
              text: 'section_due_today'.tr,
              count: dueToday.length,
              onSeeAll: () => nav.goTo(1),
            ),
            const SizedBox(height: AppSizes.gapMd),
            _RowsCard(
              children:
                  dueToday.map((b) => OrderRow(booking: b)).toList(),
            ),
            const SizedBox(height: AppSizes.sectionGap),

            // Overdue — only when there is something to show.
            if (overdue.isNotEmpty) ...[
              SectionHeader(
                text: 'section_overdue'.tr,
                count: overdue.length,
                onSeeAll: () => nav.goTo(1),
              ),
              const SizedBox(height: AppSizes.gapMd),
              _RowsCard(
                children: overdue
                    .map((b) => OrderRow(booking: b, overdue: true))
                    .toList(),
              ),
              const SizedBox(height: AppSizes.sectionGap),
            ],

            // Pending payments with inline one-tap Remind.
            SectionHeader(
              text: 'pending_payments'.tr,
              count: payments.length,
              onSeeAll: () => nav.goTo(3),
            ),
            const SizedBox(height: AppSizes.gapMd),
            _RowsCard(
              children:
                  payments.map((b) => PaymentRow(booking: b)).toList(),
            ),
          ],
        ),
      );
    });
  }
}

/// Outlined card holding compact rows separated by hairline dividers.
class _RowsCard extends StatelessWidget {
  final List<Widget> children;

  const _RowsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length - 1) items.add(const Divider());
    }
    return Card(child: Column(children: items));
  }
}
