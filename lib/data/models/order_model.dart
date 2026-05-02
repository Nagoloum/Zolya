import '../../core/constants/delivery_zones.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.buyerId,
    required super.sellerId,
    required super.productId,
    required super.productTitle,
    required super.productImageUrl,
    required super.articlePrice,
    required super.deliveryFee,
    required super.totalAmount,
    super.commissionRate,
    required super.zolyaCommission,
    required super.sellerReceives,
    super.courierPayout,
    required super.status,
    required super.deliveryAddress,
    super.delivererId,
    super.delivererName,
    super.delivererPhone,
    required super.createdAt,
    super.paidAt,
    super.assignedAt,
    super.pickedUpAt,
    super.deliveredAt,
    super.releasedAt,
    super.cancelledAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final addrJson = json['delivery_address'] as Map<String, dynamic>? ?? {};
    return OrderModel(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String? ?? '',
      buyerId: json['buyer_id'] as String,
      sellerId: json['seller_id'] as String,
      productId: (json['item_id'] ?? json['product_id']) as String,
      productTitle: json['product_title'] as String? ?? '',
      productImageUrl: json['product_image_url'] as String? ?? '',
      articlePrice: json['item_price'] as int? ?? json['article_price'] as int? ?? 0,
      deliveryFee: json['delivery_fee'] as int,
      totalAmount: json['total_amount'] as int,
      commissionRate: (json['commission_rate'] as num?)?.toDouble() ?? 0.15,
      zolyaCommission: json['commission_amount'] as int? ?? json['zolya_commission'] as int? ?? 0,
      sellerReceives: json['seller_payout'] as int? ?? json['seller_receives'] as int? ?? 0,
      courierPayout: json['courier_payout'] as int? ?? 500,
      status: _statusFromString(json['status'] as String),
      deliveryAddress: DeliveryAddress(
        id: addrJson['id'] as String?,
        neighborhood: addrJson['neighborhood'] as String? ?? '',
        street: addrJson['street'] as String? ?? '',
        landmark: addrJson['landmark'] as String?,
        phone: (addrJson['phone_contact'] ?? addrJson['phone']) as String? ?? '',
        zone: _zoneFromCode(addrJson['zone_code'] as String? ?? addrJson['zone'] as String? ?? 'zone1'),
        instructions: addrJson['instructions'] as String?,
      ),
      delivererId: json['courier_id'] as String? ?? json['deliverer_id'] as String?,
      delivererName: json['deliverer_name'] as String?,
      delivererPhone: json['deliverer_phone'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      paidAt: _parse(json['paid_at']),
      assignedAt: _parse(json['assigned_at']),
      pickedUpAt: _parse(json['picked_up_at']),
      deliveredAt: _parse(json['delivered_at']),
      releasedAt: _parse(json['released_at']),
      cancelledAt: _parse(json['cancelled_at']),
    );
  }

  static DateTime? _parse(dynamic v) =>
      v != null ? DateTime.parse(v as String) : null;

  static DeliveryZone _zoneFromCode(String code) => switch (code) {
        'zone2' => DeliveryZone.zone2,
        'zone3' => DeliveryZone.zone3,
        _ => DeliveryZone.zone1,
      };

  static OrderStatus _statusFromString(String s) => switch (s) {
        'paid' => OrderStatus.paid,
        'awaiting_courier' => OrderStatus.awaitingCourier,
        'assigned_to_deliverer' => OrderStatus.assignedToDeliverer,
        'picked_up' => OrderStatus.pickedUp,
        'in_delivery' => OrderStatus.inDelivery,
        'delivered' => OrderStatus.delivered,
        'disputed' => OrderStatus.disputed,
        'cancelled' => OrderStatus.cancelled,
        'refunded' => OrderStatus.refunded,
        _ => OrderStatus.pendingPayment,
      };
}
