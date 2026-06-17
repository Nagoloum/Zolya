import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/product.dart';
import 'create_listing_state.dart';

class CreateListingCubit extends Cubit<CreateListingState> {
  CreateListingCubit({Product? editProduct})
      : super(_seed(editProduct));

  static CreateListingState _seed(Product? p) {
    if (p == null) return const CreateListingState();
    return CreateListingState(
      editingProductId: p.id,
      existingImageUrls: p.imageUrls,
      category: p.category,
      condition: p.condition,
      title: p.title,
      description: p.description,
      price: p.price.toString(),
      size: p.size ?? '',
    );
  }

  final _picker = ImagePicker();

  Future<void> pickImages() async {
    if (state.images.length >= AppConstants.maxProductImages) return;
    final picked = await _picker.pickMultiImage(imageQuality: 80);
    final remaining = AppConstants.maxProductImages - state.images.length;
    emit(state.copyWith(
      images: [...state.images, ...picked.take(remaining)],
    ));
  }

  void removeImage(int index) {
    final next = [...state.images]..removeAt(index);
    emit(state.copyWith(images: next));
  }

  void setCategory(String? id) =>
      emit(state.copyWith(category: id, clearCategory: id == null));
  void setCondition(ProductCondition c) =>
      emit(state.copyWith(condition: c));
  void setTitle(String v) => emit(state.copyWith(title: v));
  void setDescription(String v) => emit(state.copyWith(description: v));
  void setPrice(String v) => emit(state.copyWith(price: v));
  void setSize(String v) => emit(state.copyWith(size: v));

  String? validate() {
    // En édition, les photos déjà publiées suffisent.
    final hasPhotos =
        state.images.isNotEmpty || state.existingImageUrls.isNotEmpty;
    if (!hasPhotos) return 'Ajoutez au moins une photo';
    if (state.category == null) return 'Sélectionnez une catégorie';
    if (state.title.trim().isEmpty) return 'Le titre est requis';
    if (state.description.trim().isEmpty) return 'La description est requise';
    final priceVal = int.tryParse(state.price.trim());
    if (priceVal == null || priceVal <= 0) {
      return 'Le prix doit être un nombre positif';
    }
    return null;
  }

  Future<void> submit() async {
    final err = validate();
    if (err != null) {
      emit(state.copyWith(
        status: CreateListingStatus.failure,
        errorMessage: err,
      ));
      return;
    }
    emit(state.copyWith(status: CreateListingStatus.submitting));

    await Future.delayed(const Duration(milliseconds: 600));

    // Mode édition : persiste les changements dans FakeData.
    if (state.isEditing) {
      FakeData.updateProduct(
        state.editingProductId!,
        title: state.title.trim(),
        description: state.description.trim(),
        price: int.parse(state.price.trim()),
        category: state.category!,
        condition: state.condition,
        size: state.size.trim().isEmpty ? null : state.size.trim(),
      );
    }

    emit(state.copyWith(status: CreateListingStatus.success));
  }
}
