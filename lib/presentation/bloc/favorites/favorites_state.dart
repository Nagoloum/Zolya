import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.ids = const <String>{}, this.loading = false});

  final Set<String> ids;
  final bool loading;

  bool isFavorite(String productId) => ids.contains(productId);

  FavoritesState copyWith({Set<String>? ids, bool? loading}) {
    return FavoritesState(
      ids: ids ?? this.ids,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [ids, loading];
}
