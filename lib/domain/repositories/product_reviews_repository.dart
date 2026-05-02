import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/fake/ui_models.dart';

abstract class ProductReviewsRepository {
  Future<Either<Failure, ProductRatingSummary>> getSummary(String productId);
  Future<Either<Failure, List<ReviewItemData>>> getReviews(String productId);
}
