/// Booking model. fromJson/toJson are ready now so the future
/// API layer can parse responses without touching this file's shape.

enum BookingStatus { cutting, stitching, trial, ready, delivered }

class Booking {
  final String id;
  final String customerName;
  final String garment;
  final BookingStatus status;
  final String dueDate;
  final double price;
  final double advance;

  const Booking({
    required this.id,
    required this.customerName,
    required this.garment,
    required this.status,
    required this.dueDate,
    required this.price,
    required this.advance,
  });

  double get balance => price - advance;

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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_name': customerName,
        'garment': garment,
        'status': status.name,
        'due_date': dueDate,
        'price': price,
        'advance': advance,
      };
}
