import '../../domain/entities/delivery.dart';

class DeliveryModel extends Delivery {
  const DeliveryModel({
    required super.id,
    required super.orderId,
    required super.buyerName,
    required super.buyerPhone,
    required super.sellerName,
    required super.sellerPhone,
    required super.pickupAddress,
    required super.dropoffAddress,
    required super.dropoffNeighborhood,
    required super.fee,
    required super.status,
    super.delivererId,
    required super.createdAt,
    super.completedAt,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      buyerName: json['buyer_name'] as String,
      buyerPhone: json['buyer_phone'] as String,
      sellerName: json['seller_name'] as String,
      sellerPhone: json['seller_phone'] as String,
      pickupAddress: json['pickup_address'] as String,
      dropoffAddress: json['dropoff_address'] as String,
      dropoffNeighborhood: json['dropoff_neighborhood'] as String,
      fee: json['fee'] as int,
      status: _statusFromString(json['status'] as String),
      delivererId: json['deliverer_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] != null ? DateTime.parse(json['completed_at'] as String) : null,
    );
  }

  static DeliveryStatus _statusFromString(String s) => switch (s) {
        'assigned' => DeliveryStatus.assigned,
        'picked_up' => DeliveryStatus.pickedUp,
        'in_progress' => DeliveryStatus.inProgress,
        'completed' => DeliveryStatus.completed,
        'failed' => DeliveryStatus.failed,
        _ => DeliveryStatus.available,
      };
}
