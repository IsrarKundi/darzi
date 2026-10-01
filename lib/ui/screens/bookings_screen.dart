import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/placeholder_view.dart';

/// Bookings tab — full booking list ships in Step 2.
class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlaceholderView(
        title: 'nav_bookings'.tr,
        icon: Icons.calendar_month_outlined,
      ),
    );
  }
}
