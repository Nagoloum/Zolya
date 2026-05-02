import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/product.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState(recents: FakeData.recentSearches));

  void setQuery(String value) {
    emit(state.copyWith(query: value.trim()));
  }

  void setCategory(String id) {
    emit(state.copyWith(categoryId: id));
  }

  void rememberSearch(String value) {
    final v = value.trim();
    if (v.isEmpty) return;
    final updated = [v, ...state.recents.where((r) => r != v)].take(10).toList();
    emit(state.copyWith(recents: updated));
  }

  void removeRecent(String value) {
    emit(state.copyWith(
      recents: state.recents.where((r) => r != value).toList(),
    ));
  }

  void clearRecents() {
    emit(state.copyWith(recents: const []));
  }

  List<Product> filter(List<Product> products) {
    final q = state.query.toLowerCase();
    return products.where((p) {
      final categoryOk =
          state.categoryId == 'all' || p.category == state.categoryId;
      if (!categoryOk) return false;
      if (q.isEmpty) return true;
      return p.title.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          (p.brand ?? '').toLowerCase().contains(q);
    }).toList();
  }
}
