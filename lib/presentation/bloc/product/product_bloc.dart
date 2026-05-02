import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/products/get_products_usecase.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProducts;
  final ProductRepository productRepository;

  String? _activeCategory;
  String? _activeSearch;
  int? _activeMaxPrice;

  ProductBloc({required this.getProducts, required this.productRepository})
      : super(ProductInitial()) {
    on<ProductLoadRequested>(_onLoad);
    on<ProductLoadMoreRequested>(_onLoadMore);
    on<ProductFilterChanged>(_onFilterChanged);
    on<ProductDetailRequested>(_onDetailRequested);
  }

  Future<void> _onLoad(ProductLoadRequested event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    _activeCategory = event.category;
    _activeSearch = event.search;
    _activeMaxPrice = event.maxPrice;

    final result = await getProducts(GetProductsParams(
      page: 1,
      category: _activeCategory,
      search: _activeSearch,
      maxPrice: _activeMaxPrice,
    ));

    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(ProductLoaded(products: products, hasMore: products.length >= 20)),
    );
  }

  Future<void> _onLoadMore(ProductLoadMoreRequested event, Emitter<ProductState> emit) async {
    final current = state;
    if (current is! ProductLoaded || !current.hasMore) return;

    emit(ProductLoadingMore(products: current.products, currentPage: current.currentPage));

    final result = await getProducts(GetProductsParams(
      page: current.currentPage + 1,
      category: _activeCategory,
      search: _activeSearch,
      maxPrice: _activeMaxPrice,
    ));

    result.fold(
      (failure) => emit(ProductLoaded(products: current.products, hasMore: false)),
      (newProducts) => emit(ProductLoaded(
        products: [...current.products, ...newProducts],
        hasMore: newProducts.length >= 20,
        currentPage: current.currentPage + 1,
      )),
    );
  }

  Future<void> _onFilterChanged(ProductFilterChanged event, Emitter<ProductState> emit) async {
    add(ProductLoadRequested(category: event.category, maxPrice: event.maxPrice));
  }

  Future<void> _onDetailRequested(ProductDetailRequested event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await productRepository.getProductById(event.productId);
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (product) => emit(ProductDetailLoaded(product: product)),
    );
  }
}
