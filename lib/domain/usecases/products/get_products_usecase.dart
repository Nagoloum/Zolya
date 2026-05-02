import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProductsUseCase extends UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(GetProductsParams params) {
    return repository.getProducts(
      page: params.page,
      category: params.category,
      search: params.search,
      maxPrice: params.maxPrice,
    );
  }
}

class GetProductsParams {
  final int page;
  final String? category;
  final String? search;
  final int? maxPrice;

  const GetProductsParams({this.page = 1, this.category, this.search, this.maxPrice});
}
