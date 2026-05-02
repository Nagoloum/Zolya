import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override List<Object?> get props => [];
}

class ProductLoadRequested extends ProductEvent {
  final int page;
  final String? category;
  final String? search;
  final int? maxPrice;
  ProductLoadRequested({this.page = 1, this.category, this.search, this.maxPrice});
  @override List<Object?> get props => [page, category, search, maxPrice];
}

class ProductLoadMoreRequested extends ProductEvent {}

class ProductSearchChanged extends ProductEvent {
  final String query;
  ProductSearchChanged({required this.query});
  @override List<Object?> get props => [query];
}

class ProductFilterChanged extends ProductEvent {
  final String? category;
  final int? maxPrice;
  ProductFilterChanged({this.category, this.maxPrice});
  @override List<Object?> get props => [category, maxPrice];
}

class ProductDetailRequested extends ProductEvent {
  final String productId;
  ProductDetailRequested({required this.productId});
  @override List<Object?> get props => [productId];
}
