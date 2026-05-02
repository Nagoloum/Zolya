import 'package:equatable/equatable.dart';
import '../../core/constants/delivery_zones.dart';

enum OrderStatus {
  pendingPayment,
  paid,
  awaitingCourier,
  assignedToDeliverer,
  pickedUp,
  inDelivery,
  delivered,
  disputed,
  cancelled,
  refunded,
}

enum PaymentProvider { mtnMomo, orangeMoney }

class DeliveryAddress extends Equatable {
  final String? id;
  final String neighborhood;
  final String street;
  final String? landmark;
  final String phone;
  final DeliveryZone zone;
  final String? instructions;

  const DeliveryAddress({
    this.id,
    required this.neighborhood,
    required this.street,
    this.landmark,
    required this.phone,
    required this.zone,
    this.instructions,
  });

  @override
  List<Object?> get props => [id, neighborhood, street, phone, zone];
}

class Order extends Equatable {
  final String id;
  final String orderNumber;
  final String buyerId;
  final String sellerId;
  final String productId;
  final String productTitle;
  final String productImageUrl;

  final int articlePrice;
  final int deliveryFee;
  final int totalAmount;
  final double commissionRate;
  final int zolyaCommission;
  final int sellerReceives;
  final int courierPayout;

  final OrderStatus status;
  final DeliveryAddress deliveryAddress;

  final String? delivererId;
  final String? delivererName;
  final String? delivererPhone;

  final DateTime createdAt;
  final DateTime? paidAt;
  final DateTime? assignedAt;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final DateTime? releasedAt;
  final DateTime? cancelledAt;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.buyerId,
    required this.sellerId,
    required this.productId,
    required this.productTitle,
    required this.productImageUrl,
    required this.articlePrice,
    required this.deliveryFee,
    required this.totalAmount,
    this.commissionRate = 0.15,
    required this.zolyaCommission,
    required this.sellerReceives,
    this.courierPayout = 500,
    required this.status,
    required this.deliveryAddress,
    this.delivererId,
    this.delivererName,
    this.delivererPhone,
    required this.createdAt,
    this.paidAt,
    this.assignedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.releasedAt,
    this.cancelledAt,
  });

  bool get isActive => ![
        OrderStatus.delivered,
        OrderStatus.cancelled,
        OrderStatus.refunded,
      ].contains(status);

  bool get hasDeliverer => delivererId != null;
  bool get isInEscrow => paidAt != null && releasedAt == null;

  String get statusLabel => switch (status) {
        OrderStatus.pendingPayment => 'En attente de paiement',
        OrderStatus.paid => 'Payé — En attente de livraison',
        OrderStatus.awaitingCourier => 'Recherche d\'un livreur',
        OrderStatus.assignedToDeliverer => 'Pris en charge',
        OrderStatus.pickedUp => 'Colis récupéré',
        OrderStatus.inDelivery => 'En livraison',
        OrderStatus.delivered => 'Livré',
        OrderStatus.disputed => 'Litige en cours',
        OrderStatus.cancelled => 'Annulé',
        OrderStatus.refunded => 'Remboursé',
      };

  @override
  List<Object?> get props => [id, orderNumber, status, totalAmount];
}
