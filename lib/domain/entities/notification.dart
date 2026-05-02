import 'package:equatable/equatable.dart';

enum NotificationType {
  orderPaid,
  orderAssigned,
  orderPickedUp,
  orderDelivered,
  newDeliveryAvailable,
  paymentReleased,
  disputeOpened,
  disputeResolved,
  system,
}

class AppNotification extends Equatable {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String? body;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    this.body,
    this.data,
    this.isRead = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, type, isRead, createdAt];
}
