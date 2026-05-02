import 'package:dartz/dartz.dart' hide Order;
import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import 'fake_data.dart';

class FakeOrderRepository implements OrderRepository {
  Future<void> _latency() => Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, Order>> createOrder({
    required String productId,
    required DeliveryAddress deliveryAddress,
  }) async {
    await _latency();

    if (FakeData.myPurchases.isEmpty) {
      return const Left(ServerFailure(message: 'Commande indisponible en mode demo'));
    }
    return Right(FakeData.myPurchases.first);
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String id) async {
    await _latency();
    final match = FakeData.myPurchases.where((o) => o.id == id).toList();
    if (match.isEmpty) return const Left(NotFoundFailure(message: 'Commande introuvable'));
    return Right(match.first);
  }

  @override
  Future<Either<Failure, List<Order>>> getMyOrders() async {
    await _latency();
    return Right(FakeData.myPurchases);
  }

  @override
  Future<Either<Failure, List<Order>>> getMySales() async {
    await _latency();
    return Right(FakeData.mySales);
  }

  @override
  Future<Either<Failure, void>> reportIssue(String orderId, String reason) async {
    await _latency();
    return const Right(null);
  }
}
