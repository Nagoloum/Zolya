import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/product_reviews_repository.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit({required this.repo}) : super(const ReviewsInitial());

  final ProductReviewsRepository repo;

  Future<void> load(String productId) async {
    emit(const ReviewsLoading());
    final summaryResult = await repo.getSummary(productId);
    final reviewsResult = await repo.getReviews(productId);

    final maybeError =
        summaryResult.swap().toOption().fold(() => null, (f) => f) ??
            reviewsResult.swap().toOption().fold(() => null, (f) => f);
    if (maybeError != null) {
      emit(ReviewsError(message: maybeError.toString()));
      return;
    }

    emit(ReviewsLoaded(
      productId: productId,
      summary: summaryResult.getOrElse(() => throw StateError('unreachable')),
      reviews: reviewsResult.getOrElse(() => throw StateError('unreachable')),
    ));
  }
}
