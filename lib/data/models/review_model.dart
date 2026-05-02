import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.orderId,
    required super.reviewerId,
    required super.revieweeId,
    required super.role,
    required super.rating,
    super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'] as String,
        orderId: json['order_id'] as String,
        reviewerId: json['reviewer_id'] as String,
        revieweeId: json['reviewee_id'] as String,
        role: _roleFromString(json['role'] as String),
        rating: json['rating'] as int,
        comment: json['comment'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'reviewer_id': reviewerId,
        'reviewee_id': revieweeId,
        'role': role.name,
        'rating': rating,
        'comment': comment,
      };

  static ReviewRole _roleFromString(String s) => switch (s) {
        'seller' => ReviewRole.seller,
        'courier' => ReviewRole.courier,
        _ => ReviewRole.buyer,
      };
}
