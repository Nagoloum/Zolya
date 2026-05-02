import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.parentId,
    super.iconUrl,
    super.sortOrder,
    super.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as String,
        name: json['name'] as String,
        slug: json['slug'] as String,
        parentId: json['parent_id'] as String?,
        iconUrl: json['icon_url'] as String?,
        sortOrder: json['sort_order'] as int? ?? 0,
        isActive: json['is_active'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'parent_id': parentId,
        'icon_url': iconUrl,
        'sort_order': sortOrder,
        'is_active': isActive,
      };
}
