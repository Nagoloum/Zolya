import 'package:equatable/equatable.dart';

enum DeliveryStatus { available, assigned, pickedUp, inProgress, completed, failed }

class Delivery extends Equatable {
  final String id;
  final String orderId;
  final String buyerName;
  final String buyerPhone;
  final String sellerName;
  final String sellerPhone;
  final String pickupAddress;
  final String dropoffAddress;
  final String dropoffNeighborhood;
  final int fee;
  final DeliveryStatus status;
  final String? delivererId;
  final DateTime createdAt;
  final DateTime? completedAt;

  const Delivery({
    required this.id,
    required this.orderId,
    required this.buyerName,
    required this.buyerPhone,
    required this.sellerName,
    required this.sellerPhone,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.dropoffNeighborhood,
    required this.fee,
    required this.status,
    this.delivererId,
    required this.createdAt,
    this.completedAt,
  });

  String get statusLabel => switch (status) {
        DeliveryStatus.available => 'Disponible',
        DeliveryStatus.assigned => 'Assignée',
        DeliveryStatus.pickedUp => 'Colis récupéré',
        DeliveryStatus.inProgress => 'En cours',
        DeliveryStatus.completed => 'Terminée',
        DeliveryStatus.failed => 'Échouée',
      };

  @override
  List<Object?> get props => [id, orderId, status, delivererId];
}
