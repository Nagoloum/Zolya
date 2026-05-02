import 'package:dartz/dartz.dart' hide Order;
import '../../core/errors/failures.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, Order>> createOrder({
    required String productId,
    required DeliveryAddress deliveryAddress,
  });
  Future<Either<Failure, Order>> getOrderById(String id);
  Future<Either<Failure, List<Order>>> getMyOrders();
  Future<Either<Failure, List<Order>>> getMySales();
  Future<Either<Failure, void>> reportIssue(String orderId, String reason);
}
