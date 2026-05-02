import 'package:equatable/equatable.dart';

enum ProductCondition { neuf, veryGood, good, acceptable }

enum ProductStatus { active, sold, paused, blocked }

class Product extends Equatable {
  final String id;
  final String sellerId;
  final String sellerName;
  final String? sellerAvatarUrl;
  final String? categoryId;
  final String title;
  final String description;
  final int price;
  final String category;
  final String? size;
  final String? brand;
  final String? color;
  final ProductCondition condition;
  final ProductStatus status;
  final List<String> imageUrls;
  final String? videoUrl;
  final int viewsCount;
  final int likesCount;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatarUrl,
    this.categoryId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.size,
    this.brand,
    this.color,
    required this.condition,
    this.status = ProductStatus.active,
    required this.imageUrls,
    this.videoUrl,
    this.viewsCount = 0,
    this.likesCount = 0,
    required this.createdAt,
  });

  bool get isAvailable => status == ProductStatus.active;
  String get mainImageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';

  String get conditionLabel => switch (condition) {
        ProductCondition.neuf => 'Neuf',
        ProductCondition.veryGood => 'Tres bon etat',
        ProductCondition.good => 'Bon etat',
        ProductCondition.acceptable => 'Acceptable',
      };

  @override
  List<Object?> get props => [id, sellerId, title, price, status, condition, imageUrls];
}
