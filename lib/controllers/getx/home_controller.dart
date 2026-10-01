import 'package:get/get.dart';

import '../../models/booking.dart';

/// Home screen state. Seed data lives here (UI-only phase).
/// Later: replace seeds with calls to an ApiService — screens stay unchanged.
///
/// Seed "today" is Oct 2: b3/b5 due today, b1/b6 overdue. The curation
/// getters below stand in for real due-date filtering until the API exists.
class HomeController extends GetxController {
  final bookings = <Booking>[
    const Booking(
      id: 'b1',
      customerName: 'Ahmed Raza',
      garment: 'Shalwar Kameez',
      status: BookingStatus.cutting,
      dueDate: 'Oct 1',
      price: 4500,
      advance: 2000,
    ),
    const Booking(
      id: 'b2',
      customerName: 'Bilal Hussain',
      garment: 'Waistcoat Set',
      status: BookingStatus.stitching,
      dueDate: 'Oct 6',
      price: 8000,
      advance: 4000,
    ),
    const Booking(
      id: 'b3',
      customerName: 'Usman Tariq',
      garment: 'Kurta Pajama',
      status: BookingStatus.ready,
      dueDate: 'Oct 2',
      price: 3200,
      advance: 3200,
    ),
    const Booking(
      id: 'b4',
      customerName: 'Danish Ali',
      garment: 'Sherwani',
      status: BookingStatus.trial,
      dueDate: 'Oct 8',
      price: 15000,
      advance: 5000,
    ),
    const Booking(
      id: 'b5',
      customerName: 'Sajid Mehmood',
      garment: 'Kurta',
      status: BookingStatus.stitching,
      dueDate: 'Oct 2',
      price: 2800,
      advance: 1000,
    ),
    const Booking(
      id: 'b6',
      customerName: 'Tariq Aziz',
      garment: 'Shalwar Kameez',
      status: BookingStatus.cutting,
      dueDate: 'Sep 30',
      price: 4500,
      advance: 1500,
    ),
  ].obs;

  /// Orders past their due date (seed curation; production: filter by date).
  List<Booking> get overdueOrders =>
      bookings.where((b) => b.id == 'b1' || b.id == 'b6').toList();

  /// Orders due today (seed curation; production: filter by date).
  List<Booking> get dueTodayOrders =>
      bookings.where((b) => b.id == 'b3' || b.id == 'b5').toList();

  /// Balances still owed, largest first.
  List<Booking> get pendingPayments {
    final list = bookings.where((b) => b.balance > 0).toList();
    list.sort((a, b) => b.balance.compareTo(a.balance));
    return list;
  }

  double get toCollectTotal =>
      pendingPayments.fold(0, (sum, b) => sum + b.balance);
}
