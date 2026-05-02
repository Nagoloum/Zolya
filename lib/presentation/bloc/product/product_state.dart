import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  @override List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasMore;
  final int currentPage;
  ProductLoaded({required this.products, this.hasMore = true, this.currentPage = 1});
  @override List<Object?> get props => [products, hasMore, currentPage];
}

class ProductLoadingMore extends ProductLoaded {
  ProductLoadingMore({required super.products, required super.currentPage});
}

class ProductDetailLoaded extends ProductState {
  final Product product;
  ProductDetailLoaded({required this.product});
  @override List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});
  @override List<Object?> get props => [message];
}
