import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/favorite_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.repo}) : super(const FavoritesState());

  final FavoriteRepository repo;

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final result = await repo.getFavorites();
    result.fold(
      (_) => emit(state.copyWith(loading: false)),
      (products) => emit(state.copyWith(
        ids: products.map((p) => p.id).toSet(),
        loading: false,
      )),
    );
  }

  Future<void> toggle(String productId) async {
    final wasFavorite = state.isFavorite(productId);

    final newIds = Set<String>.from(state.ids);
    if (wasFavorite) {
      newIds.remove(productId);
    } else {
      newIds.add(productId);
    }
    emit(state.copyWith(ids: newIds));

    final result = wasFavorite
        ? await repo.removeFavorite(productId)
        : await repo.addFavorite(productId);

    result.fold(
      (_) {
        final rolledBack = Set<String>.from(state.ids);
        if (wasFavorite) {
          rolledBack.add(productId);
        } else {
          rolledBack.remove(productId);
        }
        emit(state.copyWith(ids: rolledBack));
      },
      (_) {},
    );
  }
}
