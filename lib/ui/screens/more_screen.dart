import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/placeholder_view.dart';

/// More tab — settings etc. ship in Step 5.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlaceholderView(
        title: 'nav_more'.tr,
        icon: Icons.more_horiz,
      ),
    );
  }
}
