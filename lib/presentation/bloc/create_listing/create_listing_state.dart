import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/product.dart';

enum CreateListingStatus { editing, submitting, success, failure }

class CreateListingState extends Equatable {
  const CreateListingState({
    this.images = const <XFile>[],
    this.existingImageUrls = const <String>[],
    this.editingProductId,
    this.category,
    this.condition = ProductCondition.good,
    this.title = '',
    this.description = '',
    this.price = '',
    this.size = '',
    this.status = CreateListingStatus.editing,
    this.errorMessage,
  });

  final List<XFile> images;

  /// URLs des photos déjà publiées (mode édition) — affichées en lecture seule.
  final List<String> existingImageUrls;

  /// Non nul si l'on édite une annonce existante.
  final String? editingProductId;
  final String? category;
  final ProductCondition condition;
  final String title;
  final String description;
  final String price;
  final String size;
  final CreateListingStatus status;
  final String? errorMessage;

  bool get isSubmitting => status == CreateListingStatus.submitting;
  bool get isEditing => editingProductId != null;

  CreateListingState copyWith({
    List<XFile>? images,
    List<String>? existingImageUrls,
    String? editingProductId,
    String? category,
    bool clearCategory = false,
    ProductCondition? condition,
    String? title,
    String? description,
    String? price,
    String? size,
    CreateListingStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CreateListingState(
      images: images ?? this.images,
      existingImageUrls: existingImageUrls ?? this.existingImageUrls,
      editingProductId: editingProductId ?? this.editingProductId,
      category: clearCategory ? null : (category ?? this.category),
      condition: condition ?? this.condition,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      size: size ?? this.size,
      status: status ?? this.status,
      errorMessage:
          clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        images,
        existingImageUrls,
        editingProductId,
        category,
        condition,
        title,
        description,
        price,
        size,
        status,
        errorMessage,
      ];
}
