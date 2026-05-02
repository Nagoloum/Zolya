import 'package:equatable/equatable.dart';

import '../../../data/fake/ui_models.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsLoaded extends ReviewsState {
  const ReviewsLoaded({
    required this.productId,
    required this.summary,
    required this.reviews,
  });
  final String productId;
  final ProductRatingSummary summary;
  final List<ReviewItemData> reviews;

  @override
  List<Object?> get props => [productId, summary, reviews];
}

class ReviewsError extends ReviewsState {
  const ReviewsError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}
