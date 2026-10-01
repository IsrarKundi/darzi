import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/placeholder_view.dart';

/// Customers tab — ships in Step 3.
class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlaceholderView(
        title: 'nav_customers'.tr,
        icon: Icons.people_outline,
      ),
    );
  }
}
