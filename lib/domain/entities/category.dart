import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String? parentId;
  final String? iconUrl;
  final int sortOrder;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
    this.iconUrl,
    this.sortOrder = 0,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, slug];
}
