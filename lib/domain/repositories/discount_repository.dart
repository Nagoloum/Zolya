import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/fake/ui_models.dart';

abstract class DiscountRepository {
  Future<Either<Failure, List<DiscountUi>>> getMyDiscounts();
  Future<Either<Failure, DiscountUi>> create({
    required String productId,
    required int discountPercent,
    DateTime? endsAt,
  });
  Future<Either<Failure, void>> remove(String discountId);
}
