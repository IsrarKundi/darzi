import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx/language_controller.dart';
import '../../controllers/getx/navigation_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import 'bookings_screen.dart';
import 'customers_screen.dart';
import 'finance_screen.dart';
import 'home_screen.dart';
import 'more_screen.dart';

/// Bottom-navigation shell. Owns the 5 tabs; content per tab lives in
/// ui/screens/. State via NavigationController (no Navigator calls here).
class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationController>();
    const pages = [
      HomeScreen(),
      BookingsScreen(),
      CustomersScreen(),
      FinanceScreen(),
      MoreScreen(),
    ];
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: nav.tabIndex.value, children: pages),
        // Capsule "New Booking" action — home tab only. Customer
        // creation happens inside the booking flow, so no separate
        // add-customer / record-payment buttons on home.
        floatingActionButton: nav.tabIndex.value == 0
            ? FloatingActionButton.extended(
                onPressed: () => Get.snackbar('', 'coming_step2'.tr,
                    snackPosition: SnackPosition.BOTTOM),
                shape: const StadiumBorder(),
                backgroundColor: AppColors.brand700,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add),
                label: Text(
                  'qa_new_booking'.tr,
                  style: AppText.button(
                      Get.find<LanguageController>().isUrdu,
                      color: Colors.white),
                ),
              )
            : null,
        // M3 NavigationBar: labels always visible (icon + text pairs —
        // icons alone are mystery-meat navigation for this audience).
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          child: NavigationBar(
            selectedIndex: nav.tabIndex.value,
            onDestinationSelected: nav.goTo,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: 'nav_home'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.calendar_month_outlined),
                selectedIcon: const Icon(Icons.calendar_month),
                label: 'nav_bookings'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.people_outline),
                selectedIcon: const Icon(Icons.people),
                label: 'nav_customers'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: const Icon(Icons.account_balance_wallet),
                label: 'nav_finance'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.more_horiz),
                label: 'nav_more'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
