import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/discount_repository.dart';
import 'fake_data.dart';
import 'ui_models.dart';

class FakeDiscountRepository implements DiscountRepository {
  late final List<DiscountUi> _discounts = FakeData.myDiscounts();

  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<DiscountUi>>> getMyDiscounts() async {
    await _latency();
    return Right(List.unmodifiable(_discounts));
  }

  @override
  Future<Either<Failure, DiscountUi>> create({
    required String productId,
    required int discountPercent,
    DateTime? endsAt,
  }) async {
    await _latency();
    final product = FakeData.products.firstWhere(
      (p) => p.id == productId,
      orElse: () => FakeData.products.first,
    );
    final discounted =
        (product.price * (1 - discountPercent / 100)).round();
    final discount = DiscountUi(
      id: 'd-${DateTime.now().microsecondsSinceEpoch}',
      productId: product.id,
      productTitle: product.title,
      productImageUrl: product.mainImageUrl,
      originalPrice: product.price,
      discountedPrice: discounted,
      discountPercent: discountPercent,
      startedAt: DateTime.now(),
      endsAt: endsAt,
    );
    _discounts.insert(0, discount);
    return Right(discount);
  }

  @override
  Future<Either<Failure, void>> remove(String discountId) async {
    await _latency();
    _discounts.removeWhere((d) => d.id == discountId);
    return const Right(null);
  }
}
