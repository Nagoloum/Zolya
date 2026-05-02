import '../../domain/entities/courier_payout.dart';

class CourierPayoutModel extends CourierPayout {
  const CourierPayoutModel({
    required super.id,
    required super.courierId,
    required super.weekStart,
    required super.weekEnd,
    required super.deliveriesCount,
    required super.ratePerDelivery,
    required super.totalAmount,
    super.status,
    super.paidAt,
  });

  factory CourierPayoutModel.fromJson(Map<String, dynamic> json) => CourierPayoutModel(
        id: json['id'] as String,
        courierId: json['courier_id'] as String,
        weekStart: DateTime.parse(json['week_start'] as String),
        weekEnd: DateTime.parse(json['week_end'] as String),
        deliveriesCount: json['deliveries_count'] as int,
        ratePerDelivery: json['rate_per_delivery'] as int,
        totalAmount: json['total_amount'] as int,
        status: (json['status'] as String? ?? 'pending') == 'paid'
            ? CourierPayoutStatus.paid
            : CourierPayoutStatus.pending,
        paidAt: json['paid_at'] != null
            ? DateTime.parse(json['paid_at'] as String)
            : null,
      );
}
