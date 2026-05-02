import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    String? category,
    String? search,
    int? maxPrice,
  });
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<Product>>> getMyListings();
  Future<Either<Failure, Product>> createProduct(Product product, List<String> localImagePaths, String? localVideoPath);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
}
