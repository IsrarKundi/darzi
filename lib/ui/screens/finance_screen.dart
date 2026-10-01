import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/placeholder_view.dart';

/// Finance tab — ships in Step 4.
class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlaceholderView(
        title: 'nav_finance'.tr,
        icon: Icons.account_balance_wallet_outlined,
      ),
    );
  }
}
