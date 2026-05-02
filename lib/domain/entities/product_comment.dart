import 'package:equatable/equatable.dart';

class ProductComment extends Equatable {
  const ProductComment({
    required this.id,
    required this.productId,
    required this.authorId,
    required this.authorName,
    this.authorAvatarUrl,
    required this.text,
    this.rating = 0,
    required this.createdAt,
  });

  final String id;
  final String productId;
  final String authorId;
  final String authorName;
  final String? authorAvatarUrl;
  final String text;
  final int rating;
  final DateTime createdAt;

  @override
  List<Object?> get props =>
      [id, productId, authorId, text, rating, createdAt];
}
