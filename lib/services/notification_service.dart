import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _plugin.initialize(settings);
  }

  Future<void> showOrderNotification({required String title, required String body}) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'orders_channel',
        'Commandes',
        channelDescription: 'Notifications de commandes',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(0, title, body, details);
  }

  Future<void> showDeliveryNotification({required String title, required String body}) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'delivery_channel',
        'Livraisons',
        channelDescription: 'Notifications de livraison',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(1, title, body, details);
  }

  Future<void> showPaymentNotification({required String title, required String body}) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'payment_channel',
        'Paiements',
        channelDescription: 'Notifications de paiement',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(2, title, body, details);
  }
}
