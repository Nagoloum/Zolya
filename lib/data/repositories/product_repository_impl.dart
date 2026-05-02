import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    String? category,
    String? search,
    int? maxPrice,
  }) async {
    try {
      final response = await apiClient.get(ApiEndpoints.products, queryParameters: {
        'page': page,
        if (category != null) 'category': category,
        if (search != null) 'search': search,
        if (maxPrice != null) 'max_price': maxPrice,
      });
      final list = (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final response = await apiClient.get(ApiEndpoints.productById(id));
      return Right(ProductModel.fromJson(response.data as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getMyListings() async {
    try {
      final response = await apiClient.get(ApiEndpoints.myProducts);
      final list = (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(
    Product product,
    List<String> localImagePaths,
    String? localVideoPath,
  ) async {
    try {

      final response = await apiClient.post(ApiEndpoints.products, data: {
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'category': product.category,
        'size': product.size,
        'condition': product.condition.name,
      });
      final created = ProductModel.fromJson(response.data as Map<String, dynamic>);

      if (localImagePaths.isNotEmpty) {
        final files = await Future.wait(
          localImagePaths.map((p) => MultipartFile.fromFile(p)),
        );
        final formData = FormData.fromMap({'files': files});
        await apiClient.postMultipart(ApiEndpoints.uploadProductMedia(created.id), formData);
      }
      return Right(created);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final response = await apiClient.put(ApiEndpoints.productById(product.id), data: {
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'category': product.category,
        'size': product.size,
        'condition': product.condition.name,
      });
      return Right(ProductModel.fromJson(response.data as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await apiClient.delete(ApiEndpoints.productById(id));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
