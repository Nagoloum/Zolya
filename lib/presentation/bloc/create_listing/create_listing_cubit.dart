import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/product.dart';
import 'create_listing_state.dart';

class CreateListingCubit extends Cubit<CreateListingState> {
  CreateListingCubit() : super(const CreateListingState());

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
    if (state.images.isEmpty) return 'Ajoutez au moins une photo';
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
    emit(state.copyWith(status: CreateListingStatus.success));
  }
}
