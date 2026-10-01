/// Booking model. fromJson/toJson are ready now so the future
/// API layer can parse responses without touching this file's shape.
///
/// `status` and `completedDate` are mutable on purpose: the dummy
/// frontend mutates them in-memory (e.g. mark delivered). The API
/// phase will replace mutation with fresh objects from responses.

enum BookingStatus { cutting, stitching, trial, ready, delivered }

class Booking {
  final String id;
  final String customerName;
  final String garment;
  BookingStatus status;
  final String dueDate;
  final double price;
  final double advance;

  /// Display label of the day the order was delivered ('Oct 2').
  /// Null until delivered. Production: real date filtering.
  String? completedDate;

  Booking({
    required this.id,
    required this.customerName,
    required this.garment,
    required this.status,
    required this.dueDate,
    required this.price,
    required this.advance,
    this.completedDate,
  });

  double get balance => price - advance;

  /// Still being worked on (not ready, not delivered).
  bool get isWorkStatus =>
      status == BookingStatus.cutting ||
      status == BookingStatus.stitching ||
      status == BookingStatus.trial;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as String,
        customerName: json['customer_name'] as String,
        garment: json['garment'] as String,
        status: BookingStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => BookingStatus.cutting,
        ),
        dueDate: json['due_date'] as String,
        price: (json['price'] as num).toDouble(),
        advance: (json['advance'] as num).toDouble(),
        completedDate: json['completed_date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_name': customerName,
        'garment': garment,
        'status': status.name,
        'due_date': dueDate,
        'price': price,
        'advance': advance,
        'completed_date': completedDate,
      };
}
