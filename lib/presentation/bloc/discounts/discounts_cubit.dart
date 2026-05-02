import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/discount_repository.dart';
import 'discounts_state.dart';

class DiscountsCubit extends Cubit<DiscountsState> {
  DiscountsCubit({required this.repo}) : super(const DiscountsState());

  final DiscountRepository repo;

  Future<void> load() async {
    emit(state.copyWith(loading: true, clearError: true));
    final result = await repo.getMyDiscounts();
    result.fold(
      (f) => emit(state.copyWith(loading: false, error: f.message)),
      (discounts) =>
          emit(state.copyWith(loading: false, discounts: discounts)),
    );
  }

  Future<bool> create({
    required String productId,
    required int discountPercent,
    DateTime? endsAt,
  }) async {
    final result = await repo.create(
      productId: productId,
      discountPercent: discountPercent,
      endsAt: endsAt,
    );
    return result.fold(
      (f) {
        emit(state.copyWith(error: f.message));
        return false;
      },
      (d) {
        emit(state.copyWith(discounts: [d, ...state.discounts]));
        return true;
      },
    );
  }

  Future<void> remove(String discountId) async {
    final next =
        state.discounts.where((d) => d.id != discountId).toList(growable: false);
    emit(state.copyWith(discounts: next));
    final result = await repo.remove(discountId);
    result.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (_) {},
    );
  }
}
