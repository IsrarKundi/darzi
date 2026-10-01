import 'package:get/get.dart';

import '../../models/booking.dart';

/// Home screen state. Seed data lives here (Step 1, UI-only).
/// Later: replace seeds with calls to an ApiService — screens stay unchanged.
class HomeController extends GetxController {
  final bookings = <Booking>[
    const Booking(
      id: 'b1',
      customerName: 'Ahmed Raza',
      garment: 'Shalwar Kameez',
      status: BookingStatus.cutting,
      dueDate: 'Oct 5',
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
      dueDate: 'Oct 4',
      price: 3200,
      advance: 3200,
    ),
  ].obs;

  final pendingPayments = <Booking>[
    const Booking(
      id: 'b1',
      customerName: 'Ahmed Raza',
      garment: 'Shalwar Kameez',
      status: BookingStatus.cutting,
      dueDate: 'Oct 5',
      price: 4500,
      advance: 2000,
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
  ].obs;

  int get inProgressCount => bookings
      .where((b) =>
          b.status == BookingStatus.cutting ||
          b.status == BookingStatus.stitching)
      .length;

  double get pendingTotal =>
      pendingPayments.fold(0, (sum, b) => sum + b.balance);
}
