import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/delivery.dart';

abstract class DeliveryRepository {
  Future<Either<Failure, List<Delivery>>> getAvailableDeliveries();
  Future<Either<Failure, List<Delivery>>> getMyDeliveries();
  Future<Either<Failure, Delivery>> acceptDelivery(String deliveryId);
  Future<Either<Failure, Delivery>> updateStatus(String deliveryId, DeliveryStatus status);
  Future<Either<Failure, int>> getWeeklyEarnings();
}
