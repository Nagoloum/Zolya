import 'package:equatable/equatable.dart';

enum ReviewRole { seller, buyer, courier }

class Review extends Equatable {
  final String id;
  final String orderId;
  final String reviewerId;
  final String revieweeId;
  final ReviewRole role;
  final int rating;
  final String? comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.orderId,
    required this.reviewerId,
    required this.revieweeId,
    required this.role,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, orderId, reviewerId, role, rating];
}
