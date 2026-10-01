/// Customer model. fromJson/toJson are ready now so the future
/// API layer can parse responses without touching this file's shape.

class Customer {
  final String id;
  final String name;
  final String phone;
  final String? address;
  final int totalOrders;
  final double pendingAmount;

  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.totalOrders = 0,
    this.pendingAmount = 0,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String?,
        totalOrders: (json['total_orders'] as num?)?.toInt() ?? 0,
        pendingAmount: (json['pending_amount'] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'total_orders': totalOrders,
        'pending_amount': pendingAmount,
      };
}
