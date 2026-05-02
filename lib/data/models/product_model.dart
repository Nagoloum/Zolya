import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.sellerId,
    required super.sellerName,
    super.sellerAvatarUrl,
    super.categoryId,
    required super.title,
    required super.description,
    required super.price,
    required super.category,
    super.size,
    super.brand,
    super.color,
    required super.condition,
    super.status,
    required super.imageUrls,
    super.videoUrl,
    super.viewsCount,
    super.likesCount,
    required super.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      sellerId: json['seller_id'] as String,
      sellerName: json['seller_name'] as String? ?? '',
      sellerAvatarUrl: json['seller_avatar_url'] as String?,
      categoryId: json['category_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      category: json['category'] as String? ?? '',
      size: json['size'] as String?,
      brand: json['brand'] as String?,
      color: json['color'] as String?,
      condition: _conditionFromString(json['condition'] as String),
      status: _statusFromString(json['status'] as String? ?? 'active'),
      imageUrls: List<String>.from((json['image_urls'] ?? json['photos'] ?? []) as List),
      videoUrl: json['video_url'] as String?,
      viewsCount: json['views_count'] as int? ?? 0,
      likesCount: json['likes_count'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'seller_id': sellerId,
        'category_id': categoryId,
        'title': title,
        'description': description,
        'price': price,
        'size': size,
        'brand': brand,
        'color': color,
        'condition': _conditionToString(condition),
        'status': status.name,
        'video_url': videoUrl,
      };

  static ProductCondition _conditionFromString(String s) => switch (s) {
        'very_good' || 'veryGood' => ProductCondition.veryGood,
        'good' => ProductCondition.good,
        'acceptable' => ProductCondition.acceptable,
        _ => ProductCondition.neuf,
      };

  static String _conditionToString(ProductCondition c) => switch (c) {
        ProductCondition.neuf => 'neuf',
        ProductCondition.veryGood => 'very_good',
        ProductCondition.good => 'good',
        ProductCondition.acceptable => 'acceptable',
      };

  static ProductStatus _statusFromString(String s) => switch (s) {
        'sold' => ProductStatus.sold,
        'paused' || 'pending' => ProductStatus.paused,
        'blocked' || 'removed' => ProductStatus.blocked,
        _ => ProductStatus.active,
      };
}
