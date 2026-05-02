import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/favorite_repository.dart';
import 'fake_data.dart';

class FakeFavoriteRepository implements FavoriteRepository {
  final Set<String> _favoriteIds = <String>{};

  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<Product>>> getFavorites() async {
    await _latency();
    final list = FakeData.products
        .where((p) => _favoriteIds.contains(p.id))
        .toList();
    return Right(list);
  }

  @override
  Future<Either<Failure, void>> addFavorite(String productId) async {
    await _latency();
    _favoriteIds.add(productId);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String productId) async {
    await _latency();
    _favoriteIds.remove(productId);
    return const Right(null);
  }
}
