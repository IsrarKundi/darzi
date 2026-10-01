import 'package:get/get.dart';

import '../../models/booking.dart';

/// Home screen state. Seed data lives here (UI-only phase).
/// Later: replace seeds with calls to an ApiService — screens stay unchanged.
///
/// Seed "today" is Oct 2 (see [todayLabel]). The curation getters below
/// stand in for real due-date filtering until the API exists.
class HomeController extends GetxController {
  /// Display label of the seeded "today". Production: use DateTime.now().
  static const todayLabel = 'Oct 2';

  final bookings = <Booking>[
    Booking(
      id: 'b1',
      customerName: 'Ahmed Raza',
      garment: 'Shalwar Kameez',
      status: BookingStatus.cutting,
      dueDate: 'Oct 1',
      price: 4500,
      advance: 2000,
    ),
    Booking(
      id: 'b2',
      customerName: 'Bilal Hussain',
      garment: 'Waistcoat Set',
      status: BookingStatus.stitching,
      dueDate: 'Oct 6',
      price: 8000,
      advance: 4000,
    ),
    Booking(
      id: 'b3',
      customerName: 'Usman Tariq',
      garment: 'Kurta Pajama',
      status: BookingStatus.ready,
      dueDate: 'Oct 2',
      price: 3200,
      advance: 3200,
    ),
    Booking(
      id: 'b4',
      customerName: 'Danish Ali',
      garment: 'Sherwani',
      status: BookingStatus.trial,
      dueDate: 'Oct 8',
      price: 15000,
      advance: 5000,
    ),
    Booking(
      id: 'b5',
      customerName: 'Sajid Mehmood',
      garment: 'Kurta',
      status: BookingStatus.stitching,
      dueDate: 'Oct 2',
      price: 2800,
      advance: 1000,
    ),
    Booking(
      id: 'b6',
      customerName: 'Tariq Aziz',
      garment: 'Shalwar Kameez',
      status: BookingStatus.cutting,
      dueDate: 'Sep 30',
      price: 4500,
      advance: 1500,
    ),
    Booking(
      id: 'b7',
      customerName: 'Faisal Raza',
      garment: 'Shalwar Kameez',
      status: BookingStatus.delivered,
      dueDate: 'Oct 1',
      price: 5000,
      advance: 5000,
      completedDate: 'Oct 2',
    ),
    Booking(
      id: 'b8',
      customerName: 'Imran Sheikh',
      garment: 'Kurta Shalwar',
      status: BookingStatus.ready,
      dueDate: 'Oct 3',
      price: 3800,
      advance: 1000,
    ),
  ].obs;

  /// Work still in progress and due today.
  List<Booking> get dueTodayOrders => bookings
      .where((b) => b.isWorkStatus && b.dueDate == todayLabel)
      .toList();

  /// Work in progress past its due date
  /// (seed curation; production: filter by date).
  List<Booking> get overdueOrders => bookings
      .where((b) => b.isWorkStatus && (b.id == 'b1' || b.id == 'b6'))
      .toList();

  /// Finished suits waiting in the shop for customer pickup.
  List<Booking> get readyOrders =>
      bookings.where((b) => b.status == BookingStatus.ready).toList();

  /// Orders handed over today.
  List<Booking> get completedTodayOrders => bookings
      .where((b) =>
          b.status == BookingStatus.delivered &&
          b.completedDate == todayLabel)
      .toList();

  /// Work in progress due after today
  /// (seed curation; production: filter by date).
  List<Booking> get upcomingOrders => bookings
      .where((b) => b.isWorkStatus && (b.id == 'b2' || b.id == 'b4'))
      .toList();

  /// All orders still being worked on (cutting/stitching/trial).
  List<Booking> get inProgressOrders =>
      bookings.where((b) => b.isWorkStatus).toList();

  /// Finished and handed over.
  List<Booking> get deliveredOrders =>
      bookings.where((b) => b.status == BookingStatus.delivered).toList();

  /// Money still to collect across [orders].
  double pendingFor(List<Booking> orders) =>
      orders.fold(0, (sum, b) => sum + b.balance);

  /// Balances still owed, largest first.
  List<Booking> get pendingPayments {
    final list = bookings.where((b) => b.balance > 0).toList();
    list.sort((a, b) => b.balance.compareTo(a.balance));
    return list;
  }

  double get toCollectTotal =>
      pendingPayments.fold(0, (sum, b) => sum + b.balance);

  /// Demo action: hand the suit to the customer. Moves the order
  /// out of "ready for pickup" and into today's completed count.
  void markDelivered(Booking booking) {
    booking.status = BookingStatus.delivered;
    booking.completedDate = todayLabel;
    bookings.refresh();
    Get.snackbar('', 'marked_delivered'.tr,
        snackPosition: SnackPosition.BOTTOM);
  }
}
