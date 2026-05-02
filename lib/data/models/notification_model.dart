import '../../domain/entities/notification.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.userId,
    required super.type,
    required super.title,
    super.body,
    super.data,
    super.isRead,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        type: _typeFromString(json['type'] as String),
        title: json['title'] as String,
        body: json['body'] as String?,
        data: json['data'] as Map<String, dynamic>?,
        isRead: json['is_read'] as bool? ?? false,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  static NotificationType _typeFromString(String s) => switch (s) {
        'order_paid' => NotificationType.orderPaid,
        'order_assigned' => NotificationType.orderAssigned,
        'order_picked_up' => NotificationType.orderPickedUp,
        'order_delivered' => NotificationType.orderDelivered,
        'new_delivery_available' => NotificationType.newDeliveryAvailable,
        'payment_released' => NotificationType.paymentReleased,
        'dispute_opened' => NotificationType.disputeOpened,
        'dispute_resolved' => NotificationType.disputeResolved,
        _ => NotificationType.system,
      };
}
