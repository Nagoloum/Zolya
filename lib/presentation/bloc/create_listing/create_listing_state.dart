import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/product.dart';

enum CreateListingStatus { editing, submitting, success, failure }

class CreateListingState extends Equatable {
  const CreateListingState({
    this.images = const <XFile>[],
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
  final String? category;
  final ProductCondition condition;
  final String title;
  final String description;
  final String price;
  final String size;
  final CreateListingStatus status;
  final String? errorMessage;

  bool get isSubmitting => status == CreateListingStatus.submitting;

  CreateListingState copyWith({
    List<XFile>? images,
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
