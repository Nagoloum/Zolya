import 'package:dartz/dartz.dart';
import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'fake_data.dart';

class FakeProductRepository implements ProductRepository {
  Future<void> _latency() => Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    String? category,
    String? search,
    int? maxPrice,
  }) async {
    await _latency();
    var list = List<Product>.from(FakeData.products);
    if (category != null) {
      list = list.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
    }
    if (search != null && search.trim().isNotEmpty) {
      final q = search.toLowerCase();
      list = list.where((p) => p.title.toLowerCase().contains(q)).toList();
    }
    if (maxPrice != null) {
      list = list.where((p) => p.price <= maxPrice).toList();
    }
    return Right(list);
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    await _latency();
    final product = FakeData.products.where((p) => p.id == id).toList();
    if (product.isEmpty) {
      return const Left(NotFoundFailure(message: 'Produit introuvable'));
    }
    return Right(product.first);
  }

  @override
  Future<Either<Failure, List<Product>>> getMyListings() async {
    await _latency();
    return const Right([]);
  }

  @override
  Future<Either<Failure, Product>> createProduct(
    Product product,
    List<String> localImagePaths,
    String? localVideoPath,
  ) async {
    await _latency();
    return Right(product);
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    await _latency();
    return Right(product);
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    await _latency();
    return const Right(null);
  }
}
