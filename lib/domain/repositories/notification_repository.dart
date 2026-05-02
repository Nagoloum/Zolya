import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<AppNotification>>> getMyNotifications();
  Future<Either<Failure, void>> markAsRead(String id);
  Future<Either<Failure, void>> markAllRead();
  Future<Either<Failure, void>> registerDeviceToken(String token, String platform);
}
