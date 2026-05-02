import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/product_reviews_repository.dart';
import 'fake_data.dart';
import 'ui_models.dart';

class FakeProductReviewsRepository implements ProductReviewsRepository {
  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, ProductRatingSummary>> getSummary(
      String productId) async {
    await _latency();
    return Right(FakeData.ratingSummaryFor(productId));
  }

  @override
  Future<Either<Failure, List<ReviewItemData>>> getReviews(
      String productId) async {
    await _latency();
    return Right(FakeData.reviewsFor(productId));
  }
}
