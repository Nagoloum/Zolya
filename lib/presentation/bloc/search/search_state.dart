import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.categoryId = 'all',
    this.recents = const <String>[],
    this.results = const <Product>[],
  });

  final String query;
  final String categoryId;
  final List<String> recents;
  final List<Product> results;

  bool get isBrowsing => query.isEmpty && categoryId == 'all';

  SearchState copyWith({
    String? query,
    String? categoryId,
    List<String>? recents,
    List<Product>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      categoryId: categoryId ?? this.categoryId,
      recents: recents ?? this.recents,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [query, categoryId, recents, results];
}
