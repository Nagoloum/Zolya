import 'package:dartz/dartz.dart';
import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/delivery.dart';
import '../../domain/repositories/delivery_repository.dart';
import 'fake_data.dart';

class FakeDeliveryRepository implements DeliveryRepository {
  Future<void> _latency() => Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<Delivery>>> getAvailableDeliveries() async {
    await _latency();
    return Right(FakeData.availableDeliveries);
  }

  @override
  Future<Either<Failure, List<Delivery>>> getMyDeliveries() async {
    await _latency();
    return const Right([]);
  }

  @override
  Future<Either<Failure, Delivery>> acceptDelivery(String deliveryId) async {
    await _latency();
    final match = FakeData.availableDeliveries.where((d) => d.id == deliveryId).toList();
    if (match.isEmpty) return const Left(NotFoundFailure(message: 'Livraison introuvable'));
    return Right(match.first);
  }

  @override
  Future<Either<Failure, Delivery>> updateStatus(String deliveryId, DeliveryStatus status) async {
    await _latency();
    final match = FakeData.availableDeliveries.where((d) => d.id == deliveryId).toList();
    if (match.isEmpty) return const Left(NotFoundFailure(message: 'Livraison introuvable'));
    return Right(match.first);
  }

  @override
  Future<Either<Failure, int>> getWeeklyEarnings() async {
    await _latency();
    return const Right(0);
  }
}
