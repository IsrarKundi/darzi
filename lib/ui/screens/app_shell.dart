import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/getx/navigation_controller.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
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
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          child: BottomNavigationBar(
            currentIndex: nav.tabIndex.value,
            onTap: nav.goTo,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.surface,
            selectedItemColor: AppColors.brand700,
            unselectedItemColor: AppColors.ink400,
            selectedFontSize: AppSizes.navLabelSize,
            unselectedFontSize: AppSizes.navLabelSize,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: 'nav_home'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month_outlined),
                activeIcon: const Icon(Icons.calendar_month),
                label: 'nav_bookings'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.people_outline),
                activeIcon: const Icon(Icons.people),
                label: 'nav_customers'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_balance_wallet_outlined),
                activeIcon: const Icon(Icons.account_balance_wallet),
                label: 'nav_finance'.tr,
              ),
              BottomNavigationBarItem(
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
