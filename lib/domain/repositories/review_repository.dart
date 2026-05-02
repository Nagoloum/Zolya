import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, Review>> leaveReview({
    required String orderId,
    required String revieweeId,
    required ReviewRole role,
    required int rating,
    String? comment,
  });
  Future<Either<Failure, List<Review>>> getReviewsFor(String userId);
}
