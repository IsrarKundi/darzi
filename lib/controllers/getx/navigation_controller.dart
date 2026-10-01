import 'package:get/get.dart';

/// Owns bottom-navigation state. Screens never touch Navigator directly.
class NavigationController extends GetxController {
  final tabIndex = 0.obs;

  void goTo(int index) => tabIndex.value = index;
}
